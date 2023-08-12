//
//  TipManager.swift
//  MarketPlace
//
//  Created by tanktank on 2022/4/22.
//

import UIKit

///成功数据回调
typealias clickCallback = ((_ isok : Bool) -> Void)
let tipManager = TipManager.manager

class TipManager: NSObject {
    static let manager : TipManager = {
       let obj = TipManager()
       return obj
    }()
    ///alert
    public func showAlert(icon : String?,title : String, message : String, actionArray : [String] ,completion: @escaping clickCallback){
        let view = TipsView()
        view.icon = icon ?? "alert_tip"
        view.title = title
        view.message = message
        view.actionArray = actionArray
        view.backAtion = { isok in
            completion(isok)
        }
        view.show()
    }
        
    public func showSingleAlert(title:String = "" , message : String , buttonTitle: String = "Got it" , style: HPAlertAction.Style = .cancel , handler: @escaping () -> Void = {}){
        
        let alert = HPAlertController(title: title,
                                      message: message ,
                                      icon: .none,
                                      alertTintColor:kBlackTextColor)
                
        let actionBtn = HPAlertAction(title: buttonTitle, style: style , handler: handler)
        alert.addAction(actionBtn)
        
        let vc =  UIApplication.shared.windows.first?.rootViewController
        vc?.present(alert, animated: true)

    }
}
