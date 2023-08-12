//
//  NSObject+Ext.swift
//  MarketPlace
//
//  Created by tanktank on 2022/5/7.
//

import Foundation
import AVFoundation
import Photos

extension NSObject{
    ///将百分数字符串转Double
    func getDoubleWithString(str : String) -> Double{
        let tmp = str.replacingOccurrences(of: "%", with: "")
        
        let double = (tmp as NSString).doubleValue / 100.0
        
        return double
    }
    
    func validatedPhone(phoneStr: String) -> Bool {
        let phone = phoneStr.trimmingCharacters(in: CharacterSet.whitespaces)
        let regex = "^((13[0-9])|(14[5,7])|(15[^4,\\D])|(17[0,0-9])|(18[0,0-9])|(19[0,0-9]))\\d{8}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = predicate.evaluate(with: phone)
        return result
    }
    
    func validateEmail(email: String) -> Bool {
        if email.count == 0 {
            return false
        }
        let regex = "^([a-zA-Z0-9]+([._\\-])*[a-zA-Z0-9]*)+@([a-zA-Z0-9])+(.([a-zA-Z])+)+$"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return emailTest.evaluate(with: email)
    }
    
    func validatePsswd(psswd:String) -> Bool {
        if psswd.count == 0{
            return false
        }
        let regex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[~!@#$%^&*_\\-+=`|\\\\(){}\\[\\]:;\"'<>?,.\\/])[^\\s\\n]{8,15}$"
        let psswdTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return psswdTest.evaluate(with: psswd)
    }
    //(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)
    func validateIDNumber(num:String) -> Bool {
        if num.count == 0{
            return false
        }
        let regex = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)"
        let psswdTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return psswdTest.evaluate(with: num)
    }
    
    func validateAPIPsswd(psswd:String) -> Bool {
        if psswd.count == 0{
            return false
        }
        let regex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[~!@#$%^&*_\\-+=`|\\\\(){}\\[\\]:;\"'<>?,.\\/])[^\\s\\n]{8,32}$"
        let psswdTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return psswdTest.evaluate(with: psswd)
    }
    
    func validateIPV4(num:String) -> Bool {
        if num.count == 0{
            return false
        }
        let regex = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
        let psswdTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return psswdTest.evaluate(with: num)
    }
    
    func validateFishCode(code:String) -> Bool {
        if code.count == 0{
            return false
        }
        let regex = "^[a-zA-Z0-9]{8,32}$"
        let psswdTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return psswdTest.evaluate(with: code)
    }
    
    
    //创建二维码图片
        func createQRForString(qrString: String?, qrImageName: String?) -> UIImage?{
            if let sureQRString = qrString {
                let stringData = sureQRString.data(using: .utf8,
                                                   allowLossyConversion: false)
                // 创建一个二维码的滤镜
                let qrFilter = CIFilter(name: "CIQRCodeGenerator")!
                qrFilter.setValue(stringData, forKey: "inputMessage")
                qrFilter.setValue("H", forKey: "inputCorrectionLevel")
                let qrCIImage = qrFilter.outputImage
                 
                // 创建一个颜色滤镜,黑白色
                let colorFilter = CIFilter(name: "CIFalseColor")!
                colorFilter.setDefaults()
                colorFilter.setValue(qrCIImage, forKey: "inputImage")
                colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
                colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
                 
                // 返回二维码image
                let codeImage = UIImage(ciImage: colorFilter.outputImage!
                    .transformed(by: CGAffineTransform(scaleX: 5, y: 5)))
                
                // 中间logo
                if let iconImage = UIImage(named: qrImageName!) {
                    let rect = CGRect(x:0, y:0, width:codeImage.size.width,
                                      height:codeImage.size.height)
                    UIGraphicsBeginImageContext(rect.size)
                     
                    codeImage.draw(in: rect)
                    let avatarSize = CGSize(width:rect.size.width * 0.25,
                                            height:rect.size.height * 0.25)
                    let x = (rect.width - avatarSize.width) * 0.5
                    let y = (rect.height - avatarSize.height) * 0.5
                    iconImage.draw(in: CGRect(x:x, y:y, width:avatarSize.width,
                                              height:avatarSize.height))
                    let resultImage = UIGraphicsGetImageFromCurrentImageContext()
                     
                    UIGraphicsEndImageContext()
                    return resultImage
                }
                return codeImage
            }
            return nil
        }
    
    
    func createUIImageFromCIImage(image: CIImage, size: CGFloat) -> UIImage {
        let extent = image.extent.integral
        let scale = min(size / extent.width, size / extent.height)
            
        /// Create bitmap
        let width: size_t = size_t(extent.width * scale)
        let height: size_t = size_t(extent.height * scale)
        let cs: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmap: CGContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: 1)!
            
        let context = CIContext.init()
        let bitmapImage = context.createCGImage(image, from: extent)
        bitmap.interpolationQuality = .none
        bitmap.scaleBy(x: scale, y: scale)
        bitmap.draw(bitmapImage!, in: extent)
            
        let scaledImage = bitmap.makeImage()
        return UIImage.init(cgImage: scaledImage!)
    }
    
    
    //获取拼音首字母（大写字母）
    func findFirstLetterFromString(aString: String) -> String {
        //转变成可变字符串
        let mutableString = NSMutableString.init(string: aString)

        //将中文转换成带声调的拼音
        CFStringTransform(mutableString as CFMutableString, nil,      kCFStringTransformToLatin, false)

        //去掉声调
        let pinyinString = mutableString.folding(options:          String.CompareOptions.diacriticInsensitive, locale:   NSLocale.current)

        //将拼音首字母换成大写
        let strPinYin = polyphoneStringHandle(nameString: aString,    pinyinString: pinyinString).uppercased()

        //截取大写首字母
        let firstString = strPinYin.substring(to:     strPinYin.index(strPinYin.startIndex, offsetBy: 1))

        //判断首字母是否为大写
        let regexA = "^[A-Z]$"
        let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        return predA.evaluate(with: firstString) ? firstString : "#"
    }

