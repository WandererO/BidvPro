//
//  InputViews.swift
//  MarketPlace
//
//  Created by mac on 2023/3/1.
//

import UIKit

enum InputType : Int {
    case PhoneNumType, EmailType, NomalType, SearchType, VerifyCodeType, PasswordType , C2c, ChoiseType , Contact , ContractPriceType
}

class InputBGView : UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
//        self.backgroundColor = kInputBGColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.corner(cornerRadius: self.frame.size.height / 2)
    }
}

class InputView : UIView{
    
    private let disposeBag = DisposeBag()

    var rightBtnClick : SelectBlock?
    var verifyCodeClick : NormalBlock?
    var ChoiseCountryNum : NormalBlock?
    var BindToBlock:NormalBlock?
    
    var inputEnabledBlock:NormalBlock?
    
    var isInputEnabled = true
    
    var isHaveLefeImg : Bool = false
//    var ishaveCornorColor : Bool = true
    
    var didBeginEdting:Bool? {
        didSet{
            if didBeginEdting == true{
//                self.corner(cornerRadius: 6, borderColor: .hexColor("5171FF"), borderWidth: 1)
            }else{
//                self.corner(cornerRadius: 6, borderColor: .hexColor("E1E1E1"), borderWidth: 0)
            }
        }
    }
    
    var isHiddenChoiseBtn = true {
        didSet{
            inputTextField.snp.remakeConstraints { make in
                make.bottom.top.equalToSuperview()
                make.left.equalToSuperview().offset(15)
                make.right.equalTo(choiseBtn2.snp.left).offset(5)
            }
        }
    }

    var image = UIImage(named: ""){ // 设置图片
        
        didSet{
            iconImageView.image = image
            isHaveLefeImg = true
//            updateTextField()
        }
    }
    
    var urlImage = "" {
        didSet{
            iconImageView.kf.setImage(with: urlImage)
        }
    }
    
    var btnImage = UIImage(named: "") {
        didSet {
            choiseBtn1.setImage(btnImage, for: .normal)
        }
    }
    
