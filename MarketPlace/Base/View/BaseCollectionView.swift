//
//  BaseCollectionView.swift
//
//
//  Created by tanktank on 2022/3/17.
//

import UIKit

class BaseCollectionView: UICollectionView {

    let nodataView = NoDataView()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configyrationLatestVersion()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configyrationLatestVersion()
    }
    
}

// MARK:- 版本适配
extension BaseCollectionView {
    
    /// 适配新版本
    func configyrationLatestVersion() {
        if #available(iOS 11.0, *)  {
            self.contentInsetAdjustmentBehavior = .never
        }
        
        if #available(iOS 13.0, *) {
            self.automaticallyAdjustsScrollIndicatorInsets = false
        }
        
//        let view = UIView()
//        self.ep.setEmpty(view)
//        view.backgroundColor = .white
//        view.addSubview(nodataView)
//        nodataView.setInfo()
//        nodataView.snp.makeConstraints { make in
//            
//            make.centerX.equalToSuperview()
//            make.top.equalTo(100)
//        }
        
    }
    
    func showNoDataView(dataAry:[Any], image:UIImage? = nil, content:String?="暂无数据",  EqualTop:Float) {
        if dataAry.count > 0 {
            self.backgroundView = nil
            return
        }
        
        
        
        let bgView = UIView()
        bgView.backgroundColor = .white
        
        let img = UIImageView()
//        img.contentMode = .center
        bgView.addSubview(img)
        img.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(70)
            make.top.equalTo(EqualTop)
            make.centerX.equalToSuperview()
        }
        
        if image != nil {
            img.image = image
        }else {
            img.image = UIImage(named: "invite_nodata")
        }
        
        
        let titlab = UILabel()
        titlab.text = content
        titlab.textColor = .hexColor("#999999")
        titlab.font = FONT_M(size: 14)
        titlab.textAlignment = .center
        bgView.addSubview(titlab)
        titlab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(img.snp.bottom).offset(10)
            make.height.equalTo(17)
        }
        
        
        self.backgroundView = bgView
        
    }
}
