//
//  SimpleJsonParser.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import Foundation

class ParserType {
    typealias ModelType = Any

    required init() {}
    
    func parse(_ data: Data?) throws -> ModelType? {
        return nil
    }
}

class SimpleJSONParser<T: Codable>: ParserType {
    public typealias ModelType = T
    private let jsonDecoder: JSONDecoder

    public init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
    }
    
    required init() {
        self.jsonDecoder = JSONDecoder()
    }
    
    override func parse(_ data: Data?) throws -> ParserType.ModelType? {
        guard let data = data else { return nil }
        let isCodable = (T.self as Any) is Codable.Type
        if !isCodable { return nil }
        let response = try jsonDecoder.decodeWithContext(T.self, from: data)
        return response
    }
}
