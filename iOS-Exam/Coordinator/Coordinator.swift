//
//  Coordinator.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import UIKit

enum NavigationType {
    case Push,
         Present
}

protocol CoordinatorProtocol: AnyObject {
    func goToVC(vc: UIViewController, navigate: NavigationType, shouldAnimate: Bool)
    var window: UIWindow! { get }
}

class Coordinator: NSObject, CoordinatorProtocol {
    var navigationController: UINavigationController!
    var window: UIWindow!
    
    override init() {
        super.init()
        
        self.boostrap()
    }
    
    private func boostrap() {
        self.navigationController = UINavigationController()
        
        let newWindow = UIWindow(frame: UIScreen.main.bounds)
        newWindow.makeKeyAndVisible()
        newWindow.rootViewController = navigationController
        self.window = newWindow
        
        navigationController.delegate = self
        
        goToVC(vc: HomeViewController.instantiate())
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
