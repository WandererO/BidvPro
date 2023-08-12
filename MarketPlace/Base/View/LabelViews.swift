//
//  LabelView.swift
//  MarketPlace
//
//  Created by Work on 7/3/22.
//

import UIKit

class IconLabelView : UIView {
    
    var lineBreakMode : NSLineBreakMode = .byWordWrapping {
        didSet{myTitleLabel.lineBreakMode = lineBreakMode}
    }
    var imageUrl : String? {didSet{myImageView.kf.setImage(with: imageUrl ?? "")}}
    var title : String? {didSet{myTitleLabel.text = title}}
    var titleColor : UIColor = kBlackTextColor {didSet{myTitleLabel.textColor = titleColor}}
    var image : UIImage? {didSet{myImageView.image = image}}
    var font : UIFont = FONT_MONO_SB(size: 16) {didSet{myTitleLabel.font = font}}
    var imgHeightAndWidth : CGFloat = 16 {didSet{myImageView.snp.updateConstraints { make in make.width.height.equalTo(imgHeightAndWidth)}}}
    var margin : CGFloat = 4 {
        didSet{
            myTitleLabel.snp.updateConstraints({ make in
                
                make.left.equalTo(myImageView.snp.right).offset(margin)
            })
        }
    }
    private let myTitleLabel = UILabel()
    private let myImageView = UIImageView()


    override init(frame: CGRect) {
        
        super.init(frame: frame)
                
        self.addSubview(myTitleLabel)
        self.addSubview(myImageView)
        myImageView.image = UIImage(named: "USDC")
        myTitleLabel.textColor = kBlackTextColor
        myTitleLabel.font = font
        
        myImageView.snp.remakeConstraints({ make in
          
            make.left.equalToSuperview()
            make.height.width.equalTo(imgHeightAndWidth)
            make.centerY.equalToSuperview()
        })
        myTitleLabel.snp.remakeConstraints({ make in
            
            make.left.equalTo(myImageView.snp.right).offset(margin)
            make.right.centerY.equalToSuperview()
        })

//        myTitleLabel.numberOfLines.byteSwapped
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TwoLineLabelView : UIView{
    
    var title1 : String? {didSet{title1Label.text = title1}}
    var title2 : String? {didSet{title2Label.text = title2}}
    var value1 : String? {didSet{value1Label.text = value1}}
    var value2 : String? {didSet{value2Label.text = value2}}
    
    private let value1Label = UILabel()
    private let value2Label = UILabel()
    private let title1Label = UILabel()
    private let title2Label = UILabel()

     override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        self.corner(cornerRadius: 8)
        self.backgroundColor = kInputBGColor
                
        title1Label.text = "Minimum deposit"
        title1Label.textColor = kGreyTextColor
        title1Label.font = FONT_R(size: 12)
        self.addSubview(title1Label)
        title1Label.snp.makeConstraints { make in
            
            make.left.top.equalTo(Margin_WIDTH)
            make.height.equalTo(17)
        }
        
        title2Label.text = "Expected arrival"
        title2Label.textColor = kGreyTextColor
        title2Label.font = FONT_R(size: 12)
        self.addSubview(title2Label)
        title2Label.snp.makeConstraints { make in
            
            make.left.equalTo(Margin_WIDTH)
            make.bottom.equalTo(-Margin_WIDTH)
            make.height.equalTo(17)
        }
        
        self.addSubview(value1Label)
        value1Label.textColor = kBlackTextColor
        value1Label.font = FONT_R(size: 12)
        value1Label.textAlignment = .right
        value1Label.snp.makeConstraints { make in
            
            make.right.equalTo(-Margin_WIDTH)
            make.height.centerY.equalTo(title1Label)
        }

        self.addSubview(value2Label)
        value2Label.textColor = kBlackTextColor
        value2Label.font = FONT_R(size: 12)
        value2Label.textAlignment = .right
        value2Label.snp.makeConstraints { make in
            
            make.right.equalTo(-Margin_WIDTH)
            make.height.centerY.equalTo(title2Label)
        }
    }
}

class WarningView : UIView{
    
    var text : String? {
        didSet{
            contentLabel.text = text
            updatelbale()
        }
    }
    var warningText : String? { didSet{updatelbale()}}
    func updatelbale() {
        
        if let str = text , let warningStr = warningText {
            
            let titleStr : NSMutableAttributedString = NSMutableAttributedString.init()
            titleStr.append(NSMutableAttributedString.appendColorStrWithString(str: str , font: FONT_R(size: 12), color: kGreyTextColor))
            titleStr.append(NSMutableAttributedString.appendColorStrWithString(str: warningStr, font: FONT_R(size: 12), color: kRedColor))
            contentLabel.attributedText = titleStr
        }
    }
    
