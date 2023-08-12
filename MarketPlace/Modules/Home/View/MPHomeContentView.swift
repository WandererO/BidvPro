//
//  MPHomeContentView.swift
//  MarketPlace
//
//  Created by mac on 2023/8/4.
//

import UIKit
import AttributedString

class MPHomeContentView: BaseView {
    
    let scrollView = UIScrollView()
    
    lazy var quickAcessView : UICollectionView  = { //金刚区
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15 // 列间距
        layout.minimumInteritemSpacing = 10 // 行间距
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15) // 设置item的四边边距
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: "MPHomeOtherServicesCell", bundle: nil), forCellWithReuseIdentifier: "MPHomeOtherServicesCell")
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView.backgroundColor =  RGBCOLOR(r: 246, g: 247, b: 250)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
        }
        
        let balanceV = MPHomeAvailableView()
        scrollView.addSubview(balanceV)
        balanceV.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(15)
            make.width.equalTo(SCREEN_WIDTH - 180)
            make.height.equalTo(70)
        }
        
        let rewardsV = MPHomeRewardsView()
        scrollView.addSubview(rewardsV)
        rewardsV.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.equalTo(15)
            make.left.equalTo(balanceV.snp.right).offset(10)
            make.height.equalTo(70)
        }
        
        let infoImage = UIImageView()
        infoImage.image = UIImage(named: "home_info")
        infoImage.corner(cornerRadius: 10)
        scrollView.addSubview(infoImage)
        infoImage.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(balanceV.snp.bottom).offset(30)
            make.right.equalTo(-40)
            make.width.equalTo(SCREEN_WIDTH - 60)
            make.height.equalTo(150)
        }
        
        let servicesLab = UILabel()
        servicesLab.text = "Bank services".localString()
        servicesLab.textColor = kBlackTextColor
        servicesLab.font = FONT_R(size: 16)
        scrollView.addSubview(servicesLab)
        servicesLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(infoImage.snp.bottom).offset(50)
        }
        
        let overViewBtn = ZQButton()
        overViewBtn.setTitle("Overview".localString(), for: .normal)
        overViewBtn.setTitleColor(kMainBlueColor, for: .normal)
        overViewBtn.titleLabel?.font = FONT_R(size: 16)
        scrollView.addSubview(overViewBtn)
        overViewBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.equalTo(infoImage.snp.bottom).offset(50)
            make.height.equalTo(20)
        }
        
        let serviceV = MPHomeServicesView()
        scrollView.addSubview(serviceV)
        serviceV.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(overViewBtn.snp.bottom).offset(10)
            make.height.equalTo(90)
        }
        serviceV.selectBtnBlock = {[weak self] tag in
            guard let self = self else{return}
            if tag == 0 {
                let vc = MPCurrentAccountController()
                self.viewContainingController()?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        let insuranceLab = UILabel()
        insuranceLab.text = "Insurance services".localString()
        insuranceLab.textColor = kBlackTextColor
        insuranceLab.font = FONT_R(size: 16)
        scrollView.addSubview(insuranceLab)
        insuranceLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(serviceV.snp.bottom).offset(15)
        }
        
        let insuranceV = MPHomeInsuranceView()
        scrollView.addSubview(insuranceV)
        insuranceV.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(insuranceLab.snp.bottom).offset(10)
            make.height.equalTo(80)
        }
        
        let otherLab = UILabel()
        otherLab.text = "Other services".localString()
        otherLab.textColor = kBlackTextColor
        otherLab.font = FONT_R(size: 16)
        scrollView.addSubview(otherLab)
        otherLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(insuranceV.snp.bottom).offset(15)
        }
        
        
        scrollView.addSubview(quickAcessView)
        quickAcessView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(otherLab.snp.bottom).offset(5)
            make.height.equalTo(110)
            make.bottom.equalToSuperview()
        }
        
        
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MPHomeAvailableView : BaseView {
    
    lazy var eyeBtn : ZQButton = {
        let btn = ZQButton()
        btn.setImage(UIImage(named: "eye-open"), for: .normal)
        return btn
    }()
    
    lazy var amountLab : UILabel = {
        let lab = UILabel()
        lab.text = "9898 VND"
        lab.textColor = RGBCOLOR(r: 33, g: 111, b: 241)
        lab.font = FONT_SB(size: 16)
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = RGBCOLOR(r: 233, g: 240, b: 249)
        self.corner(cornerRadius: 8)
        
        let amount = Archive.getDefaultsForKey(key: "money").getShowPrice()
        amountLab.attributed.text = "\(amount, .foreground(RGBCOLOR(r: 33, g: 111, b: 241)), .font(FONT_Cus(size: 16))) \("VND", .foreground(RGBCOLOR(r: 18, g: 108, b: 235)), .font(FONT_R(size: 16)))"
        
        self.addSubview(eyeBtn)
        eyeBtn.snp.makeConstraints { make in
            make.left.equalTo(5)
            make.top.equalTo(10)
            make.width.equalTo(35)
        }
        
        let textLab = UILabel()
        textLab.text = "Available balance".localString()
        textLab.textColor = kBlack3TextColor
        textLab.font = FONT_R(size: 16)
        self.addSubview(textLab)
        textLab.snp.makeConstraints { make in
            make.left.equalTo(eyeBtn.snp.right).offset(5)
            make.top.equalTo(10)
            make.height.equalTo(20)
        }
        
        self.addSubview(amountLab)
        amountLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(textLab.snp.bottom).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MPHomeRewardsView : UIButton  {
    
    lazy var amountLab : UILabel = {
        let lab = UILabel()
        lab.text = "500 point"
        lab.textColor = RGBCOLOR(r: 33, g: 111, b: 241)
        lab.font = FONT_SB(size: 16)
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = RGBCOLOR(r: 233, g: 240, b: 249)
        self.corner(cornerRadius: 8)
        
        amountLab.attributed.text = "\("500", .foreground(RGBCOLOR(r: 33, g: 111, b: 241)), .font(FONT_Cus(size: 16))) \("point", .foreground(RGBCOLOR(r: 18, g: 108, b: 235)), .font(FONT_R(size: 16)))"
        
        
        let labs = UILabel()
        labs.text = "ACB Rewards".localString()
        labs.textColor = kBlack3TextColor
        labs.font = FONT_R(size: 16)
        self.addSubview(labs)
        labs.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.height.equalTo(20)
        }
        
        let rightImag = UIImageView()
        rightImag.image = UIImage(named: "ic_next")
        self.addSubview(rightImag)
        rightImag.snp.makeConstraints { make in
            make.left.equalTo(labs.snp.right).offset(5)
            make.centerY.equalTo(labs.snp.centerY)
            make.width.height.equalTo(14)
        }
        
        self.addSubview(amountLab)
        amountLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(labs.snp.bottom).offset(10)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MPHomeServicesView : BaseView {
    
    var selectBtnBlock:SelectBlock?
    var buttonS:[MPButtons] = []
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.corner(cornerRadius: 10)
        
        self.clipsToBounds = false
        self.setShadow(width: 0, bColor: kLineColor, sColor: kBlackTextColor, offset: CGSize(width: 0, height: 6), opacity: 0.1, radius: 8)
        self.layer.shadowRadius = 14
        
        let titleAry = ["Accounts","Savings","Loans", "Cards"]
        let imgAry = ["Bank","Saving","Loan","Card"]
        var buttonS:[MPButtons] = []
        var i = 0
        for title in titleAry {
            let btn = MPButtons()
            btn.tag = i
            buttonS.append(btn)
            btn.title = title.localString()
            btn.imageWidth = 30
            btn.imgStr = imgAry[i]
            btn.rx.tap.subscribe(onNext: { [weak self] in
                guard let self = self else {return}
                let tag = btn.tag
                self.selectBtnBlock?(tag)
            }).disposed(by: self.disposeBag)
            i += 1
            self.addSubview(btn)
        }
        buttonS.snp.distributeViewsAlong(axisType:.horizontal, fixedItemLength: 80 , leadSpacing: 15 , tailSpacing: 15)
        buttonS.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(60)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class MPButtons:UIButton {
    
    var title:String? {
        didSet {
            titleLab.text = title?.localString()
        }
    }
    var imgStr : String? {
        didSet {
            btnImg.image = UIImage(named: imgStr ?? "")
        }
    }
    
    var imageWidth : CGFloat = 0 { didSet{ setUI()}}
    
    lazy var btnImg : UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    lazy var titleLab : UILabel = {
        let lab = UILabel()
        lab.textColor = kBlackTextColor
        lab.font = FONT_R(size: 14)
        lab.textAlignment = .center
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        setUI()
    }
    
    func setUI() {
        self.addSubview(btnImg)
        btnImg.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.height.equalTo(self.imageWidth)
            make.centerX.equalToSuperview()
        }
        self.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(btnImg.snp.bottom).offset(10)
            make.height.equalTo(17)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MPHomeInsuranceView : UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.corner(cornerRadius: 10)
        
        self.clipsToBounds = false
        self.setShadow(width: 0, bColor: kLineColor, sColor: kBlackTextColor, offset: CGSize(width: 0, height: 6), opacity: 0.1, radius: 8)
        self.layer.shadowRadius = 14
        
        let linV = UIView()
        linV.backgroundColor = RGBCOLOR(r: 244, g: 191, b: 68)
        self.addSubview(linV)
        linV.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(15)
            make.width.equalTo(4)
            make.height.equalTo(20)
        }
        
        let titlaLab = UILabel()
        titlaLab.text = "ACB x Sun Life".localString()
        titlaLab.textColor = kBlack3TextColor
        titlaLab.font = FONT_SB(size: 18)
        self.addSubview(titlaLab)
        titlaLab.snp.makeConstraints { make in
            make.left.equalTo(linV.snp.right).offset(15)
            make.top.equalTo(15)
        }
        
        let contentLab = UILabel()
        contentLab.text = "Making lives brighter".localString()
        contentLab.textColor = RGBCOLOR(r: 86, g: 86, b: 86)
        contentLab.font = FONT_R(size: 16)
        self.addSubview(contentLab)
        contentLab.snp.makeConstraints { make in
            make.left.equalTo(titlaLab.snp.left)
            make.top.equalTo(titlaLab.snp.bottom).offset(10)
        }
        
        let rightImg = UIImageView()
        rightImg.image = UIImage(named: "ic_arrow_back_right")
        self.addSubview(rightImg)
        rightImg.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MPHomeContentView : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MPHomeOtherServicesCell", for: indexPath) as! MPHomeOtherServicesCell
//        cell.model = marketListModels[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - 80)
        return CGSize(width: width, height: 108)//collectionView.frame.height )
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}


