//
//  BaseTextField.swift
//  MarketPlace
//
//  Created by mac on 2023/3/30.
//

import UIKit

@IBDesignable
class BaseTextField: UITextField {

    var digit :Int = 0//小数位
    var isNumber :Bool = false {
        didSet{
            self.keyboardType = .decimalPad
        }
    } //只能输入数字
    var maxCount :Int = 0 //只能输入数字
    var maxValue :Double? //最大的数字

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        self.delegate = self
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
}

extension BaseTextField: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == ""{
            return true
        }

        if maxCount != 0 ,textField.text?.count ?? 0 > maxCount,string != ""{
            
            return false
        }
        
        if !self.isNumber {
            return true
        }else{
           
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
    }
}


