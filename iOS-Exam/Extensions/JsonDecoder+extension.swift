//
//  JsonDecoder+extension.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import Foundation
import CoreData

extension JSONDecoder {
    func decodeWithContext<T>(_ type: T.Type, from data: Data, context: NSManagedObjectContext) throws -> T where T : Decodable {
        self.userInfo[CodingUserInfoKey.context!] = context
        return try self.decode(type, from: data)
    }
}