    //多音字处理，根据需要添自行加
    func polyphoneStringHandle(nameString: String, pinyinString: String) -> String {
        if nameString.hasPrefix("长") {return "chang"}
        if nameString.hasPrefix("沈") {return "shen"}
        if nameString.hasPrefix("厦") {return "xia"}
        if nameString.hasPrefix("地") {return "di"}
        if nameString.hasPrefix("重") {return "chong"}
        return pinyinString
    }
    
    //截取视频封面
    func getVideoImage(VideoUrl: URL) -> UIImage {
        //生成视频截图
       let avAsset =  AVAsset ( url : VideoUrl)
        let  generator =  AVAssetImageGenerator (asset: avAsset)
        generator.appliesPreferredTrackTransform =  true
       let  time =  CMTimeMakeWithSeconds (0.0,preferredTimescale: 600)
       var  actualTime: CMTime  =  CMTimeMake (value: 0,timescale: 0)
       let  imageRef: CGImage  = try! generator.copyCGImage(at: time, actualTime: &actualTime)
       let  frameImg =  UIImage ( cgImage : imageRef)
        
        return frameImg
    }
    
    ///保存图片
    func saveImagePhoto(image: UIImage) {
            
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }, completionHandler: { [weak self](isSuccess, error) in
            guard let self = self else{return}
            
            DispatchQueue.main.async {
                
                if isSuccess {// 成功
                    
                    HudManager.showOnlyText("保存成功")
                }else {
                    HudManager.showOnlyText("保存失败")
                }
            }
        })
    }
    
    
    
    /// 获取系统当前语言
    func getCurrentLanguage() -> String {
        // 返回设备曾使用过的语言列表
        let languages: [String] = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        // 当前使用的语言排在第一
        let currentLanguage = languages.first
        return currentLanguage ?? "en-CN"
    }
    
}
extension String{
    //时间戳转成字符串
    static func timeIntervalChangeToTimeStr(timeInterval:Double, _ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> String {
        let date:Date = Date.init(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter.init()
        if dateFormat == nil {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            formatter.dateFormat = dateFormat
        }
        return formatter.string(from: date as Date)
    }
    //MARK:- 字符串转时间戳
    func timeStrChangeTotimeInterval(_ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> String {
        if self.isEmpty {
            return ""
        }
        let format = DateFormatter.init()
        format.dateStyle = .medium
        format.timeStyle = .short
        if dateFormat == nil {
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            format.dateFormat = dateFormat
        }
        let date = format.date(from: self)
        return date?.milliStamp ?? ""
    }
    
    
}
//MARK:千位分割
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}

extension Bundle {
    
    ///获取版本号
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersionNumber: String? {
            return infoDictionary?["CFBundleVersion"] as? String
        }
    
    var releaseVersionNumberPretty: String {
        return "\(releaseVersionNumber ?? "1.0.0")"
    }
}
