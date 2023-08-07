//
//  AppDelegate.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var dependencyService: DependencyService?
    var coordinator: CoordinatorProtocol?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        initDependencyService()
        initCoordinator()
        
        return true
    }
    
    private func initDependencyService() {
        if dependencyService == nil {
            dependencyService = DependencyService()
            dependencyService!.start()
        }
    }
    
    private func initCoordinator() {
        if let coordinator = dependencyService?.resolver.resolve(CoordinatorProtocol.self) {
            self.coordinator = coordinator
            self.window = self.coordinator?.window
        }
    }
    
}

