//
//  WidgetUtil.swift
//  Gregarious
//
//  Created by GoPay on 2021/3/25.
//

import Foundation
import UIKit
import SnapKit


public let Color999999 = UIColor(hexString: "#999999") // 灰色字体
public let Color000000 = UIColor(hexString:"#000000") // 黑色字体
public let ColorMain = UIColor(hexString:"#17BD96") // 主题色
public let Color666666 = UIColor(hexString:"#666666") // 灰色字体
/// 默认弹窗类型
enum DefaultAlertType {
    case `default`
    case sure
}


class WidgetUtil {
    
    static let share = WidgetUtil()
    
    var isShow = false
//
//    lazy var style: ToastStyle = {
//        var style = ToastStyle()
//        style.messageFont = UIFont.PingFangSCRegular(size: 14)
//        style.messageColor = .white
//        style.messageAlignment = .center
//        style.cornerRadius = 10
//        style.horizontalPadding = 16
//        style.verticalPadding = 14
//        style.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 0.89)
//        return style
//    }()
//
    lazy var loadingBgView: UIView = {
        let bgViw = UIView()
        bgViw.backgroundColor = .clear
        return bgViw
    }()
 
    
//    lazy var  alertShow :ShowTipVC = {
//        let alertShow =  ShowTipVC.fromStoryboard(name: "Alert")
//        return alertShow
//    }()
    
    private init() {
    }
    
    func showLoading(view: UIView = AppWindow, top: CGFloat? = nil) {
 
    }
    
    func hideLoading(view: UIView = AppWindow) {
        loadingBgView.removeFromSuperview()
        isShow = false
    }
    
//
//      func showLoading(text : String = "加载中...", type : ShowAlertType = .default) {
//          if isShow == true{
//              alertShow.setupAlertData(text: text,type: type)
//              return
//          }
//          alertShow.show()
//          alertShow.setupAlertData(text: text,type: type)
//          isShow = true
//    }
    
//     func hiddenLoading() {
//          isShow = false
//          alertShow.hide()
//     }
//
//
//    func showTip(str: String, view: UIView = AppWindow, afterDelay: TimeInterval = DefaultTipDuration) {
//        guard !stringIsEmpty(str: str) else {
//            return
//        }
//        view.makeToast(str, duration: afterDelay, position: .center)
//        isShow = false
//    }
//
//    func showToast(str: String, type: ToastType, afterDelay: TimeInterval = DefaultTipDuration) {
        
//        guard toastView.superview == nil,
//              !stringIsEmpty(str: str) else {
//            return
//        }
//
//        toastView.show(title: str, type: type)
//        AppWindow.addSubview(toastView)
//        DispatchAfter(after: afterDelay) {
//            self.toastView.removeFromSuperview()
//        }
//        isShow = false
//    }
    
    func showSkeletonView(superView: UIView = AppWindow) {
//        skeletonView.alpha = 1
//        superView.addSubview(skeletonView)
//        skeletonView.snp.makeConstraints { make in
//            make.top.equalTo(superView).offset(StatusBarAndNavigationBarHeight)
//            make.leading.trailing.bottom.equalTo(superView)
//        }
    }
    
    func hideSkeletonView() {
//        UIView.animate(withDuration: 0.5) {
//            self.skeletonView.alpha = 0
//        } completion: { finish in
//            self.skeletonView.removeFromSuperview()
//        }
    }

}

extension WidgetUtil {

    /// 默认弹窗
    class func showDefaultAlert(title: String,
                                subtitle: String = "",
                                cancelStr: String = "取消",
                                cancelColor: UIColor = Color999999,
                                confirmStr: String = "确定",
                                confirmColor: UIColor = ColorMain,
                                topImgName:String = "",
                                cancelBlock: BlockWithNone? = nil,
                                confirmBlock: BlockWithNone? = nil,
                                hideAnimateEndBlock: BlockWithNone? = nil) {

        let alertModel = DefaultAlertModel()
//        alertModel.type = .default
        alertModel.title = title
        alertModel.subtitle = subtitle
        alertModel.cancelStr = cancelStr
        alertModel.cancelColor = cancelColor
        alertModel.confirmStr = confirmStr
        alertModel.confirmColor = confirmColor
      
//        let alert = DefaultAlertVC.fromStoryboard(name: "Alert")
//        alert.alertModel = alertModel
//        alert.cancelBlock = cancelBlock
//        alert.confirmBlock = confirmBlock
//        alert.hideAnimateEndBlock = hideAnimateEndBlock
//        alert.show()
    }

    /// 只有一个按钮的弹窗
    static public func showSureAlert(title: String,
                                     subtitle:  String = "",
                                     sureStr: String = "确定",
                                     sureColor: UIColor = UIColor(hexString:"#576B95"),
                                     isUpdate:Bool = false,
                                     updateUrl:String = "",
                                     confirmBlock: BlockWithNone? = nil,
                                     hideAnimateEndBlock: BlockWithNone? = nil) {
//
//        let alertModel = DefaultAlertModel()
//        alertModel.type = .sure
//        alertModel.title = title
//        alertModel.subtitle = subtitle
//        alertModel.sureStr = sureStr
//        alertModel.sureColor = sureColor
//        alertModel.isUpdate = isUpdate
//        alertModel.updateUrl = updateUrl
//
//        if CommonUtil.getCurrentVC()?.className == DefaultAlertVC.className{
//            //防止多个弹窗
//            return
//        }
//        let alert = DefaultAlertVC.fromStoryboard(name: "Alert")
//        alert.alertModel = alertModel
//        alert.confirmBlock = confirmBlock
//        alert.hideAnimateEndBlock = hideAnimateEndBlock
//        alert.show()
    }
    
