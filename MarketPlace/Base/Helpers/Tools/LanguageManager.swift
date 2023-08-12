//
//  LanguageManager.swift
//  MarketPlace
//
//  Created by mac on 2023/6/12.
//

import UIKit

enum languageType {
    case chinese, english, autoSystem, HongKong, Vietnamese
}

class LanguageManager: NSObject {
    
    static func localValue(_ str:String) -> String {
        LanguageManager.shared.localValue(str: str)
    }
    static func setLanguage(_ type:languageType){
        LanguageManager.shared.setLanguage(type)
    }
        
    //单例
    static let shared = LanguageManager()
    
     private override init() {      }
    
    var bundle:Bundle = Bundle.main
    private func localValue(str:String) -> String{
        //table参数值传nil也是可以的，传nil系统就会默认为Localizable
        bundle.localizedString(forKey: str, value: nil, table: "Localizable")
    }
    
    private func setLanguage(_ type:languageType){
       var typeStr = ""
       switch type {
       case .chinese:
           typeStr = "zh-Hans"
           Archive.saveLanguage("zh-Hans")
       case .english:
           typeStr = "en"
           Archive.saveLanguage("en")
       case .HongKong:
           typeStr = "zh-HK"
           Archive.saveLanguage("zh-HK")
       case .Vietnamese:
           typeStr = "vi"
           Archive.saveLanguage("vi")
       default:
           break
       }
       //返回项目中 en.lproj 文件的路径
       let path = Bundle.main.path(forResource: typeStr, ofType: "lproj")
       //用这个路径生成新的bundle
       bundle = Bundle(path: path!)!
       if type == .autoSystem {
           //和系统语言一致
           bundle = Bundle.main
           UserDefaults.standard.removeObject(forKey: "language")
       }
       NotificationCenter.default.post(name: LocalLanguageChangeNotification, object: nil)
   }

}
