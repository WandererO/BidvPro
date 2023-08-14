//
//  NormalConstant.swift
//
//
//  Created by tank on 2022/6/8.
//
import UIKit
import Foundation

typealias NormalBlock = (()->())
typealias SelectBlock = ((_ row : Int)->())
typealias SelectBlockStr = ((_ str : String) ->())
typealias cellAddressBlock = ((_ addressStr : String, _ coinId:String) ->())
typealias ButtonIsSelected = ((_ isSelecte : Bool) ->())

let webUrl : String = "http://172.16.1.250:8002"


// 屏幕宽度
let SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.size.width;
// 屏幕高度
let SCREEN_HEIGHT: CGFloat  = UIScreen.main.bounds.size.height;
 
// 状态栏高度
let STATUSBAR_HIGH : CGFloat = is_iPhoneXSeries() ? 44.0 : 20.0;
 
let topContraint = 48 + STATUSBAR_HIGH
let SafeAreaTop : CGFloat = is_iPhoneXSeries() ? 24.0 : 0.0;
let SafeAreaBottom : CGFloat = is_iPhoneXSeries() ? 34.0 : 0.0;
// 导航栏高度
let NAV_HIGH : CGFloat = 44.0;
//  TOp高度
let TOP_HEIGHT : CGFloat = (STATUSBAR_HIGH + NAV_HIGH);

let LR_Margin : CGFloat = 20
// tabbar高度
let TABBAR_HEIGHT : CGFloat = is_iPhoneXSeries() ? 83.0 : 49.0;
 
// tabbar 安全区域的高度
let TABBAR_HEIGHT_SAFE : CGFloat = is_iPhoneXSeries() ? 34.0 : 0.0;
// AppDelegate
let APPDELEGATE = UIApplication.shared.delegate;
// Window
let KWINDOW : UIWindow = (UIApplication.shared.delegate?.window ?? UIWindow()) ?? UIWindow()
// Default
let USER_DEFAULTS = UserDefaults.standard;

let Margin_WIDTH : CGFloat =  15
 
// 沙盒路径
let DOCUMENT_PATH = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true);
// 字符串是否为空
func is_URLString(ref: String) -> (Bool) {
    var result = false;
    if (!ref.isEmpty && (ref.hasPrefix("https://") || ref.hasPrefix("http://"))) {
        result = true;
    }
    return result;
}
func is_Blank(ref: String) -> (Bool) {
    let _blank = ref.allSatisfy{
        let _blank = $0.isWhitespace
        return _blank
    }
    return _blank
}
 
// 字符串中是否包含某字符串
func StringContainsSubString(string: String, subString: String) -> (Bool) {
    let range = string.range(of: subString);
    if (range == nil) {
        return false;
    }
    return true;
}
 
// 十进制颜色
func RGBCOLOR(r: CGFloat, g: CGFloat, b: CGFloat) -> (UIColor) {
    return RGBACOLOR(r: r, g: g, b: b, a: 1.0);
}
 
func RGBACOLOR(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> (UIColor) {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a);
}
// 16进制颜色转UIColor
func HEXCOLOR(c: UInt64) -> (UIColor) {
    let redValue = CGFloat((c & 0xFF0000) >> 16)/255.0
    let greenValue = CGFloat((c & 0xFF00) >> 8)/255.0
    let blueValue = CGFloat(c & 0xFF)/255.0
    return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0);
}

//创建一个错误
func error(_ message: String, code: Int = 0, domain: String = "com.example.error", function: String = #function, file: String = #file, line: Int = #line) -> NSError {

    let functionKey = "\(domain).function"
    let fileKey = "\(domain).file"
    let lineKey = "\(domain).line"

    let error = NSError(domain: domain, code: code, userInfo: [
        NSLocalizedDescriptionKey: message,
        functionKey: function,
        fileKey: file,
        lineKey: line
    ])

    // Crashlytics.sharedInstance().recordError(error)

    return error
}


