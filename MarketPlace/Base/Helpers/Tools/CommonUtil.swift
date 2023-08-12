//
//  CommonUtil.swift
//  GoPay
//
//  Created by GoPay on 2020/12/11.
//

import Foundation
import UIKit
import CoreImage
import WebKit
typealias BlockWithNone = () -> ()
typealias BlockWithParameters<T> = (T) -> ()
public let AppWindow = UIApplication.shared.windows.first!
 
/// 字符串是否为空
public func stringIsEmpty(str: String?) -> Bool {
    return str?.isEmpty ?? true
}

// 自定义Log
public func PLog<T>(_ message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
#if DEBUG
    let fileName = (file as NSString).lastPathComponent;
    print("🔨 [文件名：\(fileName)], [方法：\(funcName)], [行数：\(lineNum)]\n🔨 \(message)");
#endif
}

class CommonUtil {
    
  
    
    /// 弹出更新弹窗
    static public func presentVersionUpdate(hideAnimateEndBlock: BlockWithNone? = nil) -> Bool {
 
        return true
    }
    
    /// 创建Storyboard视图控制器
    static public func createVC(name: String, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    /// 手机号
    static public func validate(mobile: String) -> Bool {
        // 第一位为1第二位为3、4、5、7、8
        let regex = "^1[3-9]\\d{9}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: mobile)
    }
    
    /// 验证码
    static public func validateVerityCode(code: String) -> Bool {
        //
        let regex = "[0-9]{1,6}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: code)
    }
    
    /// 验证密码
    static public func validate(pwd: String) -> Bool {
        let passWordRegex = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$"
        let passWordPredicate = NSPredicate(format: "SELF MATCHES %@", passWordRegex)
        return passWordPredicate.evaluate(with: pwd)
    }
    
    /// 验证邮箱
    static public func validate(email: String) -> Bool {
        
        let emailRegex: String = "[A-Z0-9a-z._%+-]{3,64}@[A-Za-z0-9.-]{1,255}\\.[A-Za-z]{2,6}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    /// 验证字母是否
    static public func validate(zm: String) -> Bool {
        let emailRegex: String = "[a-zA-Z]"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: zm)
    }
    
    /// 验证汉字
    static public func validate(hz: String) -> Bool {
        let emailRegex: String = "[\\u4e00-\\u9fa5]"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: hz)
    }
    
