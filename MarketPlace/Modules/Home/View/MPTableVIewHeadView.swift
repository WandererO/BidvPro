//
//  MPTableVIewHeadView.swift
//  MarketPlace
//
//  Created by 世文 on 2023/8/15.
//

import UIKit

class MPTableVIewHeadView: UIView {

    
    override  func awakeFromNib() {
        super.awakeFromNib()
        topNavHeight.constant = TOP_HEIGHT + 20
        userHeadImage.IB_cornerRadius = 25
        bgImageHeight.constant =  SCREEN_HEIGHT * 0.6
        bottomViewHeight.constant = 220
        
        //加阴影圆角
        setShadow(view: infoView,
                         sColor: UIColor(red: 0.58, green: 0.58, blue: 0.58, alpha: 0.5),
                         offset: CGSize(width: 0, height: 2),
                         opacity: 1,
                         radius: 20)
        
        
        currentButton.setTitle("233189398278", for: .normal)
        
        currentButton.setupImagePosition(.right ,padding: 5)
        
    }
    //返回导航栏高度就可以 xib 默认 100px
    @IBOutlet weak var topNavHeight: NSLayoutConstraint!
     
    @IBOutlet weak var userHeadImage: UIImageView!
    
    @IBOutlet weak var searchBtn: UIButton!
    
    @IBOutlet weak var goodeveningLable: UILabel!
    
    //VU DANG TUNG
    @IBOutlet weak var UserLable: UILabel!
    
    
    //默认 xib 450 根据屏幕倍数设置
    @IBOutlet weak var bgImageHeight: NSLayoutConstraint!
    
    
    //current account 那个view
    @IBOutlet weak var infoView: UIView!
    
    //默认 xib 250
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var currentButton: UIButton!
    //账号点击
    @IBAction func currentLableButton(_ sender: Any) {
        
        
        PLog("账号点击")
        
        
    }
    
    
    @IBAction func searchACtion(_ sender: Any) {
        
        
        
        PLog("搜索点击")
        
        
    }
    
    /// view 加阴影
     func setShadow(view:UIView,sColor:UIColor,offset:CGSize,
                         opacity:Float,radius:CGFloat) {
              view.layer.shadowColor = sColor.cgColor
              view.layer.shadowOpacity = opacity
              view.layer.shadowOffset = offset
              view.layer.cornerRadius = radius
      }
    
}
