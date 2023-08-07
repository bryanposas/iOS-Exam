//
//  Movie+CoreDataProperties.swift
//  
//
//  Created by Bryan Posas on 8/7/23.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var backdrop_path: String?
    @NSManaged public var budget: Int64
    @NSManaged public var homepage: String?
    @NSManaged public var id: Int64
    @NSManaged public var original_language: String?
    @NSManaged public var original_title: String?
    @NSManaged public var overview: String?
    @NSManaged public var poster_path: String?
    @NSManaged public var release_date: String?
    @NSManaged public var revenue: Int64
    @NSManaged public var status: String?
    @NSManaged public var tagline: String?
    @NSManaged public var title: String?
    @NSManaged public var vote_average: Double
    @NSManaged public var movieResult: Movie?
    @NSManaged public var genres: NSOrderedSet?

}

// MARK: Generated accessors for genres
extension Movie {

    @objc(insertObject:inGenresAtIndex:)
    @NSManaged public func insertIntoGenres(_ value: Genre, at idx: Int)

    @objc(removeObjectFromGenresAtIndex:)
    @NSManaged public func removeFromGenres(at idx: Int)

    @objc(insertGenres:atIndexes:)
    @NSManaged public func insertIntoGenres(_ values: [Genre], at indexes: NSIndexSet)

    @objc(removeGenresAtIndexes:)
    @NSManaged public func removeFromGenres(at indexes: NSIndexSet)

    @objc(replaceObjectInGenresAtIndex:withObject:)
    @NSManaged public func replaceGenres(at idx: Int, with value: Genre)

    @objc(replaceGenresAtIndexes:withGenres:)
    @NSManaged public func replaceGenres(at indexes: NSIndexSet, with values: [Genre])

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: Genre)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: Genre)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSOrderedSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSOrderedSet)

}