    var secondBtnImage = UIImage(named: "") {
        didSet {
            choiseBtn2.setImage(secondBtnImage, for: .normal)
            
            choiseBtn2.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.width.height.equalTo(24)
                make.right.equalTo(choiseBtn1.snp.left).offset(-5)
            }
            inputTextField.snp.remakeConstraints { make in
                make.bottom.top.equalToSuperview()
                make.left.equalToSuperview().offset(15)
                make.right.equalTo(choiseBtn2.snp.left).offset(5)
            }
        }
    }

    var text : String { //设置/获取输入内容
        
        set{
            self.inputTextField.text = newValue
        }get{
            self.inputTextField.text ?? ""
        }
    }
    
    var isWarning = false {
        didSet{
            self.corner(cornerRadius: 8)
            self.layer.borderWidth = 1
            self.layer.borderColor = kLineColor.cgColor
            tipLabel.textColor = .hexColor("666666")
        }
    }
    
    
    
    var tipText : String?  { //用于提示
        set{
            tipLabel.text = newValue
            
            if isWarning {
                if newValue!.count > 0{
                    self.corner(cornerRadius: 8)
                    self.clipsToBounds = false
                    self.layer.borderWidth = 1
                    self.layer.borderColor = kRedColor.cgColor
                    tipLabel.textColor = kRedColor
                    //                self.layer.borderColor = kRedColor.cgColor
                }
            }else{
                self.corner(cornerRadius: 8)
                self.layer.borderWidth = 1
                self.layer.borderColor = kLineColor.cgColor
                tipLabel.textColor = .hexColor("666666")
            }
//            else {
//                self.layer.borderWidth = 0.0
////                self.layer.borderColor = kInputBGColor.cgColor
//            }
        }
        get{
            return tipLabel.text
        }
    }
    
    var tipAligment : NSTextAlignment? {
    
        didSet{
            if let tipAligment{
                self.tipLabel.textAlignment = tipAligment
            }
        }
    }
    
    func updateTextField() {
        inputTextField.snp.remakeConstraints { make in
            
            if isHaveLefeImg {
                make.left.equalTo( iconImageView.snp.right ).offset(1)
            }
            else{
                make.left.equalToSuperview().offset(Margin_WIDTH+5)
            }
            make.top.bottom.equalToSuperview()
            
            if isSecureTextEntry {

                make.right.equalTo( privateBtn.snp.left ).offset( -10 )
            }else{
                make.right.equalToSuperview().offset(-Margin_WIDTH)
            }
        }
    }
    ///是否隐私输入
    ///true: 显示 privateBtn
    var isSecureTextEntry : Bool = false{
        
        didSet{
            privateBtn.isHidden = !isSecureTextEntry
            inputTextField.isSecureTextEntry = !privateBtn.isSelected
//            updateTextField()
        }
    }
    
    lazy var rightImageTitleBtn : TitleImgButton = {
        let selectCountyBtn = TitleImgButton()
        selectCountyBtn.title = "CNY"
        selectCountyBtn.rightImage = UIImage(named: "c2c_select_arrow_down")
        selectCountyBtn.leftImage = UIImage(named: "c2c_select_arrow_down")
        selectCountyBtn.margin = 5
        selectCountyBtn.font = FONT_SB(size: 16)
        selectCountyBtn.imageWidth = 24
        selectCountyBtn.backgroundColor = .clear
        selectCountyBtn.font = FONT_R(size: 14)
        selectCountyBtn.leftImage = UIImage(named: "CNY")
        selectCountyBtn.imageMargin = 10
        return selectCountyBtn
    }()
    
    lazy var choiseBtn1 : UIButton = {//右边箭头按钮
        let btn = UIButton()
        btn.setTitleColor(.hexColor("#5171FF"), for: .normal)
        btn.titleLabel?.font = FONT_R(size: 14)
//        btn.setImage(UIImage(named: "user_arrow"), for: .normal)
        btn.tag = 0
        btn.rx.tap.subscribe ({ [weak self] _ in
            guard let self = self else{return}
            self.rightBtnClick?(btn.tag)
        }).disposed(by: disposeBag)
        btn.isHidden = true
        return btn
    }()
    lazy var choiseBtn2 : UIButton = {//右边第二个按钮
        let btn = UIButton()
//        btn.setImage(UIImage(named: "withdraw_local"), for: .normal)
        btn.tag = 1
        btn.setTitleColor(.hexColor("333333"), for: .normal)
        btn.titleLabel?.font = FONT_R(size: 14)
        btn.rx.tap.subscribe ({ [weak self] _ in
            guard let self = self else{return}
            self.rightBtnClick?(btn.tag)
        }).disposed(by: disposeBag)
        btn.isHidden = true
        return btn
    }()
    
    //右边按钮 私密输入按钮
    lazy var privateBtn : ZQButton = {
        
        let btn = ZQButton()
        btn.setImage(UIImage(named: "eye_close"), for: .normal)
        btn.setImage(UIImage(named: "eye_open"), for: .selected)
        btn.rx.tap.subscribe ({ [weak self] _ in
            guard let self = self else{return}
            btn.isSelected = !btn.isSelected
            self.inputTextField.isSecureTextEntry = !btn.isSelected
        }).disposed(by: disposeBag)
        btn.isHidden = true
        return btn
    }()
    
    var isStartTimer = true
    lazy var verifyCodeBtn : ZQButton = {
        let btn = ZQButton()
        btn.setTitle("获取验证码", for: .normal)
        btn.setTitleColor(.hexColor("5171FF"), for: .normal)
        btn.titleLabel?.font = FONT_R(size: 14)
        btn.rx.tap.subscribe ({ [weak self] _ in
            guard let self = self else{return}
            self.verifyCodeClick?()
            btn.countDown(count: 60, isStart: self.isStartTimer)
        }).disposed(by: disposeBag)
        btn.isHidden = true
        return btn
    }()
    
    lazy var bindBtn : ZQButton = {
        let btn = ZQButton()
        btn.setTitle("VND", for: .normal)
//        accountLab.textColor = RGBCOLOR(r: 140, g: 151, b: 156)
        btn.setTitleColor(RGBCOLOR(r: 140, g: 151, b: 156), for: .normal)
        btn.titleLabel?.font = FONT_M(size: 14)
        btn.rx.tap.subscribe ({ [weak self] _ in
            guard let self = self else{return}
            self.BindToBlock?()
        }).disposed(by: disposeBag)
        btn.isHidden = true
        return btn
    }()
    
    lazy var phoneNumBtn : TitleImgButton =  {
        let btn = TitleImgButton()
        btn.backgroundColor = .clear
        btn.rightImage = UIImage(named: "login_more")
        btn.title = "+86"
        btn.margin = 1
        btn.imageWidth = 24
        btn.textColor = .hexColor("333333")
        btn.textAligment = .center
        btn.font = FONT_R(size: 14)
        btn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else{return}
            self.ChoiseCountryNum?()
        }).disposed(by: disposeBag)
        btn.isHidden = true
        return btn
    }()
    private lazy var lineV : UIView = {
        let line = UIView()
        line.backgroundColor = .hexColor("979797")
        line.isHidden = true
        return line
    }()
    
    var digit :Int = 0//小数位
    var isNumber :Bool = false {
        didSet{
            self.inputTextField.keyboardType = .decimalPad
        }
    } //只能输入数字
    var cantNumber:Bool = false//不能输入数字
    var cantSpecial:Bool = false //不能输入特殊字符
    var maxCount :Int = 0 //只能输入数字
    var maxValue :Double? //最大的数字
    //输入框
    lazy var inputTextField : BaseTextField = {
        
        let tf  = BaseTextField()
        let placeholderText = NSAttributedString(string: " ",
                                                    attributes: [NSAttributedString.Key.foregroundColor: RGBCOLOR(r: 140, g: 151, b: 156)])
        tf.attributedPlaceholder = placeholderText
        tf.clearButtonMode = .whileEditing
        let clearButton : UIButton = tf.value(forKey: "_clearButton") as! UIButton
        clearButton.tintColor = kGreyTextColor
        tf.delegate = self
        tf.autocapitalizationType = .none
        
        tf.font = FONT_SB(size: 14)
        return tf
    }()
    
    func setInputFieldType(typeI:InputType) {
        switch typeI {
        case.SearchType:
            
            iconImageView.snp.makeConstraints { make in
                
                make.left.equalToSuperview().offset(5)
                make.centerY.equalToSuperview().offset(-1)
                make.width.height.equalTo(24)
            }
            inputTextField.snp.makeConstraints { make in
                make.left.equalTo( iconImageView.snp.right ).offset(1)
                make.top.bottom.equalToSuperview()
                make.right.equalToSuperview().offset(-Margin_WIDTH)
            }
            break;
        case .EmailType:
            print("Email======")
            break;
        case.PhoneNumType:
            inputTextField.keyboardType = .numberPad
            self.corner(cornerRadius: 6)
            self.addSubview(phoneNumBtn)
            phoneNumBtn.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(15)
                make.centerY.equalToSuperview()
                make.height.equalTo(30)
                make.width.equalTo(70)
            }
            phoneNumBtn.isHidden = false
            self.addSubview(lineV)
            lineV.snp.makeConstraints { make in
                make.left.equalTo(phoneNumBtn.snp.right).offset(15)
                make.centerY.equalToSuperview()
                make.width.equalTo(1)
                make.height.equalTo(30)
            }
            lineV.isHidden = false
            inputTextField.font = FONT_R(size: 14)
            self.backgroundColor = .hexColor("F4F5F7")
            inputTextField.snp.makeConstraints { make in
                make.right.top.height.equalToSuperview()
                make.left.equalTo(lineV.snp.right).offset(15)
            }
            
            
//            print("phone======")
            break;
        case.PasswordType://密码
            
            inputTextField.keyboardType = .asciiCapable
            self.corner(cornerRadius: 6)
            inputTextField.font = FONT_R(size: 14)
            self.backgroundColor = .hexColor("F4F5F7")
            inputTextField.clearButtonMode = .never
            iconImageView.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(20)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(24)
            }
            inputTextField.snp.makeConstraints { make in
                make.left.equalTo( iconImageView.snp.right ).offset(20)
                make.top.bottom.equalToSuperview()
                make.right.equalToSuperview().offset(-Margin_WIDTH)
            }
            privateBtn.isHidden = false
            print("nomal======")
            break;
        case .VerifyCodeType: //获取验证码
            self.corner(cornerRadius: 6)
            inputTextField.keyboardType = .numberPad
            inputTextField.font = FONT_R(size: 14)
            self.backgroundColor = .hexColor("F4F5F7")
            if verifyCodeBtn.isHidden == true {
                inputTextField.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.right.equalTo(privateBtn.snp.left).offset(-10)
                    make.left.equalToSuperview().offset(15)
                    
                }
            }else{
                inputTextField.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.right.equalTo(verifyCodeBtn.snp.left).offset(-10)
                    make.left.equalToSuperview().offset(15)
                    
                }
            }
            
            verifyCodeBtn.isHidden = false
            privateBtn.isHidden = true
            break;
        case .NomalType:
            self.corner(cornerRadius: 6)
            inputTextField.font = FONT_R(size: 14)
            self.backgroundColor = .hexColor("F4F5F7")
            inputTextField.snp.makeConstraints { make in
                make.bottom.top.right.equalToSuperview()
                make.left.equalToSuperview().offset(15)
            }
            
            break;
        case .C2c:
            self.corner(cornerRadius: 6 ,borderColor: .hexColor("CCCCCC"),borderWidth: 1)
            inputTextField.font = FONT_R(size: 14)
            
            self.addSubview(rightImageTitleBtn)
            rightImageTitleBtn.snp.makeConstraints { make in
                make.right.height.centerY.equalToSuperview()
                make.width.greaterThanOrEqualTo(110)
            }
            
            inputTextField.snp.remakeConstraints { make in
                make.bottom.top.equalToSuperview()
                make.left.equalToSuperview().offset(15)
                make.right.equalTo(rightImageTitleBtn.snp.left)
            }
            verifyCodeBtn.isHidden = true
            privateBtn.isHidden = true

            break;
        case .Contact:
            inputTextField.font = FONT_M(size: 14)
            rightImageTitleBtn.backgroundColor = .clear
            rightImageTitleBtn.font = FONT_M(size: 14)
            rightImageTitleBtn.leftImage = nil
            rightImageTitleBtn.rightImage = UIImage(named: "contract_down")?.withTintColor(kBlack3TextColor)
            rightImageTitleBtn.imageMargin = 10
            rightImageTitleBtn.imageWidth = 10
            rightImageTitleBtn.margin = 5
            rightImageTitleBtn.textAligment = .right

            self.addSubview(rightImageTitleBtn)
            rightImageTitleBtn.snp.makeConstraints { make in
                make.right.height.centerY.equalToSuperview()
                make.width.equalTo(80)
            }
            inputTextField.snp.remakeConstraints { make in
                make.bottom.top.equalToSuperview()
                make.left.equalToSuperview().offset(15)
                make.right.equalTo(rightImageTitleBtn.snp.left)
            }
            verifyCodeBtn.isHidden = true
            privateBtn.isHidden = true

            break;
        case .ContractPriceType:
            inputTextField.font = FONT_M(size: 14)
            rightImageTitleBtn.backgroundColor = .clear
            rightImageTitleBtn.font = FONT_M(size: 14)
            rightImageTitleBtn.leftImage = nil
            rightImageTitleBtn.rightImage = nil
            rightImageTitleBtn.margin = 10
            rightImageTitleBtn.textAligment = .left

            self.addSubview(rightImageTitleBtn)
            rightImageTitleBtn.snp.makeConstraints { make in
                make.right.height.centerY.equalToSuperview()
                make.width.equalTo(60)
            }
            inputTextField.snp.remakeConstraints { make in
                make.bottom.top.equalToSuperview()
                make.left.equalToSuperview().offset(15)
                make.right.equalTo(rightImageTitleBtn.snp.left)
            }
            verifyCodeBtn.isHidden = true
            privateBtn.isHidden = true

            break;

        case .ChoiseType:
            choiseBtn1.isHidden = false
            self.corner(cornerRadius: 6)
            inputTextField.font = FONT_R(size: 14)
            self.backgroundColor = .hexColor("F4F5F7")
            if isHaveLefeImg == true {//输入框左边带图片
                iconImageView.snp.makeConstraints { make in
                    
                    make.left.equalToSuperview().offset(10)
                    make.centerY.equalToSuperview()
                    make.width.height.equalTo(24)
                }
                inputTextField.snp.makeConstraints { make in
                    make.left.equalTo( iconImageView.snp.right ).offset(5)
                    make.top.bottom.equalToSuperview()
                    make.right.equalTo(choiseBtn1.snp.left)
                }
                
            }else {
                if isHiddenChoiseBtn == false {
                    inputTextField.snp.makeConstraints { make in
                        make.bottom.top.equalToSuperview()
                        make.left.equalToSuperview().offset(15)
                        make.right.equalTo(choiseBtn2.snp.left).offset(10)
                    }
                } else {
                    inputTextField.snp.makeConstraints { make in
                        make.bottom.top.equalToSuperview()
                        make.left.equalToSuperview().offset(15)
                        make.right.equalTo(choiseBtn1.snp.left)
                    }
                }
                
            }
            
            break;

        }
    }
    
    private let iconImageView = UIImageView()
    
    private lazy var tipLabel : UILabel = {
        
        let label = UILabel()
        label.textColor = kRedColor
        label.font = FONT_R(size: 12)
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setUI()
    }
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setUI()
//        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = false

    }
}

