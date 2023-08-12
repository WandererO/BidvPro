//
//  FuturesSheetBaseView.swift
//  MarketPlace
//
//  Created by WMT on 2022/7/18.
//

import UIKit
import RxSwift

class BottomSheetBaseView: UIView {

    let disposebag = DisposeBag()
    
    var title : String? {  didSet{  titleLabel.text = title } } //设置title
    var titleAligment : NSTextAlignment = .center {  didSet{  titleLabel.textAlignment = titleAligment } } //设置title

    let titleLabel = UILabel()

    lazy var bgView : UIView = {
        let view = UIView()
        view.backgroundColor = .hexColor("000000", alpha: 0.2)
        return view
    }()

    lazy var contentView : UIView = {
        let contentView = UIView()
        contentView.corner(cornerRadius: 12)
        contentView.backgroundColor = .white
        return contentView
    }()
    lazy var bottomView : UIView = {
        let bottomView = UIView()
//        btn.corner(cornerRadius: 4)
//        btn.titleLabel?.font = FONTDIN(size: 16)
//        btn.addTarget(self, action: #selector(bottomBtnClcik), for: .touchUpInside)
//        btn.backgroundColor = .hexColor("FCD283")
//        btn.setTitleColor(UIColor.hexColor("FFFFFF"), for: .normal)
//        btn.setTitle("取消", for: .normal)
        return bottomView
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(bgView)
        bgView.addSubview(contentView)
        contentView.addSubview(bottomView)
        
        titleLabel.textColor = kBlackTextColor
        titleLabel.font = FONT_SB(size: 14)
        titleLabel.textAlignment = titleAligment
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(LR_Margin)
            make.right.equalTo(-LR_Margin)
            make.height.equalTo(40)
        }
        
//        let closeBtn = UIButton()
//        closeBtn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
//        closeBtn.setImage(UIImage(named: "iconcolse"), for: .normal)
//        contentView.addSubview(closeBtn)
//        closeBtn.snp.makeConstraints { make in
//
//            make.right.top.equalToSuperview()
//            make.width.equalTo(46)
//            make.height.equalTo(52)
//        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)

//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];


        self.frame = UIScreen.main.bounds
        self.bgView.frame = self.frame
        
        contentView.snp.makeConstraints { make in
            
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo((243 + SafeAreaBottom))
        }
        
        bottomView.snp.makeConstraints { make in
            
            make.bottom.equalToSuperview().offset( -(SafeAreaBottom + 12))
            make.left.right.equalToSuperview()
            make.height.equalTo(48)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
}
extension BottomSheetBaseView{

    @objc func showKeyboard(notification:NSNotification){
        
//        NSDictionary *userInfo = [notification userInfo];
//            NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//            CGRect keyboardRect = [value CGRectValue];
//            int height = keyboardRect.size.height;
        
        let userinfo: NSDictionary = notification.userInfo! as NSDictionary
        let nsValue = userinfo.object(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRec = nsValue.cgRectValue
        let height = keyboardRec.size.height

        var rect:CGRect = self.contentView.frame
        rect.origin.y =  SCREEN_HEIGHT - self.contentView.bounds.size.height - height + 20
        self.contentView.frame = rect
        
    }
    @objc func hideKeyboard(notification:NSNotification){
//        let userinfo: NSDictionary = notification.userInfo! as NSDictionary
//        let nsValue = userinfo.object(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
//        let keyboardRec = nsValue.cgRectValue
//        let height = keyboardRec.size.height

        var rect:CGRect = self.contentView.frame
        rect.origin.y = SCREEN_HEIGHT -  self.contentView.bounds.size.height
        self.contentView.frame = rect
    }

    public func show() {
        UIApplication.shared.windows.first?.addSubview(self)
        
        UIView.animate(withDuration: 0.3) {
            var rect:CGRect = self.contentView.frame
            rect.origin.y -= self.contentView.bounds.size.height
            self.contentView.frame = rect
        }
    }
    @objc public func dismiss() {
        UIView.animate(withDuration: 0.3) {
            var rect:CGRect = self.contentView.frame
            rect.origin.y += self.contentView.bounds.size.height
            self.contentView.frame = rect
        } completion: { isok in
            self.removeAllSubViews()
            self.removeFromSuperview()
        }

    }
    /// 移除所有子控件
    func removeAllSubViews(){
        if self.subviews.count>0{
            self.subviews.forEach({$0.removeFromSuperview()})
        }
    }
}


