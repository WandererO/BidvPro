//
//  MPBezierView.swift
//  MarketPlace
//
//  Created by mac on 2023/7/21.
//

import UIKit

class MPBezierView: UIView {
    
    
    
    func show() {
        UIApplication.shared.delegate?.window??.addSubview(self)
    }
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        self.backgroundColor = .white //UIColor(250, 250, 250, 1)
        
//        let grayBgV = UIView()
//        grayBgV.backgroundColor = .gray
//        self.addSubview(grayBgV)
//        grayBgV.snp.makeConstraints { make in
//            make.left.bottom.right.equalToSuperview()
//            make.height.equalTo(SCREEN_HEIGHT / 2)
//        }
//        self.sendSubviewToBack(grayBgV)
        
        let avAmount = Archive.getDefaultsForKey(key: "money").getShowPrice()
        
        let tipLab = UILabel()
        tipLab.text = "Available assets - Converted into VND".localString()
        tipLab.textColor = UIColor(21,19,20,1)
        tipLab.textAlignment = .center
        tipLab.font = FONT_M(size: 14)
        self.addSubview(tipLab)
        tipLab.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(30)
        }
        
        let amountLab = UILabel()
        amountLab.text = avAmount
        amountLab.textColor = kInputTextColor
        amountLab.textAlignment = .center
        amountLab.font = FONT_SB(size: 18)
        self.addSubview(amountLab)
        amountLab.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(tipLab.snp.bottom).offset(10)
        }
        
        //(Cafrentaccount & Deposit/ savings account)
        let tipLab2 = UILabel()
        tipLab2.text = "(Cafrentaccount & Deposit/ savings account)".localString()
        tipLab2.textColor = RGBCOLOR(r: 146, g: 146, b: 146)
        tipLab2.textAlignment = .center
        tipLab2.font = FONT_M(size: 14)
        self.addSubview(tipLab2)
        tipLab2.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(amountLab.snp.bottom).offset(10)
        }
        
        let tipLab3 = UILabel()
        tipLab3.text = "Total current account-YND".localString()
        tipLab3.textColor = RGBCOLOR(r: 23, g: 23, b: 23)
        tipLab3.textAlignment = .center
        tipLab3.font = FONT_R(size: 12)
        self.addSubview(tipLab3)
        tipLab3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }
        
        let amount = UILabel()
        amount.text = avAmount
        amount.textColor = RGBCOLOR(r: 0, g: 0, b: 0)
        amount.textAlignment = .center
        amount.font = FONT_SB(size: 16)
        self.addSubview(amount)
        amount.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tipLab3.snp.bottom).offset(10)
        }
        
        let listBtn = ZQButton()
        listBtn.setTitle("Accounts list".localString(), for: .normal)
        listBtn.setTitleColor(kInputTextColor, for: .normal)
        listBtn.titleLabel?.font = FONT_R(size: 10)
        listBtn.corner(cornerRadius: 12 , borderColor: kInputTextColor, borderWidth: 1)
        self.addSubview(listBtn)
        listBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(amount.snp.bottom).offset(10)
            make.width.equalTo(120)
            make.height.equalTo(25)
        }
        
        //Total liabilities - Converted into VND
        
        let loanLab = UILabel()
        loanLab.text = "(Loan account)".localString()
        loanLab.textColor = RGBCOLOR(r: 146, g: 146, b: 146)
        loanLab.textAlignment = .center
        loanLab.font = FONT_M(size: 14)
        self.addSubview(loanLab)
        loanLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-30)
        }
        
        let numLab = UILabel()
        numLab.text = "0"
        numLab.textColor = RGBCOLOR(r: 205, g: 61, b: 28)
        numLab.textAlignment = .center
        numLab.font = FONT_SB(size: 16)
        self.addSubview(numLab)
        numLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loanLab.snp.top).offset(-20)
        }
        
        let totalTip = UILabel()
        totalTip.text = "Total liabilities - Converted into VND".localString()
        totalTip.textColor = UIColor(21,19,20,1)
        totalTip.textAlignment = .center
        totalTip.font = FONT_M(size: 14)
        self.addSubview(totalTip)
        totalTip.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(numLab.snp.top).offset(-20)
        }
       
    }
    
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        UIColor(250, 250, 250, 1).set()
        let pathTop = UIBezierPath(roundedRect: CGRect(x: 15, y: 10, width: self.width - 30, height: self.height / 2 + 10), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
        pathTop.lineWidth = 5.0
        pathTop.lineCapStyle = .butt
        pathTop.lineJoinStyle = .round
        pathTop.fill()
        
        //灰色背景
        UIColor(230, 230, 230, 1).set()
        let path = UIBezierPath(roundedRect: CGRect(x: 15, y: self.height / 2 + 5, width: self.width - 30, height: self.height / 2 - 10), byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        path.lineWidth = 5.0
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.fill()

        
        //最外半圈
        let path1 = UIBezierPath(arcCenter: CGPoint(x: self.width / 2, y: self.height / 2 - 3), radius: 160, startAngle: .pi , endAngle: 0.0, clockwise: true)
        path1.lineWidth = 20
        path1.lineCapStyle = .butt
        path1.lineJoinStyle = .round
        UIColor(207, 233, 208, 1).setStroke()
        path1.stroke()
        
        
        UIColor.white.set()
        //底色白色圆（遮住灰色背景半圆效果）
        let path2 = UIBezierPath(arcCenter: CGPoint(x: self.width / 2, y: self.height / 2 + 5), radius: 150, startAngle: 0, endAngle:2 * .pi, clockwise: true)
        path2.lineWidth = 1
        path2.lineCapStyle = .round
        path2.lineJoinStyle = .round
//        UIColor.red.setStroke()
        path2.fill()
        
        //内半圈 绿色
        let path3 = UIBezierPath(arcCenter: CGPoint(x: self.width / 2, y: self.height / 2 - 3), radius: 130, startAngle: .pi , endAngle: 0.0, clockwise: true)
        path3.lineWidth = 25
        path3.lineCapStyle = .butt
        path3.lineJoinStyle = .round
        UIColor(119, 199, 114, 1).setStroke()
        path3.stroke()
        
        //U半圈 灰色
        let path4 = UIBezierPath(arcCenter: CGPoint(x: self.width / 2, y: self.height / 2 + 5), radius: 130, startAngle: 0 , endAngle: .pi, clockwise: true)
        path4.lineWidth = 25
        path4.lineCapStyle = .butt
        path4.lineJoinStyle = .round
        UIColor(153, 153, 153, 1).setStroke()
        path4.stroke()
        
        //虚线圆
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100,y: 100), radius: 100, startAngle: 0.0, endAngle: 2 * .pi, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.position = CGPoint(x: self.width / 2 - 100, y: self.height / 2 - 100)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(197, 197, 197, 1).cgColor
        shapeLayer.lineWidth = 2
        let one : NSNumber = 5
        let two : NSNumber = 3
        shapeLayer.lineDashPattern = [one,two]
        shapeLayer.lineCap = CAShapeLayerLineCap.butt
        self.layer.addSublayer(shapeLayer)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
