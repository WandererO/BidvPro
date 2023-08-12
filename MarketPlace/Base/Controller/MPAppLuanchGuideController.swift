//
//  MPAppLuanchGuideController.swift
//  MarketPlace
//
//  Created by mac on 2023/6/21.
//

import UIKit

class MPAppLuanchGuideController: BaseHiddenNaviController {
    
    let imgAry = ["guide_first","guide_second","guide_three"]
    
    var dimissBlock:NormalBlock?

    lazy var pagerView : FSPagerView = {///轮播
       
        let pagerView = FSPagerView()
        pagerView.register(MPAppGuideCell.self, forCellWithReuseIdentifier: "MPAppGuideCell")
        pagerView.itemSize = FSPagerView.automaticSize
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.isInfinite = false
        pagerView.bounces = false
//        pagerView.automaticSlidingInterval = 3
        return pagerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(pagerView)
        pagerView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }

}
extension MPAppLuanchGuideController : FSPagerViewDelegate , FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        
//        self.pageControl.numberOfPages = bannerDatas.count
        return imgAry.count///bannerDatas.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "MPAppGuideCell", at: index) as! MPAppGuideCell
        cell.bgImage.image = UIImage(named: imgAry[index])
        if index == 2 {
            cell.overBtn.isHidden = true
            cell.dismissBtn.isHidden = false
            cell.nextBtn.isHidden = true
        }else {
            cell.overBtn.isHidden = false
            cell.dismissBtn.isHidden = true
            cell.nextBtn.isHidden = false
        }
        
        cell.dismissBlock = {[weak self] in
            guard let self = self else{return}
            self.dimissBlock?()
        }
        cell.nextBlock = {[weak self] in
            guard let self = self else{return}
            pagerView.scrollToItem(at: index + 1, animated: true)
        }
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
    
    // MARK:- FSPagerView Delegate
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
//        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
//        self.pageControl.currentPage = pagerView.currentIndex
    }
}