//颜色
let chatBackgroundColor : UIColor = UIColor(named: "ChatBackgroundColor")!
let kMainBackgroundColor : UIColor = .hexColor("FFFFFF")
let kMainColor : UIColor = .hexColor("5171FF")
func kMainColor(alpha : CGFloat) -> UIColor {return .hexColor("5171FF", alpha: alpha)}
let kInputBGColor : UIColor = .hexColor("F5F7FF")
let kDisabledBGColor: UIColor = .hexColor("E1E1E1")
let kInputPlaceHoderColor : UIColor = .hexColor("999999")
let kdefaultPlaceHoderColor : UIColor = .hexColor("666666")
let kGreentColor : UIColor = .hexColor("2EBD85")
func kGreentColor(alpha : CGFloat) -> UIColor {return .hexColor("2EBD85", alpha: alpha)}
let kRedColor : UIColor = .hexColor("F75F52")
func kRedColor(alpha : CGFloat) -> UIColor {return .hexColor("F75F52", alpha: alpha)}
let kBlackTextColor : UIColor = .hexColor("000000")
func kBlackColor(alpha : CGFloat) -> UIColor {return .hexColor("000000", alpha: alpha)}
let kBlack3TextColor : UIColor = .hexColor("333333")
let kGreyTextColor : UIColor = .hexColor("999999")
let kLineColor : UIColor = .hexColor("F5F5F5")
let kGray6TextColor : UIColor = .hexColor("666666")

let kCardColor : UIColor = .hexColor("#FFD887")
let kAlipayColor : UIColor = .hexColor("#5171FF")
let kWechatColor : UIColor = .hexColor("#2EBD85")

let kInputTextColor : UIColor = RGBCOLOR(r: 132, g: 188, b: 57)

let HightLightColor : UIColor = RGBCOLOR(r: 84, g: 188, b: 174)


let kBtnGreyBackgrondColor : UIColor = .hexColor("#F5F5F5")




let kStatusGreenColor : UIColor = .hexColor("00BF70") // 一般用于完成
let kStatusRedColor : UIColor = .hexColor("F24957") // 一般用于取消或者拒绝
let kStatusOrangeColor : UIColor = .hexColor("FF8833") //橙色 一般用于进行中的颜色

let kArtBackgroundColor : UIColor = .hexColor("000000")
let kArtGreyColor : UIColor = .hexColor("17171A")
let kFifaMainColor : UIColor = .hexColor("FFC619")

let kCareMainColor : UIColor = .hexColor("00BF70")
let kMainBlueColor : UIColor = RGBCOLOR(r: 33, g: 111, b: 241)



func comparePriceToGetColor(oldPrice:String , newPrice : String) -> UIColor?{
    
    if let oldPirce = Double(oldPrice) , let newPrice = Double(newPrice){
        if oldPirce > newPrice {
            return kRedColor
        }else if oldPirce < newPrice{
            return kGreentColor
        }else{
            return nil
        }
    }
    return nil
}


// 字体

func FONT_L(size: CGFloat) -> (UIFont){
    return  UIFont.systemFont(ofSize: size, weight: .light)
}
func FONT_R(size: CGFloat) -> (UIFont) {
    return UIFont.systemFont(ofSize: size, weight: .regular)
}
func FONT_M(size: CGFloat) -> (UIFont) {
    return UIFont.systemFont(ofSize: size, weight: .medium)
}
func FONT_SB(size: CGFloat) -> (UIFont){
    return UIFont.systemFont(ofSize: size, weight: .semibold)
}
func FONT_B(size: CGFloat) -> (UIFont){
    return  UIFont.systemFont(ofSize: size, weight: .bold)
}
func FONT_G(size: CGFloat) -> (UIFont){
//    let font = UIFont(name: "Grantha Sangam MN", size: size)
    return UIFont(name: "Grantha Sangam MN", size: size)!
}

///细体
func FONT_MG(size: CGFloat) -> (UIFont){
    return UIFont(name: "Muli-Regular", size: size)!
}
///粗体
func FONT_MSB(size: CGFloat) -> (UIFont){
    return UIFont(name: "Muli-SemiBold", size: size)!
}


func FONT_MONO_R(size: CGFloat) -> (UIFont){
    return UIFont.monospacedDigitSystemFont(ofSize: size, weight: .regular)
}

func FONT_MONO_M(size: CGFloat) -> (UIFont){
    return UIFont.monospacedDigitSystemFont(ofSize: size, weight: .medium)
}

func FONT_MONO_SB(size: CGFloat) -> (UIFont){
    return UIFont.monospacedDigitSystemFont(ofSize: size, weight: .semibold)
}

func FONT_MONO_B(size: CGFloat) -> (UIFont){
    return UIFont.monospacedDigitSystemFont(ofSize: size, weight: .bold)
}



func PlaceholderImg() -> (UIImage){
    return UIImage(named:"icon_placeholder") ?? UIImage()
}
func PlaceholderGroupImg() -> (UIImage){
    return UIImage(named:"group_icon_default") ?? UIImage()
}

/// 获取同比例下的高度
/// - Parameters:
///   - image: <#image description#>
///   - newWidth: <#newWidth description#>
/// - Returns: <#description#>
func getImgSameScaleHeight(image: UIImage, newWidth: CGFloat) -> CGFloat {
      
    let scale = newWidth / image.size.width
    let newHeight = image.size.height * scale
 
      
    return newHeight
}