    let contentLabel = UILabel()
     override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        self.corner(cornerRadius: 8)
        self.backgroundColor = kInputBGColor
                
        let warningImgview = UIImageView(image: UIImage(named: "alert")?.withTintColor(.hexColor("FFC619")))
        self.addSubview(warningImgview)
        warningImgview.snp.makeConstraints { make in
            
            make.left.equalTo(Margin_WIDTH)
            make.height.width.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(contentLabel)
        contentLabel.textColor = kGreyTextColor
        contentLabel.numberOfLines = 0
        contentLabel.font = FONT_R(size: 12)
        contentLabel.snp.makeConstraints { make in
            
            make.left.equalTo(52)
            make.right.equalTo(-Margin_WIDTH)
            make.top.bottom.centerY.equalToSuperview()
        }
    }
}

class NetworkView : UIView{
    
    let coinLableView : IconLabelView = {
        let coinLableView = IconLabelView()
        coinLableView.imgHeightAndWidth = 24
        coinLableView.font = FONT_SB(size: 16)
        coinLableView.margin = 8
        return coinLableView
    }()
    let imgView = UIImageView(image: UIImage(named: "change")?.withTintColor(kGreyTextColor))

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        self.corner(cornerRadius: 8, toBounds: true, borderColor: kLineColor, borderWidth: 1)
        
        let titleLable = UILabel()
        self.addSubview(titleLable)
        titleLable.text = "Network"
        titleLable.font = FONT_R(size: 14)
        titleLable.textColor = kGreyTextColor
        titleLable.snp.makeConstraints { make in
            
            make.left.equalTo(Margin_WIDTH)
            make.top.equalTo(Margin_WIDTH)
            make.height.equalTo(20)
        }
        self.addSubview(coinLableView)
        coinLableView.snp.makeConstraints { make in
            
            make.left.equalTo(Margin_WIDTH)
            make.top.equalTo(titleLable.snp.bottom).offset(4)
            make.height.equalTo(25)
        }
        self.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            
            make.right.equalTo(-Margin_WIDTH)
            make.centerY.equalTo(coinLableView)
            make.width.height.equalTo(24)
        }
    }
}

class TitleValueLabelView : UIView{
    
    var title : String? {didSet{titleLabel.text = title}}
    var value : String? {didSet{valueLabel.text = value}}
    var fontSize : CGFloat = 12 {
        didSet{
            valueLabel.font = FONT_SB(size: fontSize)
            titleLabel.font = FONT_R(size: fontSize)
    }}
    var titleFont : UIFont = FONT_R(size: 14) {
        didSet{
            titleLabel.font = titleFont
    }}
    var valueFont : UIFont = FONT_R(size: 14) {
        didSet{
            valueLabel.font = valueFont
    }}
    
    var textColor : UIColor = kGreyTextColor {
        didSet{
            titleLabel.textColor = textColor
            valueLabel.textColor = textColor
    }}
    var valueTextColor : UIColor = kBlack3TextColor {
        didSet {
            valueLabel.textColor = valueTextColor
        }
    }
    var valueTextBgColor : UIColor = kGreentColor(alpha: 0.12) {
        didSet{
            valueLabel.backgroundColor = valueTextBgColor
            valueLabel.corner(cornerRadius: 4)
            valueLabel.font = FONT_R(size: 12)
            valueLabel.snp.remakeConstraints { make in
                make.height.equalTo(20)
                make.right.centerY.equalToSuperview()
            }
        }
    }
    var isLeft = false {
        
        didSet{
            if isLeft {
                
                valueLabel.snp.remakeConstraints { make in
                    
                    make.left.equalTo(90)
                    make.right.centerY.equalToSuperview()
                }
                valueLabel.textAlignment = .left
            }
        }
    }
    
    var valueLeftMargin : CGFloat? {
        didSet{
            if let valueLeftMargin{
                valueLabel.snp.remakeConstraints { make in
                    
                    make.left.equalTo(valueLeftMargin)
                    make.right.centerY.equalToSuperview()
                }
                valueLabel.textAlignment = .left
            }
        }
    }
    
    private let valueLabel = UILabel()
    private let titleLabel = UILabel()

     override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
                
        titleLabel.text = ""
        titleLabel.textColor = kGreyTextColor
        titleLabel.font = FONT_R(size: 12)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            
            make.left.centerY.equalToSuperview()
        }
        self.addSubview(valueLabel)
        valueLabel.textColor = kBlackTextColor
        valueLabel.font = FONT_R(size: 12)
        valueLabel.textAlignment = .right
        valueLabel.snp.makeConstraints { make in
            
            make.right.centerY.equalToSuperview()
        }
    }
}

class TitleValueVerticalLabelView : BaseView{
    
