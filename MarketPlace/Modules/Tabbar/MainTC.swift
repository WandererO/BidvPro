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
        tabBarAppearance.backgroundImage = UIImage(named: "ic_bottom_bar_Normal")
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
   //cardbottom_Normal  Group 15227_Normal ic_bottom_bar_Normal  ic_footer_reward_selected_Normal ic_footer_setting_selected_vip_Normal ic_scan_Normal icoFooterHome_selected_Normal  ic_footer_notify_Normal
   
        centerTabar.addDelegate = self
        self.setValue(centerTabar, forKey: "tabBar")
  
        let nav0 = getChildController(title:"Home".localString(),
                                      childVC: homeVC, selectedImageName: "icoFooterHome_selected_Normal", normalImageName: "icoFooterHome_Normal")
 
        let nav1 = getChildController(title:"Rewards".localString(),
                                      childVC: QRVC, selectedImageName: "ic_footer_reward_selected_Normal", normalImageName: "ic_footer_reward_selected_Normal")
         
        //中间
        let centerNav = getChildController(title:"",
                                      childVC: transferVC, selectedImageName: "", normalImageName: "")
        
        
        let nav2 = getChildController(title:"Notify".localString(),
                                      childVC: paymentVC, selectedImageName: "ic_footer_notify_selected_Normal", normalImageName: "ic_footer_notify_Normal")
         
        let nav3 = getChildController(title:"Settings".localString(),
                                      childVC: moreVC, selectedImageName: "ic_footer_setting_selected_vip_Normal", normalImageName: "ic_footer_setting_Normal")
      
        
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
            self.tabBar.unselectedItemTintColor = .red//RGBCOLOR(r: 86, g: 86, b: 86)
        } else {
//            childVC.tabBarItem.setTitleTextAttributes([.foregroundColor:HightLightColor,.font:UIFont.systemFont(ofSize: 8)], for: .selected)
//            childVC.tabBarItem.setTitleTextAttributes([.foregroundColor:RGBCOLOR(r: 86, g: 86, b: 86),.font:UIFont.systemFont(ofSize: 8)], for: .normal)
        }
      
        let selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = selectedImage
        
        let normalImage = UIImage(named: normalImageName)?.withRenderingMode(.alwaysTemplate)
        normalImage?.withTintColor(.red)
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
