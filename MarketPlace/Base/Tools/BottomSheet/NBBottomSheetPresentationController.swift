//
//  NBBottomSheetPresentationController.swift
//  NBBottomSheet
//
//  Created by Bichon, Nicolas on 2018-10-02.
//

import UIKit

class NBBottomSheetPresentationController: UIPresentationController {

    
    
    // MARK: - Properties
    /// The background view's color.
    public var dismisstapWhenBackground = true
    public var keyboardOffset : CGFloat = 0

    /// Overlay presented under the bottom sheet.
    private lazy var backgroundView: UIView? = {
        guard let containerView = containerView else {
            return nil
        }

        let backroundView = UIView(frame: containerView.bounds)

        backroundView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        backroundView.backgroundColor = NBConfiguration.shared.backgroundViewColor

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        backroundView.addGestureRecognizer(gestureRecognizer)

        return backroundView
    }()

    // MARK: - Actions

    /// Dismisses the presented view controller.
    @objc func dismiss() {
        if dismisstapWhenBackground {

            self.presentedViewController.dismiss(animated: true, completion: nil)
        }
    }

    // MARK: - UIPresentationController

    var offset : CGFloat = 0
    override func containerViewWillLayoutSubviews() {
        
        self.reloadView(with: offset)
//        guard let presentedView = presentedView, let containerView = containerView else { return }
//
//        var bottomSheetHeight: CGFloat
//
//        switch NBConfiguration.shared.sheetSize {
//        case .fixed(let height):
//            bottomSheetHeight = height
//        }
//
//        // Increase height (iPhone X/XS/11)
//        if #available(iOS 11.0, *) {
//            guard let window = UIApplication.shared.keyWindow else {
//                return
//            }
//
//            bottomSheetHeight += window.safeAreaInsets.bottom
//        }
//
//        presentedView.frame = CGRect(x: 0, y: containerView.bounds.height - bottomSheetHeight, width: containerView.bounds.width, height: bottomSheetHeight)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changOffset), name: NSNotification.Name("SetSheetOffset"), object: nil)

        if self.presentedViewController is UINavigationController {
            
            NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
            return
        }
    }
    
    @objc func changOffset(notification:NSNotification){
        let userinfo = notification.userInfo as? [String : Int]
        if let heigt = userinfo?["hight"] {
            self.reloadView(with: CGFloat(heigt))
        }
    }

    @objc func showKeyboard(notification:NSNotification){
                
        let userinfo: NSDictionary = notification.userInfo! as NSDictionary
        let nsValue = userinfo.object(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRec = nsValue.cgRectValue
        _ = keyboardRec.size.height
        self.reloadView(with: self.keyboardOffset)
    }
    @objc func hideKeyboard(notification:NSNotification){
        
        self.reloadView(with: 0)
    }
    
    func reloadView(with offset : CGFloat){
        
        guard let presentedView = presentedView, let containerView = containerView else { return }

        var bottomSheetHeight: CGFloat
        self.offset = offset
        switch NBConfiguration.shared.sheetSize {
        case .fixed(let height):
            bottomSheetHeight = height + offset
        }

        // Increase height (iPhone X/XS/11)
        if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.keyWindow else {
                return
            }

            bottomSheetHeight += window.safeAreaInsets.bottom
        }

        presentedView.frame = CGRect(x: 0, y: containerView.bounds.height - bottomSheetHeight, width: containerView.bounds.width, height: bottomSheetHeight)
    }

    

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        guard let containerView = containerView, let backgroundView = backgroundView, let presentedView = presentedView else {
            return
        }

        backgroundView.alpha = 0.0

        containerView.addSubview(backgroundView)
        containerView.addSubview(presentedView)

        let showBackgroundView = { (_: UIViewControllerTransitionCoordinatorContext) -> Void in
            backgroundView.alpha = 1.0
        }

        presentingViewController.transitionCoordinator?.animate(alongsideTransition: showBackgroundView, completion: nil)
    }

    override open func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            backgroundView?.removeFromSuperview()
        }
    }

    override open func dismissalTransitionWillBegin() {
        guard let backgroundView = backgroundView else {
            return
        }

        let hideBackgroundView = { (_: UIViewControllerTransitionCoordinatorContext) -> Void in
            backgroundView.alpha = 0.0
        }

        presentingViewController.transitionCoordinator?.animate(alongsideTransition: hideBackgroundView, completion: nil)
    }

    override open func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            backgroundView?.removeFromSuperview()
        }
    }

    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        guard let containerView = containerView, let backgroundView = backgroundView else {
            return
        }

        let resetBackgroundViewFrame: ((UIViewControllerTransitionCoordinatorContext) -> Void) = { _ in
            backgroundView.frame = containerView.bounds
        }

        coordinator.animate(alongsideTransition: resetBackgroundViewFrame, completion: nil)
    }
}