    /// 发布输入框弹窗
    class func showInputAlert(title: String,
                                placeHold:String = "",
                                inputText:String = "",
                                cancelBlock: BlockWithNone? = nil,
                                confirmBlock: BlockWithParameters<String>? = nil,
                                hideAnimateEndBlock: BlockWithNone? = nil) {

//        let alertModel = DefaultAlertModel()
//        alertModel.title = title
//        alertModel.placeHold = placeHold
//        alertModel.inputText = inputText
//
//
//        let alert = InputAlertVC.fromStoryboard(name: "Alert")
//        alert.alertModel = alertModel
//        alert.cancelBlock = cancelBlock
//        alert.confirmDataBlock = confirmBlock
//        alert.hideAnimateEndBlock = hideAnimateEndBlock
//        alert.show()
    }
    
 
    /// 协议弹窗
    static public func showAgreementAlert(agreeBlock: @escaping BlockWithNone) {
//        let alert = PrivacyPolicyAlertVC.fromStoryboard(name: "Alert")
//        alert.confirmBlock = agreeBlock
//        alert.show()
    }
    
    
    /// 多选行为弹窗
    class func showActionAlert(titles: [String],
                               cancelStr: String = "取消",
                               cancelColor: UIColor = Color999999,
                               cancelBlock: BlockWithNone? = nil,
                               selectBlock: BlockWithParameters<Int>? = nil,
                               hideAnimateEndBlock: BlockWithNone? = nil) {
        
//        let alertModel = ActionAlertModel()
//        alertModel.titles = titles
//        alertModel.cancelStr = cancelStr
//        alertModel.cancelColor = cancelColor
//        alertModel.isClickBlankDisappear = true
//
//        let alert = ActionAlertVC.fromStoryboard(name: "Alert")
//        alert.alertModel = alertModel
//        alert.cancelBlock = cancelBlock
//        alert.selectBlock = selectBlock
//        alert.hideAnimateEndBlock = hideAnimateEndBlock
//        alert.show()
    }
    
    ///公告
    static public func showChainPathSheet(title: String = "", content:String = "", _ leftText:String = "", completeClosure: @escaping BlockWithParameters<Int>) {
//        let alert = NoticeAlertVC.fromStoryboard(name: "Alert")
//        alert.content = content
//        alert.leftText =  leftText
//        alert.titeString = title
//        if let _ = CommonUtil.getCurrentVC() {
//            alert.pan_show()
//        }
    }
    
    ///购买筛选 String - 币数量 Int - 付款方式
    static public func showFillterVC(completeClosure: @escaping BlockWithParameters<(String,String)>) {
//        let alert = FillterAlertVC.fromStoryboard(name: "Alert")
//        alert.subimitBlock = completeClosure
//        if let _ = CommonUtil.getCurrentVC() {
//            alert.pan_show()
//        }
    }
    
    
    ///购买筛选 String - 币数量 Int - 付款方式
    static public func showSelectPayAlertVC(_ infoArr : [String], _ title : String = "", completeClosure: @escaping BlockWithParameters<String>) {
//        let alert = SelectPayAlertVC.fromStoryboard(name: "Alert")
//
//        alert.infoArr = infoArr
//        alert.titleStr = title
//        alert.subimitBlock = completeClosure
//        if let _ = CommonUtil.getCurrentVC() {
//            alert.pan_show()
//        }
    }
    
    ///选择买家可选的支付方式
//    static public func showUserSelectPayListAlertVC(_ infoArr : [user_paymentsModel], completeClosure: @escaping BlockWithParameters<user_paymentsModel>) {
//        let alert = PaymentsListAlert.fromStoryboard(name: "Alert")
//        alert.infoArr = infoArr
//        alert.subimitBlock = completeClosure
//        if let _ = CommonUtil.getCurrentVC() {
//            alert.pan_show()
//        }
//    }
    
    
    
    ///挂单筛选
    static public func showSellFillterVC(completeClosure: @escaping BlockWithParameters<(String,String,String)>) {
//        let alert = SellFillterAlertVC.fromStoryboard(name: "Alert")
//        alert.subimitBlock = completeClosure
//        if let _ = CommonUtil.getCurrentVC() {
//            alert.pan_show()
//        }
    }
    
}

class DefaultAlertModel: BaseModel {
    
    var type: DefaultAlertType!
    var title: String = ""
    var subtitle: String = ""
    var cancelStr: String = ""
    var cancelColor: UIColor = Color000000
    var confirmStr: String = ""
    var confirmColor: UIColor = UIColor(hexString:"#576B95")
    var sureStr: String = ""
    var sureColor: UIColor = UIColor(hexString:"#576B95")
    var isClickBlankDisappear: Bool = false
 
    //输入框默认值
    var inputText : String = ""
    var placeHold : String = ""
    
    
    //是否强制更新
    var isUpdate = false
    var updateUrl = ""
}
class ActionAlertModel: BaseModel {
    
    var titles: [String] = []
    var cancelStr: String = ""
    var cancelColor: UIColor = Color666666
    var isClickBlankDisappear: Bool = false
    
}
