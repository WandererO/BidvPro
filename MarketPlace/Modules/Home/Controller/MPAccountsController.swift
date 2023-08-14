//
//  MPAccountsController.swift
//  MarketPlace
//
//  Created by mac on 2023/8/14.
//

import UIKit

class MPAccountsController: BaseHiddenNaviController {
    
    let segmentBgView = UIView()
    lazy var segmentedViewDataSource = JXSegmentedTitleDataSource()
    lazy var segmentedView : JXSegmentedView = {
        let segmentedView = JXSegmentedView()
        segmentedView.backgroundColor = .clear
        segmentedViewDataSource.titles =  ["Current account".localString() , "Savings".localString(), "Loans".localString() ]
        segmentedViewDataSource.titleNormalColor = kBlackTextColor
        segmentedViewDataSource.titleSelectedColor = RGBCOLOR(r: 33, g: 98, b: 165)//kBlack3TextColor
        segmentedViewDataSource.isItemSpacingAverageEnabled = true
        segmentedViewDataSource.itemWidth = ((SCREEN_WIDTH - 30) / 3)
        segmentedViewDataSource.itemSpacing = 0
        segmentedViewDataSource.titleNormalFont = FONT_MSB(size: 14)
        segmentedViewDataSource.titleSelectedFont = FONT_MSB(size: 14)

        let lineView = JXSegmentedIndicatorBackgroundView()
        lineView.indicatorWidthIncrement = 0
        lineView.indicatorHeight = 28
        lineView.indicatorColor = .white
        lineView.indicatorCornerRadius = 14
        segmentedView.corner(cornerRadius: 14)
        segmentedView.indicators = [lineView]
        
//        segmentedView.defaultSelectedIndex = currentRow
        segmentedView.delegate = self
        segmentedView.dataSource = self.segmentedViewDataSource
        segmentedView.collectionView.contentOffset = CGPoint(x: 0, y: 10)
        segmentedView.contentScrollView?.isScrollEnabled = true
        return segmentedView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Accounts".localString()
        self.view.backgroundColor = .white
        
        setUI()
    }
    
    func setUI() {
        view.addSubview(segmentBgView)
        segmentBgView.corner(cornerRadius: 20)
        segmentBgView.backgroundColor = RGBCOLOR(r: 248, g: 248, b: 248)
        segmentBgView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(105)
            make.height.equalTo(40)
        }
        
        segmentBgView.addSubview(segmentedView)
        segmentedView.snp.makeConstraints { make in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
        }
        
        let accountView = MPAccountsView()
        accountView.corner(cornerRadius: 18)
        accountView.setGradMainColor(size: CGSize(width: SCREEN_WIDTH - 30, height: 80))
        view.addSubview(accountView)
        accountView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(segmentBgView.snp.bottom).offset(20)
            make.height.equalTo(80)
        }
        
        let carV = MPCarBalanceView()
        view.addSubview(carV)
        carV.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(accountView.snp.bottom).offset(-25)
            make.height.equalTo(180)
        }
        self.view.bringSubviewToFront(accountView)
    }

}
extension MPAccountsController : JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
    }
}