extension InputView{
    
    func setUI() {

        self.addSubview(iconImageView)

        self.addSubview(inputTextField)
        self.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { make in
            
            make.left.right.equalToSuperview()
            make.top.equalTo(self.snp.bottom)
            make.height.greaterThanOrEqualTo(20)
        }
        
        self.addSubview(privateBtn)
        privateBtn.snp.makeConstraints { make in
            
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
            make.right.equalTo(-Margin_WIDTH)
        }
        
        self.addSubview(verifyCodeBtn)
        verifyCodeBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(75)
            make.height.equalTo(20)
            make.right.equalTo(-Margin_WIDTH)
        }
        
        self.addSubview(bindBtn)
        bindBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(45)
            make.height.equalTo(20)
            make.right.equalTo(-Margin_WIDTH)
        }
        
        self.addSubview(choiseBtn1)
        choiseBtn1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(32)
            make.right.equalToSuperview().offset(-8)
        }
        
        self.addSubview(choiseBtn2)
        choiseBtn2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
            make.width.equalTo(45)
            make.right.equalTo(choiseBtn1.snp.left).offset(-5)
        }
    }
}

extension InputView : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if isInputEnabled == false {
            
            self.inputEnabledBlock?()
            return false
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.didBeginEdting = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.didBeginEdting = false
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

//        if textField.text?.isEmpty == true {
//            privateBtn.snp.updateConstraints { make in
//                make.right.equalTo(-Margin_WIDTH)
//            }
//        }else{
//            privateBtn.snp.updateConstraints { make in
//                make.right.equalTo(-Margin_WIDTH - 15)
//            }
//        }
        
