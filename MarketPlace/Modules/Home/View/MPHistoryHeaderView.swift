//
//  MPHistoryHeaderView.swift
//  MarketPlace
//
//  Created by mac on 2023/8/7.
//

import UIKit

class MPHistoryHeaderView: BaseView {
    
    lazy var accountChoise : TitleImgButton = {
        let btn = TitleImgButton()
        btn.rightImage = UIImage(named: "ic_back_white_down")
        btn.title = "11100865"
        btn.imageMargin = 13
        btn.textColor = .white
        btn.imageWidth = 18
        btn.font = FONT_R(size: 16)
        btn.backgroundColor = RGBCOLOR(r: 44, g: 107, b: 188)
        btn.corner(cornerRadius: 15)
        return btn
    }()
    
    lazy var segmentView : SegmentView = {
        let seg = SegmentView()
        seg.titles = ["Completed".localString() , "Pending".localString(), "Scheduled".localString()]
        seg.segmentedViewDataSource.titleNormalColor = RGBCOLOR(r: 102, g: 102, b: 102)
        seg.segmentedViewDataSource.titleSelectedColor = RGBCOLOR(r: 44, g: 108, b: 189)
        seg.segmentedViewDataSource.titleSelectedFont = FONT_SB(size: 14)
        seg.segmentedViewDataSource.titleNormalFont = FONT_SB(size: 14)
        seg.segmentedViewDataSource.isItemSpacingAverageEnabled = true
        seg.isShowBottomLine = false
        seg.lineView.indicatorColor = RGBCOLOR(r: 44, g: 108, b: 189)
        seg.lineView.indicatorWidth = SCREEN_WIDTH / 3
        seg.segmentedView.contentEdgeInsetLeft = 25
        seg.segmentedView.contentEdgeInsetRight = 25
        seg.clickAt = { [weak self] row in
            guard let self = self else{return}
            if row == 0 {
                
            }else{
                
            }
        }
        return seg
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.addSubview(accountChoise)
        accountChoise.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.width.equalTo(130)
            make.height.equalTo(30)
        }
        
        self.addSubview(segmentView)
        segmentView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(accountChoise.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
