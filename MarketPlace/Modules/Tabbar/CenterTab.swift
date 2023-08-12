//
//  CenterTab.swift
//  Koome
//
//  Created by Debug.s on 2022/6/8.
//

import UIKit


protocol CenterTabDelegate {
    func addButtonClickCall()
}


class CenterTab: UITabBar {

    
    var addDelegate : CenterTabDelegate?
    var transImage = UIImageView()
    var transLable = UILabel()
    let imgBg = UIView()
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addView.tag = 1005
        addSubview(addView)
  
       
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.shadowColor = UIColor.clear
        tabBarAppearance.backgroundImage = UIImage(named: "bottom-bar-bg")
        tabBarAppearance.backgroundImageContentMode = .scaleAspectFill
        tabBarAppearance.backgroundColor = RGBCOLOR(r: 246, g: 247, b: 250)
        tabBarAppearance.backgroundEffect = nil
        self.standardAppearance = tabBarAppearance
        
       
        if #available(iOS 15.0, *) {
            self.scrollEdgeAppearance = tabBarAppearance
        }
        
    }
    
    //凸出部分
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
          var view = super.hitTest(point, with: event)
          for subview in subviews {
              //用tag是为了寻找中间凸起的按钮
              PLog("------->\(subview.tag)")
              
              if subview.tag == 1005,subview.isEqual(addView){
                  //将点击点,转换坐标到凸起的按钮上,判断这个点是否在按钮上
                  //找到1006的按钮回传
                  let btn = addView.viewWithTag(1006) as! UIButton 
                  let newPoint = self.convert(point, to: btn)
                  //如果是,将按钮作为处理点击事件的的view 返回
                  if btn.bounds.contains(newPoint){
                      view = btn
                  }
              }
          }
          return view
      }
    
    
    public lazy var publishButton:UIButton =  {
        let publishButton = UIButton(type: .custom)
        publishButton.sizeToFit()
        publishButton.backgroundColor = .clear
        publishButton.tag = 1006
        publishButton.addTarget(self, action: #selector(addButtonClick), for: .touchUpInside)
        return publishButton
        
    }()
    
    
    //恢复选中状态
    public func nomilImageType(){
        transImage.image = UIImage(named: "transfer_inactive")
        transLable.textColor = UIColor.hexColor("999999")//RGBCOLOR(r: 86, g: 86, b: 86)
    }
    
    @objc func addButtonClick(){
         
        
        //设置图片选中状态
        transImage.image = UIImage(named: "transfer_active")
        transLable.textColor = HightLightColor
        if (addDelegate != nil) {
               addDelegate?.addButtonClickCall()
        }
        
    }
    
  
    
    
    public lazy var addView:UIView =  {
        let addView = UIView()
        
        addView.backgroundColor = .clear
//        addView.tag = 1005

        imgBg.backgroundColor = .white
        imgBg.corner(cornerRadius: 25)
        addView.addSubview(imgBg)
        
        //添加一张图
        transImage.image = UIImage(named: "transfer_inactive")
//        transImage.IB_cornerRadius = 20
        transImage.backgroundColor = .clear
        
        transLable.text = "Transfer".localString()
        transLable.font = FONT_M(size: 10)
        transLable.textColor = UIColor.hexColor("999999")//RGBCOLOR(r: 86, g: 86, b: 86)
        transLable.numberOfLines = 2
        transLable.textAlignment = .center
        
        
        
        //添加一个文本
//        addView.addSubview(transImage)
        addView.addSubview(transLable)
         
      
        
        
        //覆盖一层按钮作为点击效果
     
        addView.addSubview(publishButton)
        
        return addView
        
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder)")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //当前tabbai的宽度和高度
        let width = frame.width
        let height = frame.height - TABBAR_HEIGHT_SAFE
        addView.center = CGPoint(x:width*0.5,y:height*0.5-5)
        addView.mj_size = CGSize(width: 60, height: 60)
        
        //设置其他按钮的frame
//        let buttonW:CGFloat = width * 0.2
//        let buttonH:CGFloat = height
//        let buttonY:CGFloat = 0
//
//        var index = 0
//        for button in subviews{
//            if !button.isKind(of: NSClassFromString("UITabBarButton")!){
//                continue
//            }
//            let buttonX = buttonW * CGFloat(index > 1 ?(index+1):index)
//            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
//            index+=1
//        }
        
    
        imgBg.snp.makeConstraints { make in
            make.centerX.equalTo(addView)
            make.width.height.equalTo(50)
            make.top.equalTo(addView.snp.top).offset(-10)
        }
        
        transLable.snp.makeConstraints { make in
            make.bottom.equalTo(addView)
            make.left.right.equalTo(addView)
            make.height.equalTo(13) 
        }
        
        imgBg.addSubview(transImage)
        transImage.snp.makeConstraints { make in
            make.centerX.equalTo(addView)
            make.width.height.equalTo(30)
            make.top.equalToSuperview().offset(10)
        }
     
        publishButton.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        self.bringSubviewToFront(addView)
   
    } 

}
 
 
