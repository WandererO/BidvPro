//
//  AppDelegate.swift
//  MarketPlace
//
//  Created by tanktank on 2023/2/19.
//

import UIKit
import IQKeyboardManagerSwift
//import FirebaseCore
//import FirebaseAnalytics

import ESTabBarController_swift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let disposeBag = DisposeBag()
    
    let loginVM = MPPublicViewModel()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setIQKeyboardManager()
        

        requestLogin()
        
        self.setUI()
        
        if let languageType = UserDefaults.standard.value(forKey: "language"){
//            print("进来")
//            print(languageType)
            let type = languageType as! String
            switch type {
            case "en":
                LanguageManager.setLanguage(.english)
            case "zh-Hans":
                LanguageManager.setLanguage(.chinese)
            case "zh-HK":
                LanguageManager.setLanguage(.HongKong)
            case "vi":
                LanguageManager.setLanguage(.Vietnamese)
            default:
                break
            }
        }

        
        ///配置数据库
//        RealmHelper.configRealm()
        ///初始化指标设置
//        loadKlineIndicate()
        print("===========用户Token：：：：\(Archive.getToken())")
        
        
//        requestVersion()
        
        
        return true
    }
    
    /// 当应用终止的时候起作用
    func applicationWillTerminate(_ application: UIApplication) {
      // 调用保存数据的方法
//        if Archive.getFaceID() && Archive.getToken().count>0{
//            Archive.saveToken("")
//        }
    }
    
    func setUI(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = kGreyTextColor
        
//        let tabbr = BaseTabBarController()
        let tabbr = MPLoginController()
        lazy var baseWelcomeVC = BaseNavigationController.init(rootViewController: tabbr)
        self.window?.rootViewController = baseWelcomeVC
        window?.makeKeyAndVisible()
//        tabbr.configyrationLatestVersion()
        
        
        ///登录成功通知
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: loginSuccessNotification.rawValue), object: nil,  queue: nil) { (notification) in
                     
            self.setTabbarController()
            
//            let tabbr = BaseTabBarController()
//            self.window?.rootViewController = tabbr
//            self.window?.makeKeyAndVisible()
        }
        
    }
    
    func requestLogin() {
        let pssword = Archive.getDefaultsForKey(key: "password")
        let account = Archive.getDefaultsForKey(key: "account")

        loginVM.requestLogin(account: account, psswd: pssword).subscribe(onNext: {[weak self] _ in
            guard let self = self else {return}

            let token = self.loginVM.loginModel.userinfo?.token ?? ""
            let money = self.loginVM.loginModel.userinfo?.money ?? ""
            let account = self.loginVM.loginModel.userinfo?.mobile ?? ""
            let nickName = self.loginVM.loginModel.userinfo?.nickname ?? ""
            Archive.setDefaults(value: money, key: "money")
            Archive.setDefaults(value: account, key: "mobile")
            Archive.setDefaults(value: nickName, key: "nickName")
            Archive.saveToken(token)
            NotificationCenter.default.post(name: loginSuccessNotification, object: self)
        }).disposed(by: disposeBag)
    }
    
    func setTabbarController() {//自定义tabbar
        
        
        
//        let tabbar = ESTabBarController()
////        SCREEN_WIDTH
//        let homeVC = CCHomeViewController()
//        let QRVC = MPQRCodeController()
//        let transferVC = MPTransferController()
//        let paymentVC = MPPaymentController()
//        let moreVC = MPMoreViewController()
//
//        let bgV = UIView()
//        bgV.backgroundColor = RGBCOLOR(r: 236, g: 239, b: 238)
//        bgV.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
//        tabbar.view.addSubview(bgV)
//        tabbar.view.sendSubviewToBack(bgV)
//
//        let bgImg = UIImageView()
//        bgImg.image = UIImage(named: "bottom-bar-bg")
//        bgImg.frame = CGRect(x: 0, y: SCREEN_HEIGHT - TABBAR_HEIGHT - 10, width: SCREEN_WIDTH, height: TABBAR_HEIGHT + 10)
//        bgImg.contentMode = .scaleAspectFill
//        tabbar.view.addSubview(bgImg)
//        tabbar.view.insertSubview(bgImg, at: 1)
        
        //点击拦截
//        tabbar.shouldHijackHandler = { tabbar, viewContro, idx in
//
//            if idx != 0 {
//                return true
//            }
//            return false
//        }
        
//        tabbar.didHijackHandler = {tabbar, viewContro, idx in
            
            
            
//            let nav = viewContro as? BaseNavigationController
//            let selectNav = tabbar.selectedViewController as? BaseNavigationController
            
//            if idx == 1 {
//                selectNav?.pushViewController(topUpVC, animated: true)
//            }else if idx == 2 {
//                selectNav?.pushViewController(QRVc, animated: true)
//            }else if idx == 3 {
//                selectNav?.pushViewController(internalVC, animated: true)
//            }else {
//                selectNav?.pushViewController(quickVC, animated: true)
//            }
            
            
//        }
        
        
        
//        UITabBar.appearance().backgroundColor = RGBCOLOR(r: 236, g: 239, b: 238)
//        UITabBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().backgroundImage = UIImage(named: "become_trader")
        
//        tabbar.tabBar.shadowImage = UIImage()
//        tabbar.tabBar.backgroundImage = UIImage(named: "bottom-bar-bg")
        
        
        
        
//        homeVC.tabBarItem = ESTabBarItem.init(BaseTabbarItemView(), title: "Home".localString(), image: UIImage(named: "account_inactive"), selectedImage: UIImage(named: "account_active"))
//        QRVC.tabBarItem = ESTabBarItem.init(BaseTabbarItemView(), title: "QR Code".localString(), image: UIImage(named: "Scan_QR_inactive"), selectedImage: UIImage(named: ""))
//        transferVC.tabBarItem = ESTabBarItem.init(BaseTabbarMiddleItemView(), title: "Transfer".localString(), image: UIImage(named: "transfer_inactive"), selectedImage: UIImage(named: "transfer_active"))
//        paymentVC.tabBarItem = ESTabBarItem.init(BaseTabbarItemView(), title: "Payment".localString(), image: UIImage(named: "bar_property_dark"), selectedImage: UIImage(named: "bar_property_light"))
//        moreVC.tabBarItem = ESTabBarItem.init(BaseTabbarItemView(), title: "More".localString(), image: UIImage(named: "more_inactive"), selectedImage: UIImage(named: "more_active"))
//
//        lazy var baseHomeNav = BaseNavigationController.init(rootViewController: homeVC)
//        lazy var topUpNav = BaseNavigationController.init(rootViewController: QRVC)
//        lazy var QRNav = BaseNavigationController.init(rootViewController: transferVC)
//        lazy var internalNav = BaseNavigationController.init(rootViewController: paymentVC)
//        lazy var quickNav = BaseNavigationController.init(rootViewController: moreVC)
        
        
        
//        tabbar.viewControllers = [baseHomeNav, topUpNav, QRNav, internalNav,quickNav]
        
        
        let tabbarController = MainTC()
        
        self.window?.rootViewController = tabbarController
        self.window?.makeKeyAndVisible()
    }
}

