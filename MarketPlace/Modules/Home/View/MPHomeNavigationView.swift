//
//  MPHomeNavigationView.swift
//  MarketPlace
//
//  Created by mac on 2023/8/4.
//

import UIKit

class MPHomeNavigationView: BaseView {
    
    lazy var headerBtn : ZQButton = {
        let btn = ZQButton()
        btn.backgroundColor = RGBCOLOR(r: 125, g: 139, b: 100)
        btn.setTitle("HL", for: .normal)
        btn.titleLabel?.font = FONT_R(size: 18)
        btn.corner(cornerRadius: 25)
        return btn
    }()
    
    lazy var tipsLab : UILabel = {
        let lab = UILabel()
        lab.text = "Good afternoon"
        lab.textColor = kBlack3TextColor
        lab.font = FONT_R(size: 16)
        return lab
    }()
    
    lazy var nameLab : UILabel = {
        let lab = UILabel()
        lab.text = "NAME"
        lab.textColor = kBlackTextColor
        lab.font = FONT_Cus(size: 16)
        return lab
    }()
    
    lazy var notiBtn : ZQButton = {
        let btn = ZQButton()
        btn.backgroundColor = RGBCOLOR(r: 233, g: 240, b: 249)
        btn.setImage(UIImage(named: "Noti"), for: .normal)
        btn.corner(cornerRadius: 25)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = .gray
        
        nameLab.text = Archive.getDefaultsForKey(key: "nickName")
        
        self.addSubview(headerBtn)
        headerBtn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(40)
            make.height.width.equalTo(50)
        }
        
        self.addSubview(tipsLab)
        tipsLab.snp.makeConstraints { make in
            make.left.equalTo(headerBtn.snp.right).offset(10)
            make.top.equalTo(40)
        }
        
        self.addSubview(nameLab)
        nameLab.snp.makeConstraints { make in
            make.left.equalTo(headerBtn.snp.right).offset(10)
            make.bottom.equalTo(headerBtn.snp.bottom)
        }
        
        self.addSubview(notiBtn)
        notiBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.height.width.equalTo(50)
            make.top.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
