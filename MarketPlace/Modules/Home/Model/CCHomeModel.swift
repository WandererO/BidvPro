//
//  CCHomeModel.swift
//  MarketPlace
//
//  Created by Work on 7/10/22.
//

import UIKit

class CCHomeModel: HandyJSON {

    required init(){}
}

class MPTransferListModel : BaseModel {
    var date:String = ""
    
    var list : [ListModel] = []
    
    
}
class ListModel:BaseModel {
    var type : String = ""
    var amount : String = ""
    var receivername:String = ""
    var number : String = ""
    var content:String = ""
    var time :String = ""
}

