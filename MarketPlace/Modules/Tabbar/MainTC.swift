//
//  MainTC.swift
//  know
//
//  Created by apple on 2020/12/14.
//

import UIKit

 

class MainTC: UITabBarController,CenterTabDelegate {
    
    
    let centerTabar = CenterTab()
    
    let homeVC = CCHomeViewController()
    let QRVC = MPQRCodeController()
    let paymentVC = MPPaymentController()
    let moreVC = MPMoreViewController()

   
    let transferVC = MPTransferController()

    
     override func viewDidLoad() {
        super.viewDidLoad()
        
         
         self.delegate = self
         
 
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.shadowColor = UIColor.clear
        tabBarAppearance.backgroundImage = UIImage(named: "bottom-bar-bg")
        tabBarAppearance.backgroundImageContentMode = .scaleAspectFill
        tabBarAppearance.backgroundColor =  RGBCOLOR(r: 246, g: 247, b: 250)
        tabBarAppearance.backgroundEffect = nil
        tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
  
        setChildVCs()
        
        
        }
 
    /// 设置子控制器
    public func setChildVCs() {
   
   
        centerTabar.addDelegate = self
        self.setValue(centerTabar, forKey: "tabBar")
  
        let nav0 = getChildController(title:"Home".localString(),
                                      childVC: homeVC, selectedImageName: "account_active", normalImageName: "account_inactive")
 
        let nav1 = getChildController(title:"QR Code".localString(),
                                      childVC: QRVC, selectedImageName: "Scan_QR_inactive", normalImageName: "Scan_QR_inactive")
         
        //中间
        let centerNav = getChildController(title:"",
                                      childVC: transferVC, selectedImageName: "", normalImageName: "")
        
        
        let nav2 = getChildController(title:"Payment".localString(),
                                      childVC: paymentVC, selectedImageName: "payment_active", normalImageName: "payment_inactive")
         
        let nav3 = getChildController(title:"More".localString(),
                                      childVC: moreVC, selectedImageName: "more_active", normalImageName: "more_inactive")
      
        
        setViewControllers([nav0, nav1, centerNav,nav2, nav3], animated: false)
   
    }
    
    
    //deleaget
    
    
  
    // MARK: - Private
    
    /// 设置子页面
    func addButtonClickCall() {
        
        PLog("点击了")
        self.selectedIndex = 2
    }
 
    
    private func getChildController(title:String , childVC: UIViewController, selectedImageName: String, normalImageName: String) -> BaseNavigationController {
 
        childVC.title = title
        childVC.tabBarItem.title = title
        childVC.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
//        childVC.tabBarItem.
        if #available(iOS 13.0, *) {
            self.tabBar.tintColor = HightLightColor
            self.tabBar.unselectedItemTintColor = RGBCOLOR(r: 86, g: 86, b: 86)
        } else {
//            childVC.tabBarItem.setTitleTextAttributes([.foregroundColor:HightLightColor,.font:UIFont.systemFont(ofSize: 8)], for: .selected)
//            childVC.tabBarItem.setTitleTextAttributes([.foregroundColor:RGBCOLOR(r: 86, g: 86, b: 86),.font:UIFont.systemFont(ofSize: 8)], for: .normal)
        }
      
        let selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = selectedImage
        
        let normalImage = UIImage(named: normalImageName)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.image = normalImage
        
        let nav = BaseNavigationController(rootViewController: childVC)
        return nav
    }
    
}

 
extension MainTC: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        // let selectNav = tabBarController.selectedViewController as? BaseNavigationController,
//        let selectVC = selectNav.viewControllers.first
        
        guard let nav = viewController as? BaseNavigationController,
              let vc = nav.viewControllers.first else { return false }


        if vc.className == homeVC.className
            || vc.className == QRVC.className
            || vc.className == paymentVC.className
            || vc.className == moreVC.className{
            
            centerTabar.nomilImageType()
        }

        return true
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
         
        PLog(tabBarController.selectedIndex)
      
         
        
    }
    
}
