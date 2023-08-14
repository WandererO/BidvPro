//
//  MPAccountsView.swift
//  MarketPlace
//
//  Created by mac on 2023/8/14.
//

import UIKit

class MPAccountsView: UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    func setUI() {
        let balanceLab = UILabel()
        balanceLab.text = "Total balance".localString()
        balanceLab.font = FONT_MG(size: 14)
        balanceLab.textColor = .white
        self.addSubview(balanceLab)
        balanceLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(15)
        }
        
        let amountLab = UILabel()
        amountLab.text = "20000".getShowPrice() + "VND"
        amountLab.textColor = .white
        amountLab.font = FONT_MSB(size: 16)
        self.addSubview(amountLab)
        amountLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(balanceLab.snp.bottom).offset(10)
        }
        
        let choiseBtn = GXImageTitleButton()
        choiseBtn.corner(cornerRadius: 14)
        choiseBtn.backgroundColor = RGBCOLOR(r: 95, g: 144, b: 193)
        choiseBtn.title = "1 account(s)".localString()
        choiseBtn.image = UIImage(named: "ic_dropdown_white_Normal")
        choiseBtn.titleFont = FONT_MG(size: 14)
        choiseBtn.titleColor = .white
        choiseBtn.imageWidth = 18
        self.addSubview(choiseBtn)
        choiseBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
            make.height.equalTo(28)
            make.width.equalTo(115)
        }
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MPCarBalanceView : BaseView  {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = RGBCOLOR(r: 242, g: 250, b: 254)
        self.corner(cornerRadius: 18)
        
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.corner(cornerRadius: 16)
        self.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(40)
            make.height.equalTo(125)
        }
        
        let carIdLab = UILabel()
        carIdLab.text = "31210000506404"
        carIdLab.textColor = kBlackTextColor
        carIdLab.font = FONT_MSB(size: 16)
        bgView.addSubview(carIdLab)
        carIdLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(15)
        }
        
        let copyBtn = ZQButton()
        copyBtn.setImage(UIImage(named: "accountcopy_Normal"), for: .normal)
        bgView.addSubview(copyBtn)
        copyBtn.snp.makeConstraints { make in
            make.left.equalTo(carIdLab.snp.right).offset(5)
            make.centerY.equalTo(carIdLab.snp.centerY)
            make.width.height.equalTo(24)
        }
        
        let qrImage = UIImageView()
        qrImage.image = UIImage(named: "accountqrCode_Normal")
        bgView.addSubview(qrImage)
        qrImage.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalTo(carIdLab.snp.centerY)
            make.width.height.equalTo(24)
        }
        
        let defaultLab = UILabel()
        defaultLab.text = "Default".localString()
        defaultLab.textAlignment = .center
        defaultLab.textColor = .white
        defaultLab.corner(cornerRadius: 10)
        defaultLab.font = FONT_MG(size: 10)
        defaultLab.backgroundColor = RGBCOLOR(r: 39, g: 102, b: 171)
        bgView.addSubview(defaultLab)
        defaultLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(carIdLab.snp.bottom).offset(3)
            make.width.equalTo(45)
            make.height.equalTo(20)
        }
        
        let availableLab = UILabel()
        availableLab.text = "Available balance".localString()
        availableLab.font = FONT_MG(size: 14)
        availableLab.textColor = kGray6TextColor
        bgView.addSubview(availableLab)
        availableLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(defaultLab.snp.bottom).offset(15)
        }
        
        let amountLab = UILabel()
        amountLab.text = "20000".getShowPrice() + "VND"
        amountLab.textColor = RGBCOLOR(r: 28, g: 95, b: 162)
        amountLab.font = FONT_MSB(size: 16)
        bgView.addSubview(amountLab)
        amountLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(availableLab.snp.bottom).offset(5)
        }
        
        let nextBtn = ZQButton()
        nextBtn.setImage(UIImage(named: "accountNext_Normal"), for: .normal)
        nextBtn.backgroundColor = RGBCOLOR(r: 242, g: 242, b: 242)
        nextBtn.corner(cornerRadius: 15)
        bgView.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.bottom.equalTo(-15)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        
        
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
