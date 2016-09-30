//
//  NavigationViewController.swift
//  custom-viewcontroller-transitions
//
//  Created by Joshua Alvarado on 9/21/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // set the NavigationController delegate to provide the animator object
        delegate = self
    }
}

extension NavigationViewController: UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // Provide the animator object
        return PushPopViewControllerAnimatedTransitioning(isPresenting: operation == .Push)
    }
}
