//
//  DependencyService.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import UIKit
import Swinject
import SwinjectAutoregistration
import SwinjectStoryboard

class DependencyService: NSObject {
    private let container = Container()
    
    // MARK: The order for which each classes are instantiated is highly important. Take good care when adding a new dependency to a class that that dependency will be instantiated first before the class that needs said dependency or when adding a new class that all of its dependencies are isntantiated first before instantiating said class in this function. Otherwise, you will encounter a circular dependency crash.
    func start() {
        container.autoregister(OmdbDataProtocol.self, initializer: OmdbData.init)
        
        registerViewControllerAndViewModel()
    }
    
    private func registerViewControllerAndViewModel() {
        registerHomeViewController()
    }
    
    private func registerHomeViewModel() {
        container.autoregister(HomeViewModel.self, initializer: { (resolver) -> HomeViewModel in
            return HomeViewModel(with: self.container.resolve(OmdbDataProtocol.self)!)
        })
    }
    
    private func registerHomeViewController() {
        registerHomeViewModel()
        container.storyboardInitCompleted(HomeViewController.self) { _ , controller in
            controller.injectViewModel(self.container.resolve(HomeViewModel.self)!)
        }
    }
}
