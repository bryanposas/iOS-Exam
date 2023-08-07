//
//  SimpleJsonParser.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import Foundation
import CoreData

class SimpleJSONParser<T: Codable> {
    public typealias ModelType = T
    private let jsonDecoder: JSONDecoder

    public init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
    }
    
    required init() {
        self.jsonDecoder = JSONDecoder()
    }
    
    func parse(_ data: Data?, inContext context: NSManagedObjectContext) throws -> ModelType? {
        guard let data = data else { return nil }
        let isCodable = (T.self as Any) is Codable.Type
        if !isCodable { return nil }
        let response = try jsonDecoder.decodeWithContext(T.self, from: data, context: context)
        return response
    }
}