        if string == " " {
            return false
        }
        if string == ""{
            
            return true
        }
        if maxCount != 0 ,textField.text?.count ?? 0 > maxCount,string != ""{
            
            return false
        }
        
        if self.isNumber {
            let numbers : NSCharacterSet = NSCharacterSet(charactersIn: "0123456789.")
            let pointRange = (textField.text! as NSString).range(of: ".")
                        
            if (textField.text == "" || digit == 0) && string == "." {
                return false
            }
            
            if let maxValue , isNumber {
                
                let currentValue = Double((textField.text ?? "0") + string) ?? 0
                if currentValue > maxValue {
                    return false
                }
            }

            /// 小数点后8位
            let tempStr = textField.text!.appending(string)
            let strlen = tempStr.count
            if pointRange.length > 0 && pointRange.location > 0{//判断输入框内是否含有“.”。
                if string == "." {
                    return false
                }
                
                if strlen > 0 && (strlen - pointRange.location) > digit + 1 {//当输入框内已经含有“.”，当字符串长度减去小数点前面的字符串长度大于需要要保留的小数点位数，则视当次输入无效。
                    return false
                }
            }
                        
            let zeroRange = (textField.text! as NSString).range(of: "0")
            if zeroRange.length == 1 && zeroRange.location == 0 { //判断输入框第一个字符是否为“0”
                if !(string == "0") && !(string == ".") && textField.text?.count == 1 {//当输入框只有一个字符并且字符为“0”时，再输入不为“0”或者“.”的字符时，则将此输入替换输入框的这唯一字符。
                    textField.text = string
                    return false
                }else {
                    if pointRange.length == 0 && pointRange.location > 0 {//当输入框第一个字符为“0”时，并且没有“.”字符时，如果当此输入的字符为“0”，则视当此输入无效。
                        if string == "0" {
                            return false
                        }
                    }
                }
            }
            
            
            let scanner = Scanner(string: string)
            if !scanner.scanCharacters(from: numbers as CharacterSet, into: nil) && string.count != 0 {
                return false
            }
            return true
        }
        
