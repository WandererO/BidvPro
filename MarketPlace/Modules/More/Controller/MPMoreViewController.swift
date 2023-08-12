//
//  MPMoreViewController.swift
//  MarketPlace
//
//  Created by mac on 2023/8/4.
//

import UIKit

class MPMoreViewController: BaseHiddenNaviController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGBCOLOR(r: 243, g: 246, b: 248)
        // Do any additional setup after loading the view.
    }

    @IBAction func logoutClick(_ sender: Any) {
        userManager.logout()
    }
    
    @IBAction func languesClcik(_ sender: Any) {
        let popV = MPBottomPopUpTableController()
        popV.isShowBottomView = true
        popV.datas = ["英语","越语"]
        popV.didselect = {[weak self] row in
            guard let self = self else{return}
            if row == 0 {
                LanguageManager.setLanguage(.english)
            }else{
                LanguageManager.setLanguage(.Vietnamese)
            }
        }
        popV.show(on:self)
    }
    
}