/// 获取图片总比例下的宽度
/// - Parameters:
///   - image: <#image description#>
///   - newHeight: <#newHeight description#>
/// - Returns: <#description#>
func getImgSameScaleHeight(image: UIImage, newHeight: CGFloat) -> CGFloat {
      
    let scale = newHeight / image.size.height
    let newWidth = image.size.width * scale
 
      
    return newWidth
}
// 适配 判断系统版本
func AdaptiveiOSSystem(version: Float) -> (Bool) {
    let sysVer = Float(UIDevice.current.systemVersion) ?? 0.0;
    if (sysVer >= version) {
        return true;
    }
    return false;
}
 
// 判断是否设备是iphoneX系列
func is_iPhoneXSeries() -> (Bool) {
    let boundsSize = UIScreen.main.bounds.size;
    // iPhoneX,XS
   
    if boundsSize.width >= 375 && boundsSize.height >= 812 {
        return true;
    }
    
   
    return false;
}




//MARK: - 查找顶层控制器、
/// 获取顶层控制器 根据window
func getTopVC() -> (UIViewController?) {
    var window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

   
    //是否为当前显示的window
    if window?.windowLevel != UIWindow.Level.normal{
        let windows = UIApplication.shared.windows
        for  windowTemp in windows{
            if windowTemp.windowLevel == UIWindow.Level.normal{
                window = windowTemp
                break
            }
        }
    }

    let vc = window?.rootViewController
    return getTopVC(withCurrentVC: vc)
}

///根据控制器获取 顶层控制器
func getTopVC(withCurrentVC VC :UIViewController?) -> UIViewController? {
    
    if VC == nil {
        print("🌶： 找不到顶层控制器")
        return nil
    }
    
    if let presentVC = VC?.presentedViewController {
        //modal出来的 控制器
        return getTopVC(withCurrentVC: presentVC)
    }
    else if let tabVC = VC as? UITabBarController {
        // tabBar 的跟控制器
        if let selectVC = tabVC.selectedViewController {
            return getTopVC(withCurrentVC: selectVC)
        }
        return nil
    } else if let naiVC = VC as? UINavigationController {
        // 控制器是 nav
        return getTopVC(withCurrentVC:naiVC.visibleViewController)
    }
    else {
        // 返回顶控制器
        return VC
    }
}
func getViewController(name: String,identifier: String) -> UIViewController {
    let viewController = UIStoryboard(name: name, bundle: nil)
        .instantiateViewController(withIdentifier: identifier) as UIViewController
      return viewController;
}

///判断是否是邮箱
func checkEmail(email: String) -> Bool {
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    let isValid = predicate.evaluate(with: email)
    print(isValid ? "正确的邮箱地址" : "错误的邮箱地址")
    return isValid
}

///判断密码格式
func checkPwd(pwd: String) -> Bool {
    let regex = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,}$"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    let isValid = predicate.evaluate(with: pwd)
    print(isValid ? "正确的密码格式" : "错误的密码格式")
    return isValid
}

///
func checkAddress(address: String) -> Bool {
    let regex = "0x[0-9a-zA-Z]{40}"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    let isValid = predicate.evaluate(with: address)
    print(isValid ? "正确的地址格式" : "错误的地址格式")
    return isValid
}


///判断nickname格式
func checkNickName(nickname: String) -> Bool {
    let regex = "^{1,20}$"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    let isValid = predicate.evaluate(with: nickname)
    print(isValid ? "正确的nickname格式" : "错误的nickname格式")
    return isValid
}


// 返回渲染过的svg图
func SVGImage( _ name : String) -> UIImage? {
    
    return UIImage(named: name)?.withTintColor( kGreyTextColor, renderingMode: .automatic)
}

typealias DelayTask = (_ cancel: Bool) -> ()
@discardableResult func delayAction(_ time: TimeInterval, task: @escaping () -> ()) -> DelayTask?{
    
    func dispatch_later(block: @escaping () -> ()) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    var closure: (() -> Void)? = task
    var result: DelayTask?
    
    let delayedClosure: DelayTask = {
        cancel in
        if let closure = closure {
            if !cancel {
                DispatchQueue.main.async(execute: closure)
            }
        }
        closure = nil
        result = nil
    }
    result = delayedClosure
    dispatch_later {
        if let result = result {
            result(false)
        }
    }
    return result
}

func cancelAction(_ task: DelayTask?) {
    task?(true)
}


    

