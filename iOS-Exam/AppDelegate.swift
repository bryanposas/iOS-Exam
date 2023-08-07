//
//  AppDelegate.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var dependencyService: DependencyService?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initDependencyService()
        return true
    }
    
    private func initDependencyService() {
        if dependencyService == nil {
            dependencyService = DependencyService()
            dependencyService!.start()
        }
    }
}