        if cantNumber == true {///禁止输入数字
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let expression = "^[0-9]*([0-9])?$"
            let regex = try!  NSRegularExpression(pattern: expression, options: .allowCommentsAndWhitespace)
            let numberOfMatches =  regex.numberOfMatches(in: newString, options:.reportProgress,    range:NSMakeRange(0, newString.count))
            if  numberOfMatches > 0{
                 
                 return false
            }
        }
        
        if cantSpecial == true{///禁止输入特殊符号
            let pattern = "[^A-Za-z\\u4E00-\\u9FA5\\d]"
            let expression = try! NSRegularExpression(pattern: pattern, options: .allowCommentsAndWhitespace)
            let numberOfCharacters = expression.numberOfMatches(in: string, options: .reportProgress, range: NSMakeRange(0, (string as NSString).length))
            if numberOfCharacters > 0 {
                return false
            }
        }
        
        
        
        return true
    }
}
 

class OTCInputView : UIView {
    
    var rightClick : NormalBlock?
    var rightAllClickBlock:NormalBlock?
    private let disposeBag = DisposeBag()

    var digit = 0 //小数位
    var isNumber = false //小数位

    lazy var inputTextField : UITextField = {
        
        let tf  = UITextField()
        tf.delegate = self
        let placeholderText = NSAttributedString(string: " ",
                                                    attributes: [NSAttributedString.Key.foregroundColor: kGreyTextColor])
        tf.attributedPlaceholder = placeholderText
        tf.font = FONT_SB(size: 16)
        return tf
    }()

