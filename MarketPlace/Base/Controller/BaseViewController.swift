//
//  BaseViewController.swift
//  MarketPlace
//
//  Created by tanktank on 2022/4/21.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    var isHiddenStatrsBarHidden : Bool = false
    let disposeBag = DisposeBag()
    lazy var titleLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackTextColor
        lab.font = FONT_B(size: 22)
        return lab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.init()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        self.view.backgroundColor = kMainBackgroundColor
        self.view.addSubview(titleLab)
//        titleLab.backgroundColor = .white
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userManager.backToHomePage = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self

    }
}
// MARK: - QMUIKit
extension BaseViewController:UIGestureRecognizerDelegate {

     func forceEnableInteractivePopGestureRecognizer() -> Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return self.isHiddenStatrsBarHidden
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func backTo(vcClass: AnyClass){
        
        var backVC:UIViewController?
        if let vcs = self.navigationController?.viewControllers{
            for vc in vcs{
                if vc.isKind(of: vcClass){
                    backVC = vc
                    break
                }
            }
        }
        if let backVC {
            self.navigationController?.popToViewController(backVC, animated: true)
        }else{
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {

           
//           if self.isKind(of: CCTabBaseController.self){
//               return false
//           }else{
////               self.navigationController?.popViewController(animated: true)
//               return true
//           }
                  
        return true
//           return slideEnabled && ((self.navigationController?.children.count ?? 0) > 1)
       }

}
