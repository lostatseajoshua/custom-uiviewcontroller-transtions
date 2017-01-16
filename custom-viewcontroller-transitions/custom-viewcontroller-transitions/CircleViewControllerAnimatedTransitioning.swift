//
//  CircleViewControllerAnimatedTransitioning.swift
//  custom-viewcontroller-transitions
//
//  Created by Joshua Alvarado on 9/22/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import UIKit

class CircleViewControllerAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
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
            let circleViewWidth = toViewVC.view.bounds.width / 2
            
            let circleView = UIView(frame: CGRect(x: toViewVC.view.bounds.midX - (circleViewWidth / 2), y: toViewVC.view.bounds.maxY, width: circleViewWidth, height: circleViewWidth))
            circleView.backgroundColor = toViewVC.view.backgroundColor
            circleView.layer.cornerRadius = circleView.frame.height / 2
            
            transitionContext.containerView.addSubview(circleView)
            transitionContext.containerView.addSubview(toViewVC.view)
            toViewVC.view.alpha = 0
            
            let relativeKeyFrameDuration = 1.0 / 3
            UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: UIViewKeyframeAnimationOptions(), animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: relativeKeyFrameDuration, animations: {
                    circleView.center = toViewVC.view.center
                })
                UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: relativeKeyFrameDuration, animations: {
                    circleView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: relativeKeyFrameDuration, animations: {
                    circleView.transform = CGAffineTransform(scaleX: 10, y: 10)
                    toViewVC.view.alpha = 1
                })
            }, completion: { completed in
                circleView.removeFromSuperview()
                transitionContext.completeTransition(completed)
            })
        } else {
            let maskViewHeight = fromViewVC.view.bounds.height * 1.1
            let maskView = UIView(frame: CGRect(x: 0, y: 0, width: maskViewHeight, height: maskViewHeight))
            maskView.center = transitionContext.containerView.center
            maskView.backgroundColor = fromViewVC.view.backgroundColor
            maskView.alpha = 1
            maskView.layer.cornerRadius = maskView.frame.height / 2
            
            transitionContext.containerView.insertSubview(maskView, aboveSubview: fromViewVC.view)
            fromViewVC.view.alpha = 0
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: .curveLinear, animations: {
                maskView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }, completion: { completed in
                    maskView.removeFromSuperview()
                    transitionContext.completeTransition(completed)
            })
            
            // when dismiss
            transitionContext.containerView.insertSubview(toViewVC.view, belowSubview: fromViewVC.view)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
}

class CircleInteractiveController: UIPercentDrivenInteractiveTransition {
    
    var interactive = false
    
    fileprivate var shouldCompleteTransition = false
    var startScale:CGFloat = 0.0
    
    func handleGesture(_ gr: UIPinchGestureRecognizer) {
        switch gr.state {
        case .began:
            startScale = gr.scale
            interactive = true
        case .changed:
            let progress = 1.0 - (gr.scale / startScale)
            print(progress)
            update(progress < 0.0 ? 0.0 : progress)
        case .cancelled:
            interactive = false
            cancel()
        case .ended:
            interactive = false
            if gr.velocity <= 0.0 {
                finish()
            }
        default:
            print("Unsupported")
        }
    }
}

// MARK: - UIViewControllerTransitioningDelegate

class PresentingViewControllerTransitionCoordinator: NSObject, UIViewControllerTransitioningDelegate {
    var interactive: UIViewControllerInteractiveTransitioning?
    
    override init() {
        super.init()
    }
    init(interactive: UIViewControllerInteractiveTransitioning) {
        super.init()
        self.interactive = interactive
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircleViewControllerAnimatedTransitioning(isPresenting: false)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircleViewControllerAnimatedTransitioning(isPresenting: true)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return nil
    }
}
