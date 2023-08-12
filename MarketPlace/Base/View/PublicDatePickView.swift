//
//  PublicDatePickView.swift
//  MarketPlace
//
//  Created by mac on 2023/3/15.
//

import UIKit

class PublicDatePickView: UIView {
    let disposeBag = DisposeBag()
    var timeStr = ""
    var selectTimeBlock:SelectBlockStr?
    private lazy var titleLab : UILabel = {
        let lab = UILabel()
        lab.text = "选择时间"
        lab.textColor = .hexColor("333333")
        lab.font = FONT_SB(size: 16)
        lab.textAlignment = .left
        return lab
    }()
    
    private lazy var closeBtn : ZQButton = {
        let btn = ZQButton()
        btn.setTitle("关闭", for: .normal)
        btn.titleLabel?.font = FONT_R(size: 16)
        btn.setTitleColor(.hexColor("999999"), for: .normal)
        btn.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else{return}
            self.timeStr = ""
            self.dismiss()
        }).disposed(by: disposeBag)
        return btn
    }()
    
    lazy var datePick : UIDatePicker = {
        let pick = UIDatePicker()
        pick.maximumDate = Date.init(timeIntervalSinceNow: 0)
        pick.datePickerMode = .date
        if #available(iOS 13.4, *) {
            pick.preferredDatePickerStyle = .wheels
        }
        pick.addTarget(self, action: #selector(pickerAction), for: .valueChanged)
        pick.locale = Locale(identifier:"zh_cn")  // 语言设置
//        pick.rx.
        return pick
    }()
    
    
    private lazy var updataBtn : ZQButton = {
        let btn = ZQButton()
        btn.backgroundColor = .hexColor("5171FF")
        btn.corner(cornerRadius: 6)
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(UIColor.hexColor("FFFFFF"), for: .normal)
        btn.titleLabel?.font = FONT_SB(size: 18)
        btn.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else{return}
            if self.timeStr == "" {
                HudManager.showOnlyText("请选择日期")
                return
            }
            self.selectTimeBlock?(self.timeStr)
            self.dismiss()
        }).disposed(by: disposeBag)
        return btn
    }()
    
    func show() {
        UIApplication.shared.delegate?.window??.addSubview(self)
    }
    func dismiss() {
        self.removeFromSuperview()
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(0, 0, 0, 0.3)
        
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        
        let now = Date()
        timeStr = Date.string(ymd: now)
        
        
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.corner(cornerRadius: 15)
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(420)
            make.bottom.equalToSuperview()
        }
        
        bgView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(15)
            make.width.equalTo(100)
            make.height.equalTo(22)
        }
        
        bgView.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(15)
            make.width.equalTo(35)
            make.height.equalTo(22)
        }
        
        let lineV = UIView()
        lineV.backgroundColor = .hexColor("F5F5F5")
        bgView.addSubview(lineV)
        lineV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLab.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
        
        bgView.addSubview(datePick)
        datePick.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
            make.top.equalTo(lineV.snp.bottom).offset(15)
        }
        
        bgView.addSubview(updataBtn)
        updataBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(datePick.snp.bottom).offset(40)
            make.height.equalTo(47)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension PublicDatePickView{
    
    @objc func pickerAction(picker:UIDatePicker) {
//        print("\(picker.date.timeStamp)")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.string(from: picker.date))
        
        timeStr = formatter.string(from: picker.date)
    }

}

