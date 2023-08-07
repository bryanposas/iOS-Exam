//
//  Genre+CoreDataClass.swift
//  
//
//  Created by Bryan Posas on 8/7/23.
//
//

import Foundation
import CoreData

@objc(Genre)
public class Genre: NSManagedObject, Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    }
    
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
              let context = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "Genre", in: context)
            else {
                self.init()
                return
        }
        
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: nil)
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            id = try container.decodeIfPresent(Int64.self, forKey: .id) ?? 0
            title = try container.decodeIfPresent(String.self, forKey: .title)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
    }
}
