//
//  Movie+CoreDataClass.swift
//  
//
//  Created by Bryan Posas on 8/7/23.
//
//

import Foundation
import CoreData

public class Movie: NSManagedObject, Codable {

    enum CodingKeys: CodingKey {
        case backdrop_path
        case budget
        case genres
        case homepage
        case id
        case overview
        case poster_path
        case revenue
        case release_date
        case status
        case tagline
        case title
        case vote_average
        case adult
        case original_language
        case original_title
    }
    
    enum GenresKey: String, CodingKey {
        case id
        case title
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    }
    
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let entity = NSEntityDescription.entity(forEntityName: "Movie", in: PersistentStorage.shared.context)
            else {
                self.init()
                return
        }
        
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: nil)
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            adult = try container.decodeIfPresent(Bool.self, forKey: .adult) ?? false
            backdrop_path = try container.decodeIfPresent(String.self, forKey: .backdrop_path)
            poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path)
            id = try container.decodeIfPresent(Int64.self, forKey: .id) ?? 0
            original_language = try container.decodeIfPresent(String.self, forKey: .original_language)
            original_title = try container.decodeIfPresent(String.self, forKey: .original_title)
            overview = try container.decodeIfPresent(String.self, forKey: .overview)
            release_date = try container.decodeIfPresent(String.self, forKey: .release_date)
            title = try container.decodeIfPresent(String.self, forKey: .title)
            vote_average = try container.decodeIfPresent(Double.self, forKey: .vote_average) ?? 0.0
            budget = try container.decodeIfPresent(Int64.self, forKey: .budget) ?? 0
            homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
            revenue = try container.decodeIfPresent(Int64.self, forKey: .revenue) ?? 0
            status = try container.decodeIfPresent(String.self, forKey: .status)
            tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
            genres = NSOrderedSet(array: try container.decodeIfPresent([Genre].self, forKey: .genres) ?? [])
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
