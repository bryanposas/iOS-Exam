//
//  Coordinator.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import UIKit

enum NavigationType {
    case Push, Present
}

protocol CoordinatorProtocol: AnyObject {
    func goToVC(vc: UIViewController, navigate: NavigationType, shouldAnimate: Bool)
}

class Coordinator: NSObject, CoordinatorProtocol {
    var navigationController: UINavigationController!
    
    override init() {
        super.init()
        
        self.boostrap()
    }
    
    private func boostrap() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if let vc = DependencyService.shared.resolve(HomeViewController.self) {
                
                self.navigationController = vc.navigationController
                
                let newWindow = UIWindow(frame: UIScreen.main.bounds)
                newWindow.makeKeyAndVisible()
                newWindow.rootViewController = navigationController
                navigationController.delegate = self
                
                appDelegate.window = newWindow
                
                goToVC(vc: vc)
            }
        }
        
    }
    
    /// Navigates to the passed view controller. Parameter action and actionValue are used for deep linking
    func goToVC(vc: UIViewController,
                navigate: NavigationType = .Push,
                shouldAnimate: Bool = true) {
        
        if navigate == .Push {
            navigationController.pushViewController(vc, animated: shouldAnimate)
        } else {
            // If navigation controller is currently presenting
            guard let topMost = navigationController.viewControllers.last else { return }
            
            // For ipad, if sourceview is nil it will cause a crash
            if let ppc = vc.popoverPresentationController, ppc.sourceView == nil {
                ppc.sourceView = topMost.view
                ppc.sourceRect = topMost.view.bounds
            }
            
            topMost.present(vc, animated: shouldAnimate)
        }
    }
}

extension Coordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let toViewController = navigationController.transitionCoordinator?.viewController(forKey: .to) else {
            return
        }
        
        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(toViewController) {
            return
        }
    }
}

extension Coordinator {
    func goToHomeViewController() {
//        guard let vc = DependencyService.shared.resolve(HomeViewController.self) else { return }
        goToVC(vc: HomeViewController.instantiate())
    }
}
