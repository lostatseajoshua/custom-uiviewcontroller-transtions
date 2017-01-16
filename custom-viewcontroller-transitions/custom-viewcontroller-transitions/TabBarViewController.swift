//
//  TabBarViewController.swift
//  custom-viewcontroller-transitions
//
//  Created by Joshua Alvarado on 9/21/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // set TabBarController delegate to provide the animator object
        delegate = self
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // return the animator for the tab bar controller
        return CurlUpViewControllerAnimatedTransitioning(isPresenting: true)
    }
}
