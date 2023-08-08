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
    static let shared = DependencyService()
    
    let container = Container()
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return container.resolve(serviceType)
    }
    
    func start() {
        container.autoregister(PersistentStorage.self, initializer: PersistentStorage.init).inObjectScope(.container)
        container.autoregister(Persistence.self, initializer: Persistence.init).inObjectScope(.container)
        container.autoregister(CoordinatorProtocol.self, initializer: Coordinator.init).inObjectScope(.container)
        
        container.autoregister(OmdbDataProtocol.self, initializer: OmdbData.init).inObjectScope(.container)
        
        registerViewControllerAndViewModel()
    }
    
    private func registerViewControllerAndViewModel() {
        registerHomeViewModel()
        registerHomeViewController()
    }
    
    private func registerHomeViewModel() {
        container.autoregister(HomeViewModel.self, initializer: { (resolver) -> HomeViewModel in
            return HomeViewModel(with: self.container.resolve(OmdbDataProtocol.self)!, coordinator: self.container.resolve(CoordinatorProtocol.self)!)
        })
    }
    
    private func registerHomeViewController() {
        container.storyboardInitCompleted(HomeViewController.self) { _ , controller in
            controller.injectViewModel(self.container.resolve(HomeViewModel.self)!)
        }
    }
}
