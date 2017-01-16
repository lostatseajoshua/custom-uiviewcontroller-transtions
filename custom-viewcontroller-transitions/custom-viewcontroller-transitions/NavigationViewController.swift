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
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // Provide the animator object
        return PushPopViewControllerAnimatedTransitioning(isPresenting: operation == .push)
    }
}