    var title : String? {didSet{titleLabel.text = title }}
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = kBlack3TextColor
        label.font = FONT_SB(size: 14)
        label.numberOfLines = 1
        label.text = ""
        return label
    }()
    
    var leftTip : String?{
        didSet{
            leftTipLabel.text = leftTip
        }
    }
    private lazy var leftTipLabel : UILabel = {
        
        let label = UILabel()
        label.textColor = kRedColor
        label.font = FONT_R(size: 10)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = ""
        return label
    }()
    var rightTip : String?{
        didSet{
            rightTipLabel.text = rightTip
        }
    }
    
    private lazy var rightTipLabel : UILabel = {
        
        let label = UILabel()
        label.textColor = kdefaultPlaceHoderColor
        label.font = FONT_R(size: 10)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    
    var rightTextColor : UIColor = kBlack3TextColor { didSet{  rightTitleLabel.textColor = rightTextColor}}
    var rightButtontitle : String? {didSet{
        rightTitleLabel.text = rightButtontitle
    }}

    var imageUrl : String? { didSet{
        if let imageUrl{
            leftImageView.kf.setImage(with: imageUrl)
    }}}
    lazy var rightTitleLabel : UILabel = {
        let uilabel = UILabel()
        uilabel.text = "USDT"
        uilabel.textColor = rightTextColor
        uilabel.font = FONT_R(size: 18)
        uilabel.setContentHuggingPriority(.required, for: .horizontal)
        uilabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        return uilabel
    }()
    
    lazy var rightAllBtn : ZQButton = {
        let btn = ZQButton()
        btn.setTitle("全部".localString(), for: .normal)
        btn.setTitleColor(kMainColor, for: .normal)
        btn.titleLabel?.font = FONT_M(size: 14)
        btn.isHidden = true
        btn.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else{return}
            self.rightAllClickBlock?()
        }).disposed(by: disposeBag)
        return btn
    }()
    
    let leftImageView = UIImageView()
    let rightImageView = UIImageView()
    
    

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.corner(cornerRadius: self.frame.size.height / 2)
    }
    
    func setUI(){
        self.clipsToBounds = false
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            
            make.bottom.equalTo(self.snp.top).offset(-10)
            make.left.equalToSuperview()
            make.height.equalTo(20)
        }
        
        let stackView = UIStackView()
        stackView.axis = .horizontal // 水平方向布局
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.addArrangedSubviews([leftTipLabel, UIView() ,rightTipLabel])
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.snp.bottom).offset(5)
            make.height.greaterThanOrEqualTo(15)
        }

        let rightStack = UIStackView(axis: .horizontal ,spacing: 5 ,alignment: .center, distribution: .fill)
        rightStack.addArrangedSubviews([leftImageView,rightTitleLabel,rightImageView, rightAllBtn])

        rightImageView.image = UIImage(named: "c2c_select_arrow_down")
        [leftImageView , rightImageView].snp.makeConstraints { make in
            make.height.width.equalTo(24)
        }
        rightAllBtn.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        
        rightStack.isUserInteractionEnabled = true
        rightStack.addTapForView().subscribe(onNext: { [weak self] _ in
            guard let self = self else {return}
            self.rightClick?()
        }).disposed(by: disposeBag)

        let inputStackView = UIStackView(axis: .horizontal ,spacing: 5 ,alignment: .fill, distribution: .fillProportionally)
        inputStackView.addArrangedSubview(inputTextField)
        inputStackView.addArrangedSubview(UIView())
        inputStackView.addArrangedSubview(rightStack)

        rightStack.setContentHuggingPriority(.required, for: .horizontal)
        rightStack.setContentCompressionResistancePriority(.required, for: .horizontal)
                
        self.addSubview(inputStackView)
        inputStackView.snp.makeConstraints { make in
            make.left.equalTo(Margin_WIDTH)
            make.right.equalTo(-Margin_WIDTH)
            make.top.bottom.equalToSuperview()
        }

        self.backgroundColor = kMainBackgroundColor
        self.corner(cornerRadius: 6)
        
        let bgLayer1 = CALayer()
        bgLayer1.frame = self.bounds
        bgLayer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.layer.addSublayer(bgLayer1)
        // shadowCode
        self.layer.shadowColor = UIColor(red: 0.66, green: 0.69, blue: 0.8, alpha: 0.2).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 8

    }
}

