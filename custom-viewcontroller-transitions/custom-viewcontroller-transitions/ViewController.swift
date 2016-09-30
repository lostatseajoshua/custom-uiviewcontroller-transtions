//
//  ViewController.swift
//  custom-viewcontroller-transitions
//
//  Created by Joshua Alvarado on 9/22/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Create the presenting coordinator
    let presentingCoordinator = PresentingViewControllerTransitionCoordinator()
    // Create a varible for the interactive controller
    var interactiveCoordinator: CircleInteractiveController?
    
    lazy var swipeGesture: UIPinchGestureRecognizer = {
        let gesture = UIPinchGestureRecognizer(target: self, action: #selector(handleGesture))
        return gesture
    }()
    
    struct Identifier {
        static let mainStoryboardId = "Main"
        static let modalPresentationControllerId = "ModalPresentationViewControllerId"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the gesture recognizer to the view
        view.addGestureRecognizer(swipeGesture)
    }
    
    @IBAction func presentModal(sender: UIButton) {
        // create the to view controller
        let toVC = getModalPresentationVC()
        // set the transitioning delegate
        toVC.transitioningDelegate = presentingCoordinator
        // present the view animated
        presentViewController(toVC, animated: true, completion: nil)
    }
    
    func handleGesture(sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .Began:
            // create the to view controller
            let toVC = getModalPresentationVC()
            // set the transitioning delegate
            toVC.transitioningDelegate = presentingCoordinator
            // create the interactive coordinator
            interactiveCoordinator = CircleInteractiveController()
            // set the interactive to pass through the delegate
            presentingCoordinator.interactive = interactiveCoordinator
            // present the view animated
            presentViewController(toVC, animated: true, completion: nil)
        case .Cancelled, .Ended, .Failed:
            interactiveCoordinator?.finishInteractiveTransition()
            presentingCoordinator.interactive = nil
            interactiveCoordinator = nil
        default:
            break
        }
        interactiveCoordinator?.handleGesture(sender)
    }
    
    // - MARK: Utility
    func getModalPresentationVC() -> UIViewController {
        return UIStoryboard(name: Identifier.mainStoryboardId, bundle: nil).instantiateViewControllerWithIdentifier(Identifier.modalPresentationControllerId)
    }
}
