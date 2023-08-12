//
//  BasePresentViewController.swift
//  MarketPlace
//
//  Created by WMT on 2022/6/30.
//

import UIKit
import RxSwift

class BasePresentViewController: UIViewController {

    let disposeBag = DisposeBag()
    let titleView :UIView = {
        let titleView = UIView()
        titleView.addBottomLine()
        return titleView
    }()
    
    lazy var cancelBtn:UIButton = {
        let cancelBtn = UIButton()
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.titleLabel?.font = FONT_R(size: 14)
        cancelBtn.setTitleColor(kBlack3TextColor, for: .normal)
        cancelBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else {return}
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)
        return cancelBtn
    }()

    override var title: String?{
        
        didSet{
            
            titleLabel.text = title
        }
    }
    var titleAligment : NSTextAlignment = .center {
        
        didSet{
            titleLabel.textAlignment = titleAligment
        }
    }
    
    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = FONT_SB(size: 14)
        titleLabel.textAlignment = titleAligment
        titleLabel.textColor = kBlack3TextColor
        return titleLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kMainBackgroundColor
        self.isModalInPresentation = true

        view.addSubview(titleView)
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Margin_WIDTH)
            make.right.equalToSuperview().offset(-Margin_WIDTH)
            make.center.equalToSuperview()
        }
        titleView.snp.makeConstraints { make in
            
            make.top.centerX.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            
            make.centerX.width.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-SafeAreaBottom)
        }
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension BasePresentViewController {
    
    func showSingleAlert(title:String = "" , message : String , buttonTitle: String = "Got it" , style: HPAlertAction.Style = .cancel , handler: @escaping () -> Void = {}){
        
        let alert = HPAlertController(title: title,
                                      message: message ,
                                      icon: .none,
                                      alertTintColor:kBlackTextColor)
                
        let actionBtn = HPAlertAction(title: buttonTitle, style: style , handler: handler)
        alert.addAction(actionBtn)
        self.present(alert, animated: true)
    }
    
}

