//
//  MPAppGuideCell.swift
//  MarketPlace
//
//  Created by mac on 2023/6/21.
//

import UIKit

class MPAppGuideCell: FSPagerViewCell {
    let disposeBag = DisposeBag()
    
    var dismissBlock:NormalBlock?
    var nextBlock:NormalBlock?
    lazy var  overBtn : ZQButton = {
        let btn = ZQButton()
        btn.setTitle("跳过".localString(), for: .normal)
        btn.titleLabel?.font = FONT_M(size: 14)
        btn.setTitleColor(kMainColor, for: .normal)
        btn.corner(cornerRadius: 12 ,borderColor:kMainColor , borderWidth: 1)
        btn.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else{return}
            self.dismissBlock?()
        }).disposed(by: disposeBag)
        return btn
    }()
    
    lazy var  dismissBtn : ZQButton = {
        let btn = ZQButton()
        btn.backgroundColor = kMainColor
        btn.setTitle("立即交易".localString(), for: .normal)
        btn.titleLabel?.font = FONT_SB(size: 20)
        btn.corner(cornerRadius: 12)
        btn.isHidden = true
        btn.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else{return}
            self.dismissBlock?()
        }).disposed(by: disposeBag)
        return btn
    }()
    
    lazy var nextBtn : ZQButton = {
        let btn = ZQButton()
        btn.setImage(UIImage(named: "guide_next"), for: .normal)
        btn.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else{return}
            self.nextBlock?()
        }).disposed(by: disposeBag)
        return btn
    }()
    
    let bgImage = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.contentView.layer.shadowColor = UIColor.clear.cgColor
        self.contentView.layer.shadowRadius = 0
        self.contentView.layer.shadowOpacity = 0.75
        self.contentView.layer.shadowOffset = .zero
        
        self.contentView.addSubview(bgImage)
        bgImage.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        self.contentView.addSubview(overBtn)
        overBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.equalTo(64)
            make.width.equalTo(50)
            make.height.equalTo(24)
        }
        
        self.contentView.addSubview(dismissBtn)
        dismissBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(215)
            make.bottom.equalTo(-94)
        }
        
        self.contentView.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.right.equalTo(-19)
            make.bottom.equalTo(-95)
            make.width.height.equalTo(50)
        }
        
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
