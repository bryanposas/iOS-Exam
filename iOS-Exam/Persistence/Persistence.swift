//
//  Persistence.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import Foundation
import CoreData

typealias T = NSManagedObject

class CoreDataClass: NSObject {
    lazy var persistentContainer: NSPersistentContainer = {
        return PersistentStorage.shared.persistentContainer
    }()
    
    lazy var context: NSManagedObjectContext = {
        return PersistentStorage.shared.context
    }()
    
    func saveContext() {
        if context.hasChanges {
            context.performAndWait {
                do {
                    try context.save()
                } catch let error as NSError {
                    printLog(error)
                    NotificationCenter.default.post(name: Notification.Name("locate2uCoreDataSaveContextError"), object: "Coredata error \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func newPrivateContext() -> NSManagedObjectContext {
        return PersistentStorage.shared.newPrivateContext()
    }
    
    func fetch<T: NSManagedObject>(_ type : T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, isSingleResult: Bool = false, isPrivateContext: Bool = true) -> [T] {
        let request = T.fetchRequest()
        if let predicate = predicate {
            request.predicate = predicate
        }
        if let sortDescriptors = sortDescriptors {
            request.sortDescriptors = sortDescriptors
        }
        if isSingleResult {
            request.fetchLimit = 1
        }
        
        var results: [T] = []
        if isPrivateContext {
            let newPrivateContext = newPrivateContext()
            newPrivateContext.performAndWait {
                do {
                    results = try newPrivateContext.fetch(request) as? [T] ?? []
                } catch let error {
                    printLog(error.localizedDescription)
                }
            }
        } else {
            do {
                results = try context.fetchObjects(request) as? [T] ?? []
            } catch let error {
                printLog(error.localizedDescription)
            }
        }
        
        return results
    }
    
    /// Save changes to core data store
    func saveObject(_ object: NSManagedObject) {
        guard let context = object.managedObjectContext else { return }
        
        if context.hasChanges {
            context.performAndWait {
                do {
                    try context.save()
                } catch let error as NSError {
                    printLog(error)
                }
            }
        }
    }
    
    /// Delete all entries inside of core data store
    func deleteAll(of entity: String) {
        // Specify a batch to delete with a fetch request
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
        fetchRequest = NSFetchRequest(entityName: entity)
        
        // Create a batch delete request for the fetch request
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        // Specify the result of the NSBatchDeleteRequest should be the NSManagedObject IDs for the deleted objects
        deleteRequest.resultType = .resultTypeObjectIDs
        
        let context = context
        context.perform {
            do {
                // Perform the batch delete
                let batchDelete = try context.execute(deleteRequest) as? NSBatchDeleteResult
                
                guard let deleteResult = batchDelete?.result
                        as? [NSManagedObjectID]
                else { return }
                
                let deletedObjects: [AnyHashable: Any] = [
                    NSDeletedObjectsKey: deleteResult
                ]
                
                // Merge the delete changes into the managed
                // object context
                NSManagedObjectContext.mergeChanges(
                    fromRemoteContextSave: deletedObjects,
                    into: [context]
                )
                try context.execute(deleteRequest)
                try context.save()
            } catch let error as NSError {
                printLog(error.localizedDescription)
            }
        }
    }
    
    func getCount(fromFetchRequest request: NSFetchRequest<NSManagedObject>) -> Int {
        var count = 0
        context.performAndWait {
            do {
                count = try context.count(for: request)
            } catch let error as NSError {
                printLog(error)
            }
        }
        
        return count
    }
    
    func delete(_ object: NSManagedObject) {
        guard let context = object.managedObjectContext else { return }
        
        context.performAndWait {
            do {
                context.delete(object)
                try context.update()
            } catch let error {
                printLog(error.localizedDescription)
            }
        }
    }
}
