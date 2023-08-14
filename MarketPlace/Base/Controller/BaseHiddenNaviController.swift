//
//  BaseHiddenNaviController.swift
//  MarketPlace
//
//  Created by TankTank on 6/18/22.
//

import UIKit

@IBDesignable
class BaseHiddenNaviController: BaseViewController {
   
    
    enum TopViewStyle : Int {

        case middleTitle = 0
        case leftTitle = 1
    }

    var RightBtnClick : NormalBlock?
//    let disposeBag = DisposeBag()
    @IBInspectable let headerView = UIView()
    let topView = UIView()
    let topViewLeftBtn = ZQButton()
    let topViewRightBtn = ZQButton()
    let topRightTwoBtn = ZQButton()
    
    let lineView = UIView()
    
    var backgroundImage:UIImage? {
        didSet{
            self.headerBackgroundImage.isHidden = false
            self.headerBackgroundImage.image = backgroundImage
        }
    }
    lazy var headerBackgroundImage : UIImageView = {
        let img = UIImageView()
        img.isHidden = true
        return img
    }()
    
    lazy var headerImage : UIImageView = {
        let img = UIImageView()
        img.isHidden = true
        return img
    }()
    var isNeedForceResignKeyboard = false {
        
        didSet{
            if isNeedForceResignKeyboard {
                
                        self.view.addTapForView().subscribe(onNext: { [weak self] _ in
                
                            self?.view.endEditing(true)
                        }).disposed(by: disposeBag)
                
            }
        }
    }
    
    var topViewStyle : TopViewStyle = .middleTitle {
        
        didSet{
         
            switch topViewStyle {
            case .middleTitle:
                print("default")
            case .leftTitle:
                topViewLeftBtn.isHidden = true
                titleLab.font = FONT_SB(size: 20)
                titleLab.snp.remakeConstraints { make in
                    
                    make.left.equalToSuperview().offset(Margin_WIDTH)
                    make.centerY.equalToSuperview()
                }
                topViewRightBtn.contentHorizontalAlignment = .right

                topViewRightBtn.snp.remakeConstraints { make in

                    make.right.equalToSuperview()
                    make.height.equalTo(32)
                    make.width.greaterThanOrEqualTo(32)
                    make.centerY.equalToSuperview()
                }
                
             
                let mytitleLabel = UILabel()
                mytitleLabel.textAlignment = .right
                mytitleLabel.font = FONT_SB(size: 16)
                mytitleLabel.textColor =  kBlackTextColor
                topViewRightBtn.addSubview(mytitleLabel)
                mytitleLabel.text = topViewRightBtn.titleLabel?.text
                                
              if let image = topViewRightBtn.imageView?.image{
                  
                  mytitleLabel.snp.makeConstraints { make in
                      
                      make.right.equalTo(-43)
                      make.left.equalTo(Margin_WIDTH)
                      make.centerY.equalToSuperview()
                  }

                  let imgView = UIImageView()
                  imgView.image = image
                  topViewRightBtn.addSubview(imgView)
                  
                  imgView.snp.remakeConstraints({ make in
                      
                      make.right.equalToSuperview().offset(-Margin_WIDTH)
                      make.width.height.equalTo(24)
                      make.centerY.equalToSuperview()
                  })

              }else{
                  
                  mytitleLabel.snp.makeConstraints { make in
                      
                      make.right.equalTo(-Margin_WIDTH)
                      make.left.equalTo(Margin_WIDTH)
                      make.centerY.equalToSuperview()
                  }
              }
                topViewRightBtn.setTitle("", for: .normal)
                topViewRightBtn.setImage(nil, for: .normal)
                
            }
        }
    }
    
