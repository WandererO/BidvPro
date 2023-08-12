//
//  UserManager.swift
//  MarketPlace
//
//  Created by tanktank on 2022/4/25.
//

import UIKit
import SwiftyRSA
let userManager = UserManager.manager



class UserManager: NSObject {
    

    static let manager : UserManager = {
       let obj = UserManager()
       return obj
    }()
    
    var backToHomePage = false
    var loginStatusChange = PublishSubject<Bool>() //动态推送登录状态
    func saveUserId(userID: String) {
        UserDefaults.standard.setValue(userID, forKey: "userId")
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.synchronize()
    }
    func getUserId() -> (String) {
        return UserDefaults.standard.string(forKey: "userId") ?? ""
    }
    
    
    ///是否登录
    var isLogin : Bool {
        let token = Archive.getToken()
        if token.count > 0 {
            return true
        }else{
            return false
        }
    }
}
// MARK: - 退出登录试清空用户模型
extension UserManager {
    ///登出
    func userLogout() {
        let token = ""
        Archive.saveToken(token)
        self.clearLoginModel()
//        GIDSignIn.sharedInstance.signOut()
    }
    
    func clearLoginModel() {
        
    }
    
    func logoutWithVC(currentVC : UIViewController ,isBackToHome:Bool = true){
        if currentVC.isKind(of: MPLoginController.classForCoder()) {
            return
        }
        let vc = MPLoginController()
        let nav = BaseNavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        currentVC.present(nav, animated: true)
        Archive.saveIsBackToHome(isBackToHome)
    }
    
    func logout(){
        let token = ""
        Archive.saveToken(token)
        Archive.setDefaults(value: "", key: "account")
        Archive.setDefaults(value: "", key: "password")
        
        let currentVC =  UIApplication.shared.windows.first?.rootViewController
        let vc = MPLoginController()
        let nav = BaseNavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        currentVC?.present(nav, animated: true)
        
    }
    
    
    
}

struct Archive {
    ///token 有关
    static func saveToken(_ token : String){
        UserDefaults.standard.setValue(token, forKey: "token")
        UserDefaults.standard.synchronize()
        userManager.loginStatusChange.onNext(token != "")
//        MPSocketManager.share.socketReconnect(time: 0)
    }
    static func getToken() -> (String){
//        return "093a8a0f-3163-471c-be9f-c4a12a32387d"
        return UserDefaults.standard.string(forKey: "token") ?? ""
    }
    
    ///是否跳回原来的页面
    static func saveIsBackToHome(_ isBackToCurrent : Bool){
        UserDefaults.standard.setValue(isBackToCurrent, forKey: "isBackToHome")
        UserDefaults.standard.synchronize()
    }
    static func getIsBackToHome() -> Bool{
        
        return UserDefaults.standard.bool(forKey: "isBackToHome")
    }

    ///language 语言
    static func saveLanguage (_ language : String){
        UserDefaults.standard.setValue(language, forKey: "language")
        UserDefaults.standard.synchronize()
    }
    static func getLanguage() -> (String){
        return UserDefaults.standard.string(forKey: "language") ?? "zh-CN"
    }
    
    static func setDefaults(value:String, key:String) {
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    static func getDefaultsForKey(key:String) -> (String) {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
    
    
}

struct EncryptRSA {
    
    ///rsa加密
   static func rsa_EncryptPEMstring(_ str:String) -> String{
            var reslutStr = ""
            let publicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAllX1cTgJ9JHyX75Mc703W6Q+OyEa3b6QSR8GNYHp7IWEBJoB0HBDyStDBgkxRKTMLfBXWDanwBTSrlzatyDbnhCczFcvXQOTYv/j0+lkHAfPF0+uex5jdGN7SjhI5RtiJXrR6al2bhUzyp2DVZFznwrpZkjrlNpXveaibtqtMUkNtRftaPdAubMLO6ENIMIA7SZULj4+rtpqlebHx5eEQMF1TMpLDqb7ibawwmADNYOhviv1RBCk7qMbrjgkz/d5vIiawwpqzFG/03MUQiYUzK8CtSAbHuwVIYB6EU406viLp4dSV2cLD3jAOFdcKBYyJdrH4Sb+USbjD3d/GfvXlQIDAQAB"
            do{
                let rsa_publicKey = try PublicKey(pemEncoded: publicKey)
                let clear = try ClearMessage(string: str, using: .utf8)
                reslutStr = try clear.encrypted(with: rsa_publicKey, padding: .PKCS1).base64String
                 
            }catch{
                print("RSA加密失败")
            }
            return reslutStr;
        }
}
