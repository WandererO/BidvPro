//
//  NBBottomSheetController.swift
//  NBBottomSheet
//
//  Created by Bichon, Nicolas on 2018-10-02.
//

import UIKit

/// `NBBottomSheetController` is an object that can be used to present bottom sheets.
public class NBBottomSheetController: NSObject {

    /// Initializes a `NBBottomSheetController` object with a configuration.
    /// - Parameter configuration: The configuration struct that specifies how NBBottomSheet should be configured.
    public init(configuration: NBBottomSheetConfiguration? = nil) {
        if let configuration = configuration {
            NBConfiguration.shared = configuration
        }

        super.init()
    }

    /// Presents a bottom sheet view controller embedded in a navigation controller.
    /// - Parameters:
    ///   - viewController: The presented view controller
    ///   - containerViewController: The presenting view controller.
    public func present(_ viewController: UIViewController, on containerViewController: UIViewController, completion: (() -> Void)? = nil) {
//        if viewController is UINavigationController {
//            assertionFailure("Presenting 'UINavigationController' in a bottom sheet is not supported.")
//            return
//        }

        let bottomSheetTransitioningDelegate = NBBottomSheetTransitioningDelegate()
        viewController.transitioningDelegate = bottomSheetTransitioningDelegate
        viewController.modalPresentationStyle = .custom
        containerViewController.present(viewController, animated: true, completion: completion)
    }
}


class NBBottomSheetPresentationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return NBConfiguration.shared.animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView

        let animationDuration = transitionDuration(using: transitionContext)

        toViewController.view.transform = CGAffineTransform(translationX: 0, y: toViewController.view.frame.height)
        toViewController.view.layer.shadowColor = UIColor.black.cgColor
        toViewController.view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        toViewController.view.layer.shadowOpacity = 0.3
        toViewController.view.clipsToBounds = true

        containerView.addSubview(toViewController.view)

        UIView.animate(
            withDuration: animationDuration,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0.8,
            options: UIView.AnimationOptions.curveEaseOut,
            animations: {
                toViewController.view.transform = CGAffineTransform.identity
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            }
        )
    }
}

class NBBottomSheetDismissalTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return NBConfiguration.shared.animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!

        let animationDuration = transitionDuration(using: transitionContext)

        UIView.animate(
            withDuration: animationDuration,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0.8,
            options: UIView.AnimationOptions.curveEaseOut,
            animations: {
                fromViewController.view.transform = CGAffineTransform(translationX: 0, y: fromViewController.view.frame.height)
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}

class NBBottomSheetTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let vc = NBBottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
        vc.dismisstapWhenBackground = NBConfiguration.shared.dismisstapWhenBackground
        vc.keyboardOffset = NBConfiguration.shared.keyboardOffset
        return vc
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return NBBottomSheetPresentationTransition()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return NBBottomSheetDismissalTransition()
    }
}


