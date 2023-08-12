//
//  BaseTabBarController.swift
//  MarketPlace
//
//  Created by tanktank on 2022/5/30.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    
    let tabbarNormalArray = ["tab_home_unselect_Normal","tabBar_topup_ic_Normal","tabBar_qr_ic_Normal","tabBar_transIn_ic_Normal","tabBar_trans247_ic_Normal"]
    let tabbarSeletedArray = ["tabBar_home_ic_Normal","loyalty_topup_ic_Normal","bar_treaty_light","group_Normal","bar_property_light"]

    let titles = ["Home","Mobile topup","QR Services","Internal transfer","Quick transfer247"]
        
    let homeVC = CCHomeViewController()
//    let topUpVC = MPMobileTopUpController()
//    let QRVc = MPQRServicesController()
//    let internalVC = MPInternalTransferController()
//    let quickVC = MPQuickTransferController()
    
    
    lazy var baseHomeNav = BaseNavigationController.init(rootViewController: homeVC)
//    lazy var topUpNav = BaseNavigationController.init(rootViewController: topUpVC)
//    lazy var QRNav = BaseNavigationController.init(rootViewController: QRVc)
//    lazy var internalNav = BaseNavigationController.init(rootViewController: internalVC)
//    lazy var quickNav = BaseNavigationController.init(rootViewController: quickVC)

    var selectButton = UIButton()
//    lazy var tmpViewControllers = [baseHomeNav,topUpNav,QRNav,internalNav,quickNav]
    override func viewDidLoad() {
        super.viewDidLoad()
//        initControllers()
        self.delegate = self
        
//        self.tabBar.backgroundImage = UIImage(named: "bottom-bar-bg")
        
//        self.loadTabbar(vcs: tmpViewControllers)

        self.configyrationLatestVersion()
//        NotificationCenter.default.addObserver(self, selector: #selector(goToHomePage), name: loginSuccessNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(goToQuickBuy), name: C2CQuickBuyNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(goToContract), name: PushToContractNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(goToMarket), name: PushToMarketNotification, object: nil)
//
//        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: LocalLanguageChangeNotification.rawValue), object: nil,  queue: nil) { (notification) in
//
//            for index in 0..<self.tmpViewControllers.count {
//                let nav = self.tmpViewControllers[index]
//                if let vc = nav.viewControllers.last {
//                    vc.tabBarItem.title = self.titles[index].localString()
//                }
//            }
//            self.tabBar.selectedItem?.title = "首页".localString()//LanguageManager.localValue("首页")
//
//        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configyrationLatestVersion()
//        UITabBar.appearance().backgroundImage = UIImage(named: "bottom-bar-bg") //UIImage.getImageWithColor(color: .white) // UIImage(named: "fifa_tabbar")
    }
    
    @objc func goToHomePage(){
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
        if Archive.getIsBackToHome() {
            self.selectedIndex = 0
        }
        Archive.saveIsBackToHome(true)
    }
    
    @objc func goToQuickBuy(){
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.selectedIndex = 3
//        }
    }
    @objc func goToContract(){
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.selectedIndex = 2
//        }
    }
    @objc func goToMarket(){
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.selectedIndex = 1
//        }
    }

    func loadTabbar(vcs : [BaseNavigationController]){
        for index in 0..<vcs.count {
            let nav = vcs[index]
            if let vc = nav.viewControllers.last {
                vc.hidesBottomBarWhenPushed = false
                vc.tabBarItem.image = UIImage.init(named:self.tabbarNormalArray[index])?.withRenderingMode(.alwaysOriginal)
                vc.tabBarItem.selectedImage = UIImage.init(named:self.tabbarSeletedArray[index])?.withRenderingMode(.alwaysOriginal)
                vc.tabBarItem.title = LanguageManager.localValue(self.titles[index]) //self.titles[index]
                vc.tabBarItem.tag = index
            }
        }
        self.setViewControllers(vcs, animated: true)
    }
    
    
    @objc func onClick(button: UIButton) {
        // 将上个选中按钮设置为未选中
        self.selectButton.isSelected = false
        // 当前按钮设置为选中
        button.isSelected = true
        // 记录选中按钮
        self.selectButton = button
        
        // 通过UITabBarController的selectedIndex属性设置选中了哪个UIViewController
        self.selectedIndex = button.tag
        self.hidesBottomBarWhenPushed = false
    }
    
    func initControllers() {
        
//        self.tabBar.isTranslucent = true // tabbar不透明
        // 直接用颜色
//        self.tabBar.barTintColor = .init(white: 1, alpha: 1)
//        UITabBar.appearance().backgroundColor = .red //.init(white: 1, alpha: 1)
////        UITabBar.appearance().backgroundImage = UIImage()
//        UITabBar.appearance().backgroundImage = UIImage(named: "fifa_tabbar")
        
//        let tmpViewControllers = [baseHomeNav,baseMarketsNav,baseTradeNav,baseFuturesNav,baseWalletsNav]
        //选中和非选中字体颜色
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.red], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:kInputTextColor], for: .selected)
        //MARK: fifa
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.hexColor("FFC619") ], for: .selected)
        
    }

}
//extension BaseTabBarController {
//    override func qmui_themeDidChange(by manager: QMUIThemeManager, identifier: NSCopying & NSObjectProtocol, theme: NSObject) {
//        super.qmui_themeDidChange(by: manager, identifier: identifier, theme: theme)
//
//        guard let items = self.tabBar.items else {
//            return
//        }
//
//        for i in 0..<items.count {
////            UITabBarItem *item = items[i];
//            let item = items[i]
//            item.image = UIImage.init(named:self.tabbarNormalArray[i])?.withRenderingMode(.alwaysOriginal)
//            item.selectedImage = UIImage.init(named:self.tabbarSeletedArray[i])?.withRenderingMode(.alwaysOriginal)
//            item.title = self.titles[i]
//        }
//    }
//}


