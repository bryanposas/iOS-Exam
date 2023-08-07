//
//  PersistentStorage.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import Foundation
import CoreData

class PersistentStorage {
    // MARK: - Core Data stack
    var persistentContainer: NSPersistentContainer!
    var context: NSManagedObjectContext!
    
    init() {
        bootstrap()
    }
    
    private func bootstrap() {
        self.persistentContainer = createPersistentContainer()
        self.context = createContext()
    }
    
    private func createPersistentContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: Constants.dbName)
        // For light weight core data migration
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as? NSError {
                printLog(error)
            }
        })
        
        return container
    }
    
    private func createContext() -> NSManagedObjectContext {
        let managedContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        managedContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        
        return managedContext
    }
    
    func newPrivateContext() -> NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        context.automaticallyMergesChangesFromParent = true
        
        return context
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
    
}
