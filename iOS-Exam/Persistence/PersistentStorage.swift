//
//  PersistentStorage.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import Foundation
import CoreData

class PersistentStorage: NSObject {
    static let shared = PersistentStorage()
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        return createPersistentContainer()
    }()
    
    lazy var context: NSManagedObjectContext = {
        let managedContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        managedContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        
        return managedContext
    }()
    
    func newPrivateContext() -> NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        context.automaticallyMergesChangesFromParent = true
        
        return context
    }
    
    func createPersistentContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "ios-exam")
        let storeURL = storeURL(for: "group.com.ios-exam", databaseName: "ios-exam")
        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        storeDescription.shouldMigrateStoreAutomatically = true
        storeDescription.shouldInferMappingModelAutomatically = true
        container.persistentStoreDescriptions = [storeDescription]
        
        // For light weight core data migration
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as? NSError {
                printLog(error)
            }
        })
        
        return container
    }
    
    func removeAllObjectOfEntity(_ entity: String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error as NSError {
            printLog(error.localizedDescription)
        }
    }
    
    private override init() {
        super.init()
    }
    
    private func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }

        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}