// MARK: - 版本适配
extension BaseTabBarController {
    /// 版本适配
    func configyrationLatestVersion() {
        if #available(iOS 13.0, *) {
            self.tabBar.tintColor = kInputTextColor//UIColor.hexColor("5171FF")
            self.tabBar.unselectedItemTintColor = RGBCOLOR(r: 135, g: 147, b: 152)
            
            
//            let viewTabBar = self.tabBarItem.value(forKey: "view") as? UIView
//    //        //            let imageView = viewTabBar?.subviews[0] as? UIImageView
//            let label = viewTabBar?.subviews[1] as? UILabel
//            label?.backgroundColor = .red
//            label?.numberOfLines = 2
//            label?.textAlignment = .center
//            label?.lineBreakMode = .byWordWrapping
//            label?.frame = CGRectMake(0, 0, (viewTabBar?.frame.size.width ?? 0),10)
//            label?.sizeToFit()
            
            //MARK: fifa
//            self.tabBar.tintColor = .hexColor("FFC619")
//            self.tabBar.unselectedItemTintColor = .white

//            self.tabBar.tintColor = kMainColor // .hexColor("FFC619")
//            self.tabBar.unselectedItemTintColor =
//            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.red], for: .normal)
//            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue ], for: .selected)

//            self.tabBar.backgroundColor =   .red //.init(white: 1, alpha: 0.9)//根据自己的情况设置
            
//            if let image = UIImage(named: "fifa_tabbar") {
//
//                let color = UIColor(patternImage: image)
            UITabBar.appearance().backgroundColor = RGBCOLOR(r: 24, g: 39, b: 44)
//            let line = UIView()
//            line.backgroundColor = kLineColor
//            self.tabBar.addSubview(line)
//            line.snp.makeConstraints { make in
//
//                make.left.right.top.equalToSuperview()
//                make.height.equalTo(2)
//            }
            
            
//            self.tabBar.layer.shadowColor = UIColor.hexColor("DBDDFD").cgColor
//            self.tabBar.layer.shadowOffset = CGSizeMake(0,-3)
//            self.tabBar.layer.shadowOpacity = 0.5
//            self.tabBar.layer.shadowRadius = 3
//            }
            
//            UITabBar.appearance().backgroundImage = UIImage(named: "become_trader")

//            let imaview = UIImageView(image: UIImage(named: "fifa_tabbar"))
//            UITabBar.appearance().qmui_backgroundView = imaview
        }
    }
}

// MARK: - UITabBarControllerDelegate
extension BaseTabBarController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if !userManager.isLogin &&
//            (self.viewControllers?.firstIndex(of: viewController) ?? 0) > 3  {
//            if let vc = self.selectedViewController {
//                userManager.logoutWithVC(currentVC: vc)
//            }
//            return false
//        }
        
//        guard let nav = viewController as? BaseNavigationController,
//              let selectNav = tabBarController.selectedViewController as? BaseNavigationController,
//              let vc = nav.viewControllers.first else { return false }
//        
//        if vc.className == MPQRServicesController.className{
//            let pushVc = MPQRServicesController()
//            selectNav.pushViewController(pushVc, animated: true)
//            return false
//        }
//        
//        if vc.className == MPMobileTopUpController.className {
//            let pushVC = MPMobileTopUpController()
//            selectNav.pushViewController(pushVC, animated: true)
//            return false
//        }
//        
//        if vc.className == MPInternalTransferController.className{
//            let pushVc = MPInternalTransferController()
//            selectNav.pushViewController(pushVc, animated: true)
//            return false
//        }
//        
//        if vc.className == MPQuickTransferController.className{
//            let pushVc = MPQuickTransferController()
//            selectNav.pushViewController(pushVc, animated: true)
//            return false
//        }
 
        
        
        
        
        return true
    }
    
}

extension BaseTabBarController {
    func setTabBarVisible(visible:Bool, duration: TimeInterval, animated:Bool) {
        if (tabBarIsVisible() == visible) { return }
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        
        
        

        // animation
        UIViewPropertyAnimator(duration: duration, curve: .linear) {
            self.tabBar.frame.offsetBy(dx:0, dy:offsetY)
            self.view.frame = CGRect(x:0,y:0,width: self.view.frame.width, height: self.view.frame.height + offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }.startAnimation()
    }

    func tabBarIsVisible() ->Bool {
        return self.tabBar.frame.origin.y < UIScreen.main.bounds.height
    }
}

