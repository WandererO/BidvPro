//
//  CCHomeViewController.swift
//  MarketPlace
//
//  Created by XXX on 6/8/22.
//

import UIKit
import RxSwift
import SafariServices
//import ZendeskSDK
//import ZendeskSDKMessaging


class CCHomeViewController: BaseHiddenNaviController {
    
    

}
extension CCHomeViewController{
    
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
            
           
   }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGBCOLOR(r: 243, g: 246, b: 248)
        self.headerView.isHidden = true
        
        setUI()
    }
    
    
    
    func setUI(){
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    
    
}
