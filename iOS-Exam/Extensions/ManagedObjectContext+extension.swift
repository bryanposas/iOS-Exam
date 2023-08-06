//
//  ManagedObjectContext+extension.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func update() throws {
        if hasChanges {
            performAndWait {
                do {
                    try save()
                } catch {
                    printLog(error)
                }
            }
        }
    }
    
    func getFetchRequest<T: NSManagedObject>(withClass this: T) -> NSFetchRequest<T>? {
        if let classString = NSStringFromClass(this.classForCoder).components(separatedBy: ".").last {
            return NSFetchRequest<T>(entityName: classString)
        }
        
        return nil
    }
    
    func fetchObjects<T>(_ request: NSFetchRequest<T>) throws -> [T] where T : NSFetchRequestResult {
        var result: [T] = []
        performAndWait {
            do {
                result = try fetch(request)
            } catch let error {
                printLog(error.localizedDescription)
            }
        }
        
        return result
    }
    
    func fetchObject<T: NSManagedObject>(withType type: T,
                                              predicate: NSPredicate? = nil,
                                              andSortDescriptor sort: [NSSortDescriptor]? = nil) -> T? {
        guard let fetchRequest = getFetchRequest(withClass: type) else { return nil }
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        if let sort = sort {
            fetchRequest.sortDescriptors = sort
        }
        
        var result: T?
        performAndWait {
            do {
                result = try fetchObjects(fetchRequest).first
            } catch let error {
                printLog(error.localizedDescription)
            }
        }
        
        return result
    }
}
