//
//  MPCurrentAccountController.swift
//  MarketPlace
//
//  Created by mac on 2023/8/6.
//

import UIKit

class MPCurrentAccountController: BaseHiddenNaviController {

    @IBOutlet weak var totalLab: UILabel!
    @IBOutlet weak var amountLab: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var historyBtn: UIButton!
    @IBOutlet weak var tkttLab: UILabel!
    @IBOutlet weak var accountLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var availableLab: UILabel!
    @IBOutlet weak var availableAmountLab: UILabel!
    @IBOutlet weak var currrntLab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Current account(s)".localString()
        self.view.backgroundColor = RGBCOLOR(r: 243, g: 246, b: 248)
        topViewRightBtn.setImage(UIImage(named: "image5"), for: .normal)
        topViewRightBtn.backgroundColor = RGBCOLOR(r: 240, g: 249, b: 255)
        topViewRightBtn.corner(cornerRadius: 16)
        
        cardView.clipsToBounds = false
        cardView.setShadow(width: 0, bColor: kLineColor, sColor: kBlackTextColor, offset: CGSize(width: 0, height: 6), opacity: 0.1, radius: 8)
        cardView.layer.shadowRadius = 14
        
        cardView.isUserInteractionEnabled = true
        cardView.addTapForView().subscribe(onNext: {[weak self] _ in
            guard let self = self else{return}
            
            let vc = MPCurrentAccountInfoController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }).disposed(by: disposeBag)
        
        
        let amount = Archive.getDefaultsForKey(key: "money").getShowPrice()
        let account = Archive.getDefaultsForKey(key: "account")
        let name = Archive.getDefaultsForKey(key: "nickName")
        
        totalLab.text = "Total balance".localString()
        historyBtn.setTitle("HISTORY".localString(), for: .normal)
        amountLab.text = amount
        amountLab.font = FONT_Cus(size: 20)
        
        tkttLab.text = "TKTT FIRST KHTN (CN) VND".localString()
        accountLab.text = account
//        accountLab.font = FONT_Cus(size: 14)
        
        nameLab.text = name
        nameLab.font = FONT_HN(size: 14)
        
        availableLab.text = "Available balance".localString()
        availableAmountLab.text = amount
        availableAmountLab.font = FONT_Cus(size: 18)
        
        currrntLab.text = "Current balance: ".localString() + amount + " VND"
        currrntLab.font = FONT_HN(size: 14)
    }

}