extension OTCInputView :  UITextFieldDelegate{
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == ""{
            return true
        }
        if !self.isNumber {
            return true
        }else{
            
//            print("小数点>>>>>>>>>>    \(digit)")
            /// 4.检查小数点后位数限制 (小数点后最多输入2位)
//            if let ran = textField.text!.range(of: "."), range.location - NSRange(ran, in: textField.text!).location > 3 {
//                    return false
//                }
           
            let scanner = Scanner(string: string)
            let numbers : NSCharacterSet = NSCharacterSet(charactersIn: "0123456789.")
            let pointRange = (textField.text! as NSString).range(of: ".")
                        
            if (textField.text == "" || digit == 0) && string == "." {
                return false
            }
            /// 小数点后8位
            let tempStr = textField.text!.appending(string)
            let strlen = tempStr.count
            if pointRange.length > 0 && pointRange.location > 0{//判断输入框内是否含有“.”。
                if string == "." {
                    return false
                }
                
                if strlen > 0 && (strlen - pointRange.location) > digit + 1 {//当输入框内已经含有“.”，当字符串长度减去小数点前面的字符串长度大于需要要保留的小数点位数，则视当次输入无效。
                    return false
                }
            }
                        
            let zeroRange = (textField.text! as NSString).range(of: "0")
            if zeroRange.length == 1 && zeroRange.location == 0 { //判断输入框第一个字符是否为“0”
                if !(string == "0") && !(string == ".") && textField.text?.count == 1 {//当输入框只有一个字符并且字符为“0”时，再输入不为“0”或者“.”的字符时，则将此输入替换输入框的这唯一字符。
                    textField.text = string
                    return false
                }else {
                    if pointRange.length == 0 && pointRange.location > 0 {//当输入框第一个字符为“0”时，并且没有“.”字符时，如果当此输入的字符为“0”，则视当此输入无效。
                        if string == "0" {
                            return false
                        }
                    }
                }
            }
            if !scanner.scanCharacters(from: numbers as CharacterSet, into: nil) && string.count != 0 {
                return false
            }
            
            return true

        }
        
    }

}
