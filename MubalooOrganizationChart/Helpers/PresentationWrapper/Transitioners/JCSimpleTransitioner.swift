//
//  Created by João Carreira on 29/05/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

class JCSimpleAnimatedTransitioner: NSObject {
    var isPresentation: Bool = false
}

extension JCSimpleAnimatedTransitioner: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // VC visible at the start of the transition
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let fromView = fromViewController!.view
        // VC that will be visible at the end of the transition
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let toView = toViewController!.view
        
        // if the transition is a presentation (and not a dismissal) we'll add it to the container's view
        let containerView: UIView = transitionContext.containerView()!
        if isPresentation {
            containerView.addSubview(toView)
        }
        
        let animatingViewController = isPresentation ? toViewController : fromViewController
        let animatingView = animatingViewController!.view
        
        // start and end positions of the view (appeared and dismissed frames)
        let appearedFrame = transitionContext.finalFrameForViewController(animatingViewController!)
        var dismissedFrame = appearedFrame
        dismissedFrame.origin.y += dismissedFrame.size.height
        
        let initialFrame = isPresentation ? dismissedFrame : appearedFrame
        let finalFrame = isPresentation ? appearedFrame : dismissedFrame
        animatingView.frame = initialFrame
        
        UIView.animateWithDuration(transitionDuration(transitionContext),
                                   delay:0.0,
                                   usingSpringWithDamping:300.0,
                                   initialSpringVelocity:5.0,
                                   options:[.AllowUserInteraction, .BeginFromCurrentState],
                                   animations:{
                                        // animating's view frame is the final frame, no matter if it's presenting or dismissing
                                        animatingView.frame = finalFrame
                                    }, completion:{ (value: Bool) in
                                        // we only remove when it's a dismissal
                                        if !self.isPresentation {
                                            fromView.removeFromSuperview()
                                        }
                                        // setting the transition as finished
                                        transitionContext.completeTransition(true)
                                    })
    }
}

class JCSimpleTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    // returns the animator object (object responsible for the animation and duration when presenting and dismissing a VC)
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        return JCSimplePresentationController(presentedViewController:presented, presentingViewController:presenting)
    }
    
    // when the VC is being presentd
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = JCSimpleAnimatedTransitioner()
        animationController.isPresentation = true
        return animationController
    }
}
