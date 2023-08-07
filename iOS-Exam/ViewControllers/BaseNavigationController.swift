//
//  BaseNavigationController.swift
//  iOS-Exam
//
//  Created by Bryan Posas on 8/7/23.
//

import Foundation
import SwinjectStoryboard

class BaseNavigationController: UINavigationController, Storyboarded {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarHidden(true, animated: true)
    }
}
