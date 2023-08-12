//
//  UIlabel+Extension.swift
//  tanktank
//
//  Created by xxx on 2022/9/4.
//

import Foundation
import UIKit

public enum Iconfont: String {
    
    case info = "\u{e740}"
    case security = "\u{e723}"
    case help = "\u{e774}"
    case email = "\u{e724}"
    case lock = "\u{e6fe}"
    
    case downArrow = "\u{e77a}"
    case exchange = "\u{e78a}"
    case collectionView = "\u{e70b}"
    case gridView = "\u{e785}"
    case rightArrow = "\u{e787}"
    case blodRightArrow = "\u{e6fa}"
    case leftArrow = "\u{e77c}"
    case blodLeftArrow = "\u{e6f7}"
    case blodUpArrow = "\u{e748}"
    case blodDownArrow = "\u{e73c}"
    case bdownArrow = "\u{e6fd}"
    
    case number = "\u{e70e}"
    case more = "\u{e784}"

    case wallet = "\u{e713}"
    case disconect = "\u{e714}"
    case link = "\u{e70c}"
    case link1 = "\u{e780}"
    case warning = "\u{e775}"
    case deleteAccount = "\u{e70a}"
    case rent = "\u{e78c}"
    case close = "\u{e715}"
    case bsc = "\u{e74d}"
    case eth = "\u{e74b}"
    case polygon = "\u{e71e}"
    case tag = "\u{e73d}"
    case cart = "\u{e77b}" 
    case moon = "\u{e738}"
    case heart = "\u{e6f2}"
    case maximize = "\u{e790}"
    case done = "\u{e765}"
    
    
    case website = "\u{e736}"
    case instagram = "\u{e70f}"
    case tiktok = "\u{e707}"
    case youtube = "\u{e706}"
    case linkedin = "\u{e705}"
    case facebook = "\u{e704}"
    case discord = "\u{e703}"
    case medium = "\u{e701}"
    case twitter = "\u{e6f5}"
    case telegram = "\u{e771}"
    case toAdress = "\u{e6f8}"
    
    case ranking = "\u{e799}"

    case bid = "\u{e758}"
    case verify = "\u{e749}"

}

extension UILabel{
    
    func setIconFont(iconfont:Iconfont , size : CGFloat , color : UIColor? = nil) {
        let font = UIFont.init(name: "iconfont", size: size)
        self.font  = font
        self.textAlignment = .center
        self.text = iconfont.rawValue
        
        if let color = color {
            self.textColor = color
        }
    }
    
    func setIconFont(iconfont:Iconfont ,andText text : String = "" , size : CGFloat , color : UIColor? = nil) {
        let font = UIFont.init(name: "iconfont", size: size)
        self.font  = font
        self.textAlignment = .center
        self.text = iconfont.rawValue + " " + text
        
        if let color = color {
            self.textColor = color
        }
    }

    func setIconFont(Text text : String = "" , iconfont:Iconfont  , size : CGFloat , color : UIColor = kBlackTextColor , textFont : UIFont = FONT_SB(size: 16)) {
                
        
        let titleStr : NSMutableAttributedString = NSMutableAttributedString.init()
        titleStr.append(NSMutableAttributedString.appendColorStrWithString(str: text, font: textFont, color: color))
        
        let font = UIFont.init(name: "iconfont", size: size)

        titleStr.append(NSMutableAttributedString.appendColorStrWithString(str: iconfont.rawValue , font: font ?? textFont , color: color))
        self.attributedText = titleStr
    }

    func setIconFont(leftText : String = "" , rightText : String = "" , iconfont:Iconfont  , iconFontSize : CGFloat , iconFontColor : UIColor = kBlackTextColor , textFont : UIFont = FONT_SB(size: 16),textColor : UIColor = kBlackTextColor) {
                
        let titleStr : NSMutableAttributedString = NSMutableAttributedString.init()
        titleStr.append(NSMutableAttributedString.appendColorStrWithString(str: leftText, font: textFont, color: textColor))
        let font = UIFont.init(name: "iconfont", size: iconFontSize)
        titleStr.append(NSMutableAttributedString.appendColorStrWithString(str: iconfont.rawValue , font: font ?? textFont , color: iconFontColor))
        titleStr.append(NSMutableAttributedString.appendColorStrWithString(str: rightText, font: textFont, color: textColor))
        self.attributedText = titleStr

    }
    
    func setStyleLineSpacing(Text text : String, Spacing s : CGFloat, alignment:NSTextAlignment) {
        /// 设置间距
        let style = NSMutableParagraphStyle()
        /// 间隙
        style.lineSpacing = s
        style.alignment = alignment
        self.numberOfLines = 0
        self.attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: style])
    }
    
    
}

class InsetLabel: UILabel {
    // 1.定义一个接受间距的属性
    var textInsets = UIEdgeInsets.zero
    
    //2. 返回 label 重新计算过 text 的 rectangle
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        guard text != nil else {
            return super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        }
        
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    //3. 绘制文本时，对当前 rectangle 添加间距
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}