    override var title: String?{
        
        didSet{
            
            self.titleLab.text = title
        }
    }
    var imgae:UIImage? {
        didSet{
            self.headerImage.isHidden = false
            self.headerImage.image = imgae
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(headerView)
        headerView.addSubview(topView)
        //要有frame后才可以调用
//        headerView.setGradMainColor(size: CGSize(width:SCREEN_WIDTH, height: 48 + STATUSBAR_HIGH))
        headerView.backgroundColor = .white
        headerView.snp.makeConstraints { make in
            
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(48 + STATUSBAR_HIGH)
        }
        
        headerView.addSubview(headerBackgroundImage)
        headerBackgroundImage.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        headerView.addSubview(lineView)
        lineView.backgroundColor = RGBCOLOR(r: 248, g: 248, b: 248)
        lineView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
       
        topView.snp.makeConstraints { make in
            
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(STATUSBAR_HIGH)
            make.height.equalTo(48)
        }

        titleLab.removeFromSuperview()
        titleLab.textColor = kBlackTextColor
        titleLab.font = FONT_MSB(size: 18)
        titleLab.textAlignment = .center
        topView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.center.equalToSuperview().offset(-5)
            make.left.equalTo(60)
            make.right.equalTo(-60)
        }
        
        topView.addSubview(headerImage)
        headerImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.centerY.equalToSuperview().offset(-5)
        }

        topViewLeftBtn.setImage(UIImage(named: "btn_back_Normal"), for: .normal)
        topView.addSubview(topViewLeftBtn)
        topViewLeftBtn.snp.makeConstraints { make in
            
            make.left.equalTo(15)
            make.height.equalTo(54)
            
            make.centerY.equalToSuperview().offset(-5)
        }
        
        topViewLeftBtn.rx.tap.subscribe {[weak self] _ in
            
            self?.topLeftBtnClick()
        }.disposed(by:disposeBag )

        topViewRightBtn.setImage(UIImage(named: ""), for: .normal)
        topView.addSubview(topViewRightBtn)
        topViewRightBtn.snp.makeConstraints { make in
            
            make.right.equalTo(-10)
//            make.right.equalToSuperview()
            make.height.width.equalTo(32)
            make.centerY.equalToSuperview().offset(-5)
        }

        topViewRightBtn.rx.tap.subscribe {[weak self]  _ in
            
            self?.topRightBtnClick()
        }.disposed(by:disposeBag )
        
        
        topView.addSubview(topRightTwoBtn)
        topRightTwoBtn.isHidden = true
        topRightTwoBtn.snp.makeConstraints { make in
            make.right.equalTo(topViewRightBtn.snp.left).offset(-10)
            make.centerY.equalToSuperview().offset(-5)
            make.height.width.equalTo(24)
        }
        
      
        
         
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }


    @objc func topLeftBtnClick() {
        
        self.navigationController?.popViewController(animated: true)
    }

    @objc func topRightBtnClick() {
        self.RightBtnClick?()
    }

}

extension BaseHiddenNaviController {
    
    func showSingleAlert(title:String = "" , message : String , iconUrl : String = "" , buttonTitle: String = "Got it" , style: HPAlertAction.Style = .cancel , textAligment : NSTextAlignment = .center , handler: @escaping () -> Void = {}){
        
        let alert = HPAlertController(title: title,
                                      message: message ,
                                      icon: .none,
                                      alertTintColor:kBlackTextColor,
                                      textAligment: textAligment)
                
        let actionBtn = HPAlertAction(title: buttonTitle, style: style , handler: handler)
        
        if iconUrl != "" {
            alert.iconContainerView.isHidden =  false
            alert.iconContainerView.translatesAutoresizingMaskIntoConstraints = false
            alert.iconImageView.kf.setImage(with: iconUrl)
        }
        alert.addAction(actionBtn)
        self.present(alert, animated: true)
    }
    
    func popToWithControllClass(vc:AnyClass) {
        for i in 0..<(self.navigationController?.viewControllers.count)! {
            
//            self.navigationController?.viewControllers[i].isKind(of: AnyClass)
            
            if self.navigationController?.viewControllers[i].isKind(of: vc.self) == true {

                let controler = self.navigationController?.viewControllers[i]

                self.navigationController?.popToViewController(controler!, animated: true)
                break
            }

        }
    }
    
    
    
    
    
}
extension JXPagingListContainerView: JXSegmentedViewListContainer {}

extension BaseHiddenNaviController : EmptyDataSetDelegate {
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool {
            return false;
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        
        return true
    }
}
