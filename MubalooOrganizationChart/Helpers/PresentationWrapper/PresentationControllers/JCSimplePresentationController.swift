//
//  Created by João Carreira on 29/05/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

class JCSimplePresentationController: UIPresentationController {

    // used as the chrome
    var dimmingView: UIView = UIView()
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        dimmingView.backgroundColor = UIColor.blackColor()
        dimmingView.alpha = 0.0
    }
    
    override func presentationTransitionWillBegin() {
        dimmingView.frame = self.containerView!.bounds
        dimmingView.alpha = 0.0
        containerView!.insertSubview(dimmingView, atIndex:0)
        
        let coordinator = presentedViewController.transitionCoordinator()
        if coordinator != nil {
            coordinator!.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.dimmingView.alpha = 0.7
                }, completion:nil)
        } else {
            dimmingView.alpha = 1.0
        }
    }
    
    override func dismissalTransitionWillBegin() {
        let coordinator = presentedViewController.transitionCoordinator()
        if coordinator != nil {
            coordinator!.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext) -> Void in
                self.dimmingView.alpha = 0.0
                }, completion: nil)
        } else {
            dimmingView.alpha = 0.0
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        dimmingView.frame = CGRectMake(0, 0, containerView!.frame.width, containerView!.frame.height)
        presentedView()?.frame = CGRectMake(0, containerView!.frame.height / 2, containerView!.frame.width, containerView!.frame.height / 2)
    }
    
    override func shouldPresentInFullscreen() -> Bool {
        return true
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        let animationController = JCSimpleAnimatedTransitioner()
        animationController.isPresentation = false
        return animationController
    }
}

extension JCSimplePresentationController: UIAdaptivePresentationControllerDelegate {
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.OverFullScreen
    }
}
