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
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewVC = transitionContext.viewController(forKey: .to), let fromViewVC = transitionContext.viewController(forKey: .from) else {
            return
        }
        
        if presenting {
            // when presenting
           transitionContext.containerView.addSubview(toViewVC.view)
            
            toViewVC.view.alpha = 0
            // fade in on presenting
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toViewVC.view.alpha = 1
                }, completion: { completed in
                    transitionContext.completeTransition(completed)
            })
        } else {
            let numberOfBlinks = 5
            let duration = transitionDuration(using: transitionContext)
            
            // fade out and in on dismissing
            UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: {
                var time = 0.0
                for _ in 0...numberOfBlinks {
                    UIView.addKeyframe(withRelativeStartTime: time, relativeDuration: duration / Double(numberOfBlinks), animations: {
                        fromViewVC.view.frame.origin.x -= toViewVC.view.frame.width
                    })
                    time += (duration / Double(numberOfBlinks)) / duration
                }
                }, completion: { completed in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled && completed)
            })
            
            // when dismiss
            transitionContext.containerView.insertSubview(toViewVC.view, belowSubview: fromViewVC.view)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        // clean up work if needed
    }
}