    var privateBlock:ButtonIsSelected?
    
    var title : String? {didSet{titleLabel.text = title}}
    var value : String? {didSet{valueLabel.text = value}}
    var subvalue : String? {didSet{subvalueLabel.text = subvalue}}
    var textAlignmentRight:Bool? {
        didSet{
            if textAlignmentRight == true{
                titleLabel.textAlignment = .right
                valueLabel.textAlignment = .right
                subvalueLabel.textAlignment = .right
                titleLabel.snp.remakeConstraints { make in
                    make.left.top.right.equalToSuperview()
                }
            }
        }
    }
    var homeTypeValue:Bool? {
        didSet{
            if homeTypeValue == true {
                valueLabel.snp.remakeConstraints { make in
                    make.left.centerY.equalToSuperview()
                }
            }
        }
    }

    var fontSize : CGFloat = 12 {
        didSet{
            valueLabel.font = FONT_SB(size: fontSize)
            titleLabel.font = FONT_R(size: fontSize)
            subvalueLabel.font = FONT_R(size: fontSize)
    }}
    
    var valueFont : UIFont = FONT_SB(size: 12) {
        didSet{
            valueLabel.font = valueFont
    }}
    var titleFont : UIFont = FONT_R(size: 12) {
        didSet{
            titleLabel.font = titleFont
            subvalueLabel.font = titleFont
    }}
    var centerOffset : CGFloat = 0 {
        didSet{
            valueLabel.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(centerOffset)
            }
    }}
    
    let valueLabel = UILabel()
    let titleLabel = UILabel()
    private let subvalueLabel = UILabel()
    
    private lazy var privateBtn :ZQButton = {
        let btn = ZQButton()
        btn.setImage(UIImage(named: "wallet_openEye"), for: .normal)
        btn.setImage(UIImage(named: "wallet_closeEye"), for: .selected)
        btn.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else{return}
            btn.isSelected = !btn.isSelected
            self.privateBlock?(btn.isSelected)
            
        }).disposed(by: disposeBag)
        return btn
    }()

     override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
                
        titleLabel.text = ""
        titleLabel.textColor = kGreyTextColor
        titleLabel.font = FONT_R(size: 12)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            
            make.left.top.equalToSuperview()
        }
        
//        self.addSubview(privateBtn)
//        privateBtn.snp.makeConstraints { make in
//            make.left.equalTo(titleLabel.snp.right).offset(5)
//            make.right.equalTo(-10)
//            make.width.height.equalTo(24)
//            make.centerY.equalTo(titleLabel)
//        }
        
        self.addSubview(valueLabel)
        valueLabel.textColor = kBlackTextColor
        valueLabel.font = FONT_R(size: 12)
//        valueLabel.textAlignment = .left
        valueLabel.snp.makeConstraints { make in
            
            make.right.left.centerY.equalToSuperview()
//            make.right.greaterThanOrEqualTo(titleLabel)
//            make.right.equalToSuperview().offset(-10)
        }
        self.addSubview(subvalueLabel)
        subvalueLabel.textColor = kGreyTextColor
        subvalueLabel.font = FONT_R(size: 12)
//        subvalueLabel.textAlignment = .right
        subvalueLabel.snp.makeConstraints { make in
            
            make.left.right.bottom.equalToSuperview()
        }
    }
}


class BackgroundLabel : UIView{
    
    enum ColorState {
        case up
        case down
        case still
    }
    var state : ColorState? {
        didSet{
            if let state{
                switch state{
                case .up:
                    self.backColor = kGreentColor(alpha: 0.12)
                    self.textColor = kGreentColor
                case .down:
                    self.backColor = kRedColor(alpha: 0.12)
                    self.textColor = kRedColor
                case .still:
                    self.backColor = .hexColor("F5F5F5", alpha: 0.12)
                    self.textColor = kGreyTextColor
                }
            }}}
    lazy var backColor : UIColor = kGreyTextColor {didSet{self.backgroundColor = backColor}}
    var title : String? {didSet{label.text = title}}
    var textColor : UIColor = kGreyTextColor {didSet{label.textColor = textColor}}
    var font : UIFont = FONT_SB(size: 12) { didSet{ label.font = font }}
    var margin : CGFloat = 4{
        didSet{
            label.snp.updateConstraints { make in
                
                make.left.equalTo(margin)
                make.right.equalTo(-margin)
            }
        }}
    private let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    func setUI(){
        self.backgroundColor = backColor
        label.text = ""
        label.textColor = textColor
        label.font = font
        label.textAlignment = .center
        self.addSubview(label)
        label.snp.makeConstraints { make in
            
            make.left.equalTo(self.margin)
            make.right.equalTo(-self.margin)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