class BaseTabbarItemView:ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.numberOfLines = 2
        
        textColor = RGBCOLOR(r: 86, g: 86, b: 86)
        highlightTextColor = HightLightColor
        iconColor = RGBCOLOR(r: 157, g: 165, b: 176)
        highlightIconColor = HightLightColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class BaseTabbarMiddleItemView:ESTabBarItemContentView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView.backgroundColor = .red

//        self.imageView.layer.cornerRadius = 35
//        self.imageView.size = CGSize(width: 200, height: 200)
        self.isMiddleSpec = true
        self.insets = UIEdgeInsets.init(top: -32, left: 0, bottom: 0, right: 0)
        self.superview?.bringSubviewToFront(self)

        titleLabel.numberOfLines = 2
        
        textColor = RGBCOLOR(r: 86, g: 86, b: 86)
        highlightTextColor = HightLightColor
        iconColor = RGBCOLOR(r: 157, g: 165, b: 176)
        highlightIconColor = HightLightColor
        
        backdropColor = .clear
        highlightBackdropColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - IQKeyboardManager
extension AppDelegate {
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
//        var handled: Bool

//          handled = GIDSignIn.sharedInstance.handle(url)
//          if handled {
//            return true
//          }

          // Handle other custom URL types.

          // If not handled by this app, return false.
          return false
    }
    
    func setIQKeyboardManager(){
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldToolbarUsesTextFieldTintColor = true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
//        if MPSocketManager.share.isConnected {
//            MPSocketManager.share.reConnectTime = 5
//            MPSocketManager.share.socketDisConnect()
//            }
     }

    //进入前台模式，主动连接socket
        func applicationDidBecomeActive(_ application: UIApplication) {
            //解决因为网络切换或链接不稳定问题，引起socket断连问题
            //如果app从无网络，到回复网络，需要执行重连
//            if !MPSocketManager.share.isConnected {
//                MPSocketManager.share.reConnectTime = 0
//                MPSocketManager.share.socketReconnect(time:0)
//            }
        }
}

