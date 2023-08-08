//
//  Storyboarded.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import UIKit
import SwinjectStoryboard

protocol Storyboarded {
    static func instantiate(with storyboard: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(with storyboard: String = "Main") -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)
        
        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]
        
        // load our storyboard
        var swinjectStoryboard = SwinjectStoryboard.create(name: storyboard, bundle: Bundle.main)
        
        // load swinject container
        swinjectStoryboard = SwinjectStoryboard.create(name: storyboard, bundle: Bundle.main, container: DependencyService.shared.container)
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return swinjectStoryboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
