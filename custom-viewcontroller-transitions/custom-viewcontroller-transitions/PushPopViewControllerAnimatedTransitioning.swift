//
//  PushPopViewControllerAnimatedTransitioning.swift
//  custom-viewcontroller-transitions
//
//  Created by Joshua Alvarado on 9/22/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import UIKit

class PushPopViewControllerAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    let presenting: Bool
    
    init(isPresenting: Bool) {
        presenting = isPresenting
        super.init()
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey), fromViewVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey), containerView = transitionContext.containerView() else {
            return
        }
        
        if presenting {
            // when presenting
            containerView.addSubview(toViewVC.view)
            
            toViewVC.view.alpha = 0
            // fade in on presenting
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                toViewVC.view.alpha = 1
                }, completion: { completed in
                    transitionContext.completeTransition(completed)
            })
        } else {
            let numberOfBlinks = 5
            let duration = transitionDuration(transitionContext)
            
            // fade out and in on dismissing
            UIView.animateKeyframesWithDuration(duration, delay: 0, options: .CalculationModeLinear, animations: {
                var time = 0.0
                for _ in 0...numberOfBlinks {
                    UIView.addKeyframeWithRelativeStartTime(time, relativeDuration: duration / Double(numberOfBlinks), animations: {
                        fromViewVC.view.frame.origin.x -= toViewVC.view.frame.width
                    })
                    time += (duration / Double(numberOfBlinks)) / duration
                }
                }, completion: { completed in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled() && completed)
            })
            
            // when dismiss
            containerView.insertSubview(toViewVC.view, belowSubview: fromViewVC.view)
        }
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2.0
    }
    
    func animationEnded(transitionCompleted: Bool) {
        // clean up work if needed
    }
}
