//
//  Log.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import Foundation

/// Print
func printLog(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    items.forEach {
        Swift.print("\(file.split(separator: "/").last ?? ""): \(function) ln. \(line): \($0)", separator: separator, terminator: terminator)
    }
    #endif
}
