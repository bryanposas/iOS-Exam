//
//  Persistence.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import Foundation
import CoreData

typealias T = NSManagedObject

class Persistence: NSObject {
    private let persistentStorage: PersistentStorage!
    
    init(persistentStorage: PersistentStorage) {
        self.persistentStorage = persistentStorage
    }
    
    var context: NSManagedObjectContext {
        return persistentStorage.context
    }
    
    var persistentContainer: NSPersistentContainer {
        return persistentStorage.persistentContainer
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
                try context.save()
            } catch let error {
                printLog(error.localizedDescription)
            }
        }
    }
}
