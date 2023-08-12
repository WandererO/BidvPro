//
//  CCLoginModel.swift
//  MarketPlace
//
//  Created by Work on 7/10/22.
//

import UIKit

class CCLoginModel: BaseModel {

    ///账户余额
    var money : String = ""
    ///用户token
    var token : String = ""
    
    var userinfo: Userinfo?
    
    class Userinfo:BaseModel {
        ///账户余额
        var money : String = ""
        ///用户token
        var token : String = ""
        
        ///账户
        var mobile : String = ""
        ///用户名
        var nickname : String = ""
    }
    
}





