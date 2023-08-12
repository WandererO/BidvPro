//
//  MPLoginController.swift
//  MarketPlace
//
//  Created by mac on 2023/8/4.
//

import UIKit

class MPLoginController: BaseHiddenNaviController {

    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var psswdField: UITextField!
    
    let loginVM = MPPublicViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.isHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func loginClick(_ sender: Any) {
        
        requestLogin()
    }
    
    @IBAction func langueClick(_ sender: Any) {
    }
    
    func requestLogin() {
        if psswdField.text?.isEmpty == true ,
           accountField.text?.isEmpty == true {
            HudManager.showOnlyText("请输入账号或密码")
            return
        }
        
        let account = accountField.text ?? ""
        let pssword = psswdField.text ?? ""
        loginVM.requestLogin(account: account, psswd: pssword).subscribe(onNext: {[weak self] _ in
            guard let self = self else {return}
            Archive.setDefaults(value: account, key: "account")
            Archive.setDefaults(value: pssword, key: "password")
            
            
            let token = self.loginVM.loginModel.userinfo?.token ?? ""
            let money = self.loginVM.loginModel.userinfo?.money ?? ""
            let account = self.loginVM.loginModel.userinfo?.mobile ?? ""
            let nickName = self.loginVM.loginModel.userinfo?.nickname ?? ""
            Archive.setDefaults(value: account, key: "mobile")
            Archive.setDefaults(value: money, key: "money")
            Archive.setDefaults(value: nickName, key: "nickName")
            Archive.saveToken(token)
            
            NotificationCenter.default.post(name: loginSuccessNotification, object: self)
        }).disposed(by: disposeBag)
    }

}
