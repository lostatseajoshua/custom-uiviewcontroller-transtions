//
//  CurlUpViewControllerAnimatedTransitioning.swift
//  custom-viewcontroller-transitions
//
//  Created by Joshua Alvarado on 9/22/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import UIKit

class CurlUpViewControllerAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    let presenting: Bool
    
    init(isPresenting: Bool) {
        presenting = isPresenting
        super.init()
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to), let fromViewVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }
        
        transitionContext.containerView.insertSubview(toViewVC.view, belowSubview: fromViewVC.view)
        
        UIView.transition(from: fromViewVC.view, to: toViewVC.view, duration: transitionDuration(using: transitionContext), options: .transitionCurlUp, completion: {completed in
            fromViewVC.view.removeFromSuperview()
            // when presenting
            transitionContext.completeTransition(completed)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
}
