//
//  MovieResult+CoreDataClass.swift
//  
//
//  Created by Bryan Posas on 8/7/23.
//
//

import Foundation
import CoreData

@objc(MovieResult)
public class MovieResult: NSManagedObject, Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

    }
    
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
              let context = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "MovieResult", in: context)
            else {
                self.init()
                return
        }
        
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: nil)
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            page = try container.decodeIfPresent(Int32.self, forKey: .page) ?? 0
            totalPages = try container.decodeIfPresent(Int32.self, forKey: .total_pages) ?? 0
            totalResults = try container.decodeIfPresent(Int64.self, forKey: .total_results) ?? 0
            movies = NSOrderedSet(array: try container.decode([Movie].self, forKey: .results))
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case page
        case total_pages
        case total_results
        case results
    }
}
