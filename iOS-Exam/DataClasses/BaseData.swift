//
//  BaseData.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import Foundation

class BaseData: NSObject {
    var persistence: Persistence
    
    init(withPersistence persistence: Persistence) {
        self.persistence = persistence
    }
}