    /// 验证昵称
    static public func validate(nickName: String) -> Bool {
        let regex = "^[\\u4e00-\\u9fa5a-zA-Z0-9_-]{2,8}$" // 中文 a-z  A-Z 0-9 _ -
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: nickName)
    }
    
    /// 验证Region
    static public func validate(region: String) -> Bool {
        let regex = "^[\\u4e00-\\u9fa5a-zA-Z]{0,12}$" // 中文 a-z  A-Z
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: region)
    }
    
    /// 防止xss攻击
    static public func preventionXSS(str: String) -> String {
        var temp = str.replacingOccurrences(of: "<", with: "%26lt%3B")
        temp = temp.replacingOccurrences(of: ">", with: "%26gt%3B")
        temp = temp.replacingOccurrences(of: "&", with: "%26")
        return temp
    }

    /// 将UIView转成UIImage
    static public func createImage(view: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        return renderer.image { rendererContext in
            view.layer.render(in: rendererContext.cgContext)
        }
    }
    
    /// 识别图片二维码
    static public func detectorQrCode(image: UIImage) -> String? {
        
        guard let ciImage = CIImage(image: image) else {
            return nil
        }
        
        guard let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow]) else {
            return nil
        }
        
        let results = detector.features(in: ciImage)
        
        guard let code = results.first as? CIQRCodeFeature else { return nil }
        
        return code.messageString
    }
    
    /// 生成二维码图片
    static public func createQrImage(str: String, size: CGSize) -> UIImage? {
        
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        
        filter.setDefaults()
        let contentData = str.data(using: String.Encoding.utf8)
        filter.setValue(contentData, forKey: "inputMessage")
        
        // 从滤镜中取出生成的图片
        guard let ciImage = filter.outputImage else { return nil }

        let context = CIContext(options: nil)
        let bitmapImage = context.createCGImage(ciImage, from: ciImage.extent)

        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue)

        // draw image
        let scale = min(size.width / ciImage.extent.width, size.height / ciImage.extent.height)
        bitmapContext!.interpolationQuality = CGInterpolationQuality.none
        bitmapContext?.scaleBy(x: scale, y: scale)
        bitmapContext?.draw(bitmapImage!, in: ciImage.extent)

        // 保存bitmap到图片
        guard let scaledImage = bitmapContext?.makeImage() else { return nil }

        return UIImage(cgImage: scaledImage)
    }
    
    /// 是否需要更新
    static public func isNeedUpdate(localVersion: String, newVersion: String) -> Bool {
        
        guard !stringIsEmpty(str: localVersion) else {
            return false
        }
        
        guard !stringIsEmpty(str: newVersion) else {
            return false
        }
        
        let localArray = localVersion.components(separatedBy: ".")
        let newArray = newVersion.components(separatedBy: ".")
        // 取字段最大的，进行循环比较
        let bigCount = (localArray.count > newArray.count) ? localArray.count : newArray.count;

        for i in (0..<bigCount) {
            // 字段有值，取值；字段无值，置0。
            let localValue = (localArray.count > i) ? NSInteger(localArray[i]) : 0;
            let newValue = (newArray.count > i) ? NSInteger(newArray[i]) : 0;
            // 本地版本字段"小于"最新版本字段，返回"需要"更新
            if (localValue ?? 0 < newValue ?? 0) {
                return true
            }
            // 本地版本字段"大于"最新版本字段，返回"不需要"更新
            else if (localValue ?? 0 > newValue ?? 0) {
                return false
            }
        }
        
        // 版本"相同",返回"不需要"更新
        return false
    }
    
    /// 获取当前VC
    static public func getCurrentVC(base: UIViewController? = AppWindow.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getCurrentVC(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            return getCurrentVC(base: tab.selectedViewController)
        }
        
        if let presented = base?.presentedViewController {
            return getCurrentVC(base: presented)
        }
        
        if let split = base as? UISplitViewController {
            return getCurrentVC(base: split.presentingViewController)
        }
        
        return base
    }
    
    /// json解析
    static public func jsonObject(json: String) -> Any? {
        guard let data = json.data(using: .utf8) else { return nil }
        let object = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        return object
    }
    
    /// json解析
    static public func jsonData(data: Data) -> Any? {
        let object = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        return object
    }
    
    /// 解析json字符串
    static public func jsonStr(obj: Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: obj, options: []) else {
            return nil
        }
        let jsonStr = String(data: data, encoding: .utf8)
        return jsonStr
    }
    
    /// 唯一id
    static public func uuidStr() -> String {
        return UUID().uuidString + "\(Int(Date().timeIntervalSince1970))"
    }
    
    /// 解析图片URL字符串的宽高
    static public func pasringOSSImageSize(_ urlStr: String) -> CGSize {
        
        let lastArr = urlStr.components(separatedBy: "?")
        guard let lastStr = lastArr.last else {
            return CGSize.zero
        }
        
        let sizeArr = lastStr.components(separatedBy: "&")
        guard sizeArr.count == 2 else {
            return CGSize.zero
        }
        
        var width: CGFloat = 0
        var height: CGFloat = 0
        for sizeStr in sizeArr {
            let arr = sizeStr.components(separatedBy: "=")
            guard arr.count == 2 else {
                return CGSize.zero
            }
            if arr.first! == "width" {
                width = CGFloat(Double(arr.last!) ?? 0)
            } else if arr.first! == "height" {
                height = CGFloat(Double(arr.last!) ?? 0)
            }
        }
        
        return CGSize(width: width, height: height)
    }
    
    /// 解析URL参数
    static func parsingUrlParams(paramsStr: String) -> [String: String] {
        var paramsDic = [String: String]()
        let paramsArr = paramsStr.components(separatedBy: "&")
        for paramStr in paramsArr {
            let paramArr = paramStr.components(separatedBy: "=")
            if paramArr.count > 1 {
                paramsDic.updateValue(paramArr.last!, forKey: paramArr.first!)
            }
        }
        return paramsDic
    }
    
   
    /// 获取评论数量显示格式
    static func getCommentCount(count: Int) -> String {
        if Double(count) > 0 {
            if Double(count) >= 10000 {
                let count = String(format: "%.1f", Double(count) / 10000.0)
                if (Double(count) ?? 0) >= 1000 {
                    let k_count = String(format: "%.1f", (Double(count) ?? 0) / 10000.0)
                    return "\(k_count)kw"
                }
                return "\(count)w"
            } else if Double(count) >= 1000 {
                let count = String(format: "%.1f", Double(count) / 1000.0)
                return "\(count)k"
            } else {
                return "\(count)"
            }
        }
        return "0"
    }
    
    static func commentCount(count: String?) -> String {
        
        guard let count = count else { return "0" }
        
        let count_d = Double(count) ?? 0
        
        var countStr: String = "0"
        
        if count_d < 10000 {
            countStr = count
        } else if count_d >= 10000 && count_d < 1000000 {
            countStr = String(format: "%.1fK", (count_d / 1000.0))
        } else if count_d >= 1000000 && count_d < 1000000000 {
            countStr = String(format: "%.1fM", (count_d / 1000000.0))
        } else if count_d >= 1000000000 {
            countStr = String(format: "%.1fB", (count_d / 1000000000.0))
        } else {
            countStr = "0"
        }
        
        return countStr
    }
    
    static func getUnreadCount(count: Int) -> String {
        if Double(count) > 0 {
            if Double(count) >= 10000 {
                let count = String(format: "%.1f", Double(count) / 10000.0)
                return "\(count)w"
            } else if Double(count) >= 1000 {
                let count = String(format: "%.1f", Double(count) / 1000.0)
                return "\(count)k"
            } else {
                return "\(count)"
            }
        }
        return ""
    }
     
    
    /// 跳转到外部web
    static func pushToSafari(urlStr: String, params: [String: Any] = [:]) {
        
        let paramters = params
        
        let urlTemp = urlStr + "?" + CommonUtil.splicingUrlStr(params: paramters)
        if let url = URL(string: urlTemp) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /// 拼接URL参数
    static func splicingUrlStr(params: [String: Any]) -> String {
        var urlStr = ""
        for (key, value) in params {
            let spacter = stringIsEmpty(str: urlStr) ? "" : "&"
            urlStr += spacter + "\(key)=\(value)"
        }
        return urlStr
    }
    
    /// 补充到倍数
    static func supplementWith(num: Int, multiple: Int) -> Int {
        let remainder = num % multiple
        if remainder == 0 {
            return num
        }
        return num + (multiple - remainder)
    }
    
   
    static func clearWebCache() {
        // MARK: - 清空缓存
        let dateFrom: NSDate = NSDate.init(timeIntervalSince1970: 0)
        if #available(iOS 9.0, *) {
            let websiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
            WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes , modifiedSince: dateFrom as Date) {
                print("清空缓存完成")
            }
        } else {
            let libraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let cookiesFolderPath = libraryPath.appending("/Cookies")
            try? FileManager.default.removeItem(atPath: cookiesFolderPath)
        }
    }
    
    static func copyContent(content:String){
         
        UIPasteboard.general.string =  content
//        WidgetUtil.share.showTip(str: "复制成功")
        
    }
  
    
    //返回base64图片
    static func getBase64Image(_ str:String) -> UIImage{
        
        guard  let decodedImgData = NSData(base64Encoded: str ,options: .ignoreUnknownCharacters) ,
              let codeImage = UIImage(data: decodedImgData as Data) else {
            
            return UIImage()
            
        }
        
        return codeImage
    }
     

}



extension String{
    
    
    func priceString() -> String{
        
        return self.replacingOccurrences(of: ".", with: ",")
        
    }
    
    
}
