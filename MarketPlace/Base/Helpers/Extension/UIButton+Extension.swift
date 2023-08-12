//
//  UIButton+Extension.swift
//  MarketPlace
//
//  Created by tanktank on 2022/5/9.
//

import Foundation
import UIKit

enum ButtonImagePosition : Int{
 
    case PositionTop = 0
    case Positionleft
    case PositionBottom
    case PositionRight
}

// MARK: - 倒计时
extension UIButton{
    
    open override var isHighlighted: Bool {
        set{
            
        }
        get {
            return false
        }
    }

    
    
    public func countDown(count: Int, isStart:Bool){
        
        if isStart == false {
            return
        }
        
        // 倒计时开始,禁止点击事件
        isEnabled = false
        
        // 保存当前的背景颜色
        let defaultColor = self.backgroundColor
        // 设置倒计时,按钮背景颜色
//        backgroundColor = UIColor.gray
        
        var remainingCount: Int = count {
            willSet {
                let attributedString = NSMutableAttributedString.init()//初始化
                attributedString.append(NSMutableAttributedString.appendColorStrWithString(str: ("\(newValue)s"), fontSize: 14, color: .hexColor("666666")))
                attributedString.append(NSMutableAttributedString.appendColorStrWithString(str: " 后重获", fontSize: 14, color: .hexColor("666666")))
                setAttributedTitle(attributedString, for: .normal)
//                setTitle("重新发送(\(newValue))", for: .normal)
                
                if newValue <= 0 {
                    let attributedString = NSMutableAttributedString.init()//初始化
                    attributedString.append(NSMutableAttributedString.appendColorStrWithString(str: ("获取验证码"), fontSize: 14, color: .hexColor("5171FF")))
                    setAttributedTitle(attributedString, for: .normal)
//                    setTitle("发送验证码", for: .normal)
                }
            }
        }
        
        // 在global线程里创建一个时间源
        let codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        // 设定这个时间源是每秒循环一次，立即开始
        codeTimer.schedule(deadline: .now(), repeating: .seconds(1))
        // 设定时间源的触发事件
        codeTimer.setEventHandler(handler: {

            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {

                // 每秒计时一次
                remainingCount -= 1
                // 时间到了取消时间源
                if remainingCount <= 0 {
                    self.backgroundColor = defaultColor
                    self.isEnabled = true
                    codeTimer.cancel()
                }
            }
        })
        // 启动时间源
        codeTimer.resume()
    }
    
    
    func setImageAndTitle(NormalImageName:String, SelectImageName: String,title:String,type:ButtonImagePosition,Space space:CGFloat)  {
          
            self.setTitle(title, for: .normal)
            self.setImage(UIImage(named:NormalImageName), for: .normal)
        self.setImage(UIImage(named: SelectImageName), for: .selected)

        let imageWith :CGFloat = (self.imageView?.frame.size.width)!;
        let imageHeight :CGFloat = (self.imageView?.frame.size.height)!;
          
            var labelWidth :CGFloat = 0.0;
            var labelHeight :CGFloat = 0.0;

            labelWidth = CGFloat(self.titleLabel!.intrinsicContentSize.width);
            labelHeight = CGFloat(self.titleLabel!.intrinsicContentSize.height);

            var  imageEdgeInsets :UIEdgeInsets = UIEdgeInsets();
            var  labelEdgeInsets :UIEdgeInsets = UIEdgeInsets();
           
            switch type {
            case .PositionTop:

                imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space/2.0, left: 0, bottom: 0, right: -labelWidth);
                labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWith + 5, bottom: -imageHeight-space/2.0, right: 0);

                break;
            case .Positionleft:
                imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0);
                labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0);
                break;
            case .PositionBottom:
                imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight-space/2.0, right: -labelWidth);
                labelEdgeInsets = UIEdgeInsets(top: -imageHeight-space/2.0, left: -imageWith, bottom: 0, right: 0);
                break;
            case .PositionRight:
                
                imageEdgeInsets = UIEdgeInsets(top:0, left:labelWidth+space/2.0, bottom:0, right:-labelWidth-space/2.0);
                labelEdgeInsets = UIEdgeInsets(top:0, left:-imageWith-space/2.0, bottom:0, right:imageWith+space/2.0);
                break;
            }
            
            // 4. 赋值
            self.titleEdgeInsets = labelEdgeInsets;
            self.imageEdgeInsets = imageEdgeInsets;
        }
    
}
///扩大button点击范围
class ZQButton:UIButton{
    

    /// USE IN CONTRACT ONLY
    convenience init(selectBackgroundImage :UIImage? , title : String){
        self.init()
        self.setBackgroundImage(selectBackgroundImage?.withTintColor(kBtnGreyBackgrondColor), for: .normal)
        self.setBackgroundImage(selectBackgroundImage, for: .selected)
        self.setBackgroundImage(selectBackgroundImage?.image(alpha: 0.3), for: .highlighted)
        self.setBackgroundImage(selectBackgroundImage?.image(alpha: 0.1), for: .disabled)
        self.setBackgroundImage(selectBackgroundImage?.image(alpha: 0.5), for: [.highlighted , .selected])

        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .selected)
        self.setTitleColor(kBlack3TextColor, for: .normal)
        self.titleLabel?.font = FONT_SB(size: 15)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let zqmargin:CGFloat = -10
        let clickArea = bounds.insetBy(dx: zqmargin, dy: zqmargin)
        return clickArea.contains(point)
    }
}

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
