//
//  BaseAlertVC.swift
//  MarketPlace
//
//  Created by 世文 on 2023/7/21.
//

import UIKit
import HWPanModal
class BaseAlertVC: UIViewController {
    
    /// 取消回调
    var cancelBlock: BlockWithNone?
    /// 确定回调
    var confirmBlock: BlockWithNone?
    
    ///带返回值
    var confirmDataBlock : BlockWithParameters<String>?
    /// 隐藏动画结束后回调
    var hideAnimateEndBlock: BlockWithNone?
    
    /// 没有数据视图
    lazy var noDataView: NoDataView = {
        let noDataView = NoDataView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0))
        return noDataView
    }()
    
    /// 蒙层按钮
    lazy var blankBtn: UIButton = {
        let btn = UIButton(frame: self.view.bounds)
        btn.addTarget(self, action: #selector(blankBtnClick), for: .touchUpInside)
        return btn
    }()
    
    /// 点击蒙层是否可以使视图消失
    var isClickBlankDisappear: Bool = false {
        didSet {
            if isClickBlankDisappear {
                self.view.addSubview(blankBtn)
                self.view.sendSubviewToBack(blankBtn)
            }
        }
    }
    
    /// 页数
    var page = 1
    
    /// 每页加载数量
    var pageSize = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    /// 显示视图
    func show() {
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .custom
        CommonUtil.getCurrentVC()?.present(self, animated: true, completion: nil)
    }
    
    func showWithNav() {
        let nav: BaseNavigationController = BaseNavigationController(rootViewController: self)
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .custom
        nav.view.backgroundColor = .clear
        CommonUtil.getCurrentVC()?.present(nav, animated: true, completion: nil)
    }
    
    func pan_show() {
        CommonUtil.getCurrentVC()?.presentPanModal(self)
    }
    
    /// 隐藏视图
    func hide() {
        self.dismiss(animated: true) {
            self.hideAnimateEndBlock?()
        }
    }
  
    func hide(completion: BlockWithNone?) {
        self.dismiss(animated: true) {
            self.hideAnimateEndBlock?()
            completion?()
        }
    }
    
    func hide<T>(param: T, completion: BlockWithParameters<T>?) {
        self.dismiss(animated: true) {
            self.hideAnimateEndBlock?()
            completion?(param)
        }
    }
    
    @objc func blankBtnClick() {
        hide()
    }
    
    /// 显示空白占位符
    func showNoDataView(superView: UIView = AppWindow, imageName: String = "", title: String = "缺省-无数据", top: CGFloat = 0) {

//        noDataView.setupData(imageName: imageName, title: title)
//
//        if top == 0 {
//            noDataView.center = superView.center
//        } else {
//            noDataView.frame = CGRect(x: 0, y: top, width: noDataView.view_width, height: noDataView.view_height)
//        }
//
//        if noDataView.superview == nil {
//            superView.addSubview(noDataView)
//        }
    }
    
    /// 隐藏空白占位符
    func hideNoDataView() {
        noDataView.removeFromSuperview()
    }
    
    deinit {
        PLog("\(self.className) deinit")
    }
    

}
