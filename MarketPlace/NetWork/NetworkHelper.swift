//
//  NetworkHelper.swift
//
//
//  Created by  tkkkk on 2021/12/3.
//

import Foundation
import Moya
import Alamofire
import UIKit

///超时时长
private var requestTimeOut: Double = 60
///成功数据回调
typealias successCallback = ((_ responseInfo : Any) -> Void)
/// 失败的回调
typealias failedCallback = ((String) -> Void)
typealias failedWithCodeCallback = ((String,Int) -> Void)
/// 网络错误的回调
typealias errorCallback = (() -> Void)
/// 网络请求的基本设置,这里可以拿到是具体的哪个网络请求，可以在这里做一些设置
private let myEndpointClosure = { (target: TargetType) -> Endpoint in
    /// 这里把endpoint重新构造一遍主要为了解决网络请求地址里面含有? 时无法解析的bug https://github.com/Moya/Moya/issues/1198
    let url = target.baseURL.absoluteString + target.path
    var task = target.task

    /*
     如果需要在每个请求中都添加类似token参数的参数请取消注释下面代码
     👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
     */
//    let additionalParameters = ["token":"888888"]
//    let defaultEncoding = URLEncoding.default
//    switch target.task {
//        ///在你需要添加的请求方式中做修改就行，不用的case 可以删掉。。
//    case .requestPlain:
//        task = .requestParameters(parameters: additionalParameters, encoding: defaultEncoding)
//    case .requestParameters(var parameters, let encoding):
//        additionalParameters.forEach { parameters[$0.key] = $0.value }
//        task = .requestParameters(parameters: parameters, encoding: encoding)
//    default:
//        break
//    }
    /*
     👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆
     如果需要在每个请求中都添加类似token参数的参数请取消注释上面代码
     */
//    return .requestData(jsonToData(jsonDic: ["username":username])!)
    
    
    var header = ["Content-Type":"application/json"]
    
    if target.path == "/user/file/upload-file" {

        

        header["Content-Type"] = "multipart/form-data"
        var endpoint = Endpoint(
            url: url,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: task,
            httpHeaderFields: target.headers
        )

        return endpoint.adding(newHTTPHeaderFields: header)
    }
    
    if target.method == .post{

        var dict:[String:Any] = [:]
        switch task {
        case let .requestParameters(parameters,_):
            dict = parameters
            break
        default:
            break
        }
        
//        task = Task.uploadMultipart(<#T##[MultipartFormData]#>)
        task = Task.requestData(jsonToData(jsonDic: dict)!)
//        setHeaderWithDictionary(dict: (dict as? [String : String]))
        
        let infoDictionary : [String : Any] = Bundle.main.infoDictionary!
        let appVersion = infoDictionary["CFBundleShortVersionString"] as! String // 主程序版本号
        
        //设备信息
        let iosVersion = UIDevice.current.systemVersion //ios版本
        let systemName = UIDevice.current.systemName //设备名称
        let deviceModel = UIDevice.current.model //设备型号
        let localizedModel = UIDevice.current.localizedModel
        let name = UIDevice.current.name
//        print("版本：\(iosVersion) \n 设备名称：\(systemName) \n 型号：\(deviceModel) \(localizedModel) \n 名称：\(name)")
        
        //Safari for iOS 14.4 on iPhone: Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Mobile/15E148 Safari/604.1
        
//        let deviceInfo:String = "Safari for iOS \(iosVersion) on iPhone: Mozilla/5.0 (iPhone; CPU iPhone OS \(iosVersion) like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/\(iosVersion) Mobile/15E148 Safari/604.1"//name + deviceModel + systemName + iosVersion
//
//        header["deviceToken"] = "uuid"
//        header["channel"] = "1"
//        header["language"] = "zh_cn"
//        header["version"] = appVersion
//        header["user-agent"] = deviceInfo
//        header["deviceModel"] = deviceModel
        
        let token = Archive.getToken()
        header["Token"] = token

    }
    

    func setHeaderWithDictionary(dict:[String:String]?){

        var paramtterStr = ""
        let finalStr = getExtralHeader()
        if let dict {
            header["signature"] = "\(dict.toJsonString())&\(finalStr)".md5()
        }else{
            header["signature"] = "\(finalStr)".md5()
        }
    }
//    token、time、key放在最后面拼接
    func getExtralHeader() ->String{
        let now = NSDate.now.milliStamp
        let key = "EX-key"
        let token = Archive.getToken() 
        let finalStr = "time=\(now)&key=\(key)"
        
        if token.count > 0 {
            header["token"] = token
//            header["key"] = key
//            header["time"] = now
            return "token=\(token)"
        }else{
            header["key"] = key
            header["time"] = now
            return finalStr
        }
    }

    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: task,
        httpHeaderFields: target.headers
    )
    
//    requestTimeOut = 30 // 每次请求都会调用endpointClosure 到这里设置超时时长 也可单独每个接口设置

    return endpoint.adding(newHTTPHeaderFields: header)
}
/// 网络请求的设置
private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        // 设置请求时长
        request.timeoutInterval = requestTimeOut
        // 打印请求参数
        if let requestData = request.httpBody {
            print("\(request.url!)" + "\n" + "\(request.httpMethod ?? "")" + "发送参数" + "\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        } else {
            print("\(request.url!)" + "\(String(describing: request.httpMethod))")
        }
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}
/*   设置ssl
 let policies: [String: ServerTrustPolicy] = [
 "example.com": .pinPublicKeys(
     publicKeys: ServerTrustPolicy.publicKeysInBundle(),
     validateCertificateChain: true,
     validateHost: true
 )
 ]
 */

// 用Moya默认的Manager还是Alamofire的Manager看实际需求。HTTPS就要手动实现Manager了
// private public func defaultAlamofireManager() -> Manager {
//
//    let configuration = URLSessionConfiguration.default
//
//    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//
//    let policies: [String: ServerTrustPolicy] = [
//        "ap.grtstar.cn": .disableEvaluation
//    ]
//    let manager = Alamofire.SessionManager(configuration: configuration,serverTrustPolicyManager: ServerTrustPolicyManager(policies: policies))
//
//    manager.startRequestsImmediately = false
//
//    return manager
// }
// NetworkActivityPlugin插件用来监听网络请求，界面上做相应的展示
/// 但这里我没怎么用这个。。。 loading的逻辑直接放在网络处理里面了
private let networkPlugin = NetworkActivityPlugin.init { changeType, _ in
    print("networkPlugin \(changeType)")
    // targetType 是当前请求的基本信息
    switch changeType {
    case .began:
        print("开始请求网络")

    case .ended:
        print("结束")
    }
}
// https://github.com/Moya/Moya/blob/master/docs/Providers.md  参数使用说明
// stubClosure   用来延时发送网络请求
/// /网络请求发送的核心初始化方法，创建网络请求对象
let Provider = MoyaProvider<MultiTarget>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [networkPlugin], trackInflights: false)

let Provider2 = MoyaProvider<MultiTarget>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [networkPlugin], trackInflights: false)
/// 最常用的网络请求，只需知道正确的结果无需其他操作时候用这个 (可以给调用的NetWorkReques方法的写参数默认值达到一样的效果,这里为解释方便做抽出来二次封装)
///
/// - Parameters:
///   - target: 网络请求
///   - completion: 请求成功的回调
func NetWorkRequest(_ target: TargetType, completion: @escaping successCallback) {
    NetWorkRequest(target, completion: completion, failed: nil, failedWithCode:nil, errorResult: nil)
}

/// 需要知道成功或者失败的网络请求， 要知道code码为其他情况时候用这个 (可以给调用的NetWorkRequest方法的参数默认值达到一样的效果,这里为解释方便做抽出来二次封装)
///
/// - Parameters:
///   - target: 网络请求
///   - completion: 成功的回调
///   - failedWithCode: 请求失败的回调 带有状态码
func NetWorkRequest(_ target: TargetType, completion: @escaping successCallback, failedWithCode: failedWithCodeCallback?) {
    NetWorkRequest(target, completion: completion, failed: nil, failedWithCode:failedWithCode, errorResult: nil)
}
///  需要知道成功、失败、错误情况回调的网络请求   像结束下拉刷新各种情况都要判断
///
/// - Parameters:
///   - target: 网络请求
///   - completion: 成功
///   - failed: 失败
///   - error: 错误
@discardableResult // 当我们需要主动取消网络请求的时候可以用返回值Cancellable, 一般不用的话做忽略处理
func NetWorkRequest(_ target: TargetType, completion: @escaping successCallback, failed: failedCallback?,failedWithCode: failedWithCodeCallback?, errorResult: errorCallback?,_ haveMeta : Bool = false) -> Cancellable? {
    // 先判断网络是否有链接 没有的话直接返回--代码略
  
    if !UIDevice.isNetworkConnect {
        print("提示用户网络似乎出现了问题")
        return nil
    }
    // 这里显示loading图
    return Provider.request(MultiTarget(target)) { result in
        HudManager.dismissHUD()
        // 隐藏hud
        switch result {
        case let .success(response):
            do {
                print("http 状态码\(response.statusCode)")
                let jsonData = try JSON(data: response.data)
                print(jsonData)
                //               这里的completion和failed判断条件依据不同项目来做，为演示demo我把判断条件注释了，直接返回completion。
                let statusCode = jsonData["status"].intValue
                if statusCode == 1 {
                    
                    if haveMeta {
                        
                        completion(jsonData.dictionaryObject! as Dictionary)
                    }else{
                        if jsonData["data"].dictionaryObject != nil {
                            completion(jsonData["data"].dictionaryObject! as Dictionary)
                        }else if jsonData["data"].arrayObject != nil{
                            completion(jsonData["data"].arrayObject! as Array)
                        }else{
                            completion(jsonData.dictionaryObject as Any)
                        }
                    }
                   
                    
                   
                }else{
                    
                    if let model =  NetWorkStringModel.deserialize(from: jsonData.dictionaryObject)  {
                        failedWithCode?(model.msg,model.status)
                        if model.code == -1 {
                            HudManager.showError("请重新登录")
                        }else if model.code == 16008{
                            
                            
                        }
                    }
//                    HudManager.showError(jsonData["msg"].stringValue)
//                    let qiCode = QiResponseCode.init(rawValue: statusCode)
//                    if qiCode == .tokenEnable{//重新登录
////                        HudManager.showError("请重新登录")
//                    } else{
//                        failed?(jsonData["msg"].stringValue)
//                        failedWithCode?(jsonData["code"].stringValue,qiCode?.rawValue ?? <#default value#>)
//                    }
                    
                
                }
            } catch {
                print("res" + String(data: response.data, encoding: String.Encoding.utf8)!)
            }
        case let .failure(error):
            HudManager.dismissHUD()
            // 网络连接失败，提示用户
           
            print("网络连接失败\(error)")
            errorResult?()
        }
    }
}

/// - Parameters:
///   - target: 网络请求
///   - completion: 请求成功的回调
func OtherNetWorkRequest(_ target: TargetType, completion: @escaping successCallback)  {
    HudManager.show()
    // 这里显示loading图
    Provider.request(MultiTarget(target)) { result in
        // 隐藏hud
        HudManager.dismissHUD()
        switch result {
        case let .success(response):
            do {
                let jsonData = try JSON(data: response.data)
                print(jsonData)
                completion(jsonData.dictionaryObject as Any)
            } catch {
                print("res" + String(data: response.data, encoding: String.Encoding.utf8)!)
            }
        case let .failure(error):
            // 网络连接失败，提示用户
            print("网络连接失败\(error)")
            
        }
    }
}

// 成功回调
typealias RequestSuccessCallback = ((_ model: Any?) -> ())
// 失败回调
typealias RequestFailureCallback = ((_ code: Int, _ message: String) -> Void)

/// 带有模型转化的底层网络请求的基础方法    可与 179 行核心网络请求方法项目替换 唯一不同点是把数据转模型封装到了网络请求基类中
///  本方法只写了大概数据转模型的实现，具体逻辑根据业务实现。
/// - Parameters:
///   - target: 网络请求接口
///   - isHideFailAlert: 是否隐藏失败的弹框
///   - modelType: 数据转模型所需要的模型
///   - successCallback: 网络请求成功的回调 转好的模型返回出来
///   - failureCallback: 网络请求失败的回调
/// - Returns: 可取消网络请求的实例
@discardableResult
func NetWorkRequest<T: HandyJSON>(_ target: TargetType, modelType: T.Type?, successCallback: RequestSuccessCallback?, failureCallback: RequestFailureCallback? = nil) -> Cancellable? {
    // 这里显示loading图
    return Provider.request(MultiTarget(target)) { result in
        // 隐藏hud
        HudManager.dismissHUD()
        switch result {
        case let .success(response):
            do {
                
                if target.method == .put{
                    
                    if response.statusCode == 1 {
                        
                        successCallback?("success")
                    }else{
                        
                        failureCallback?(-1, "upload fail")
                    }
                    return
                }
                
                let myJson = try JSONSerialization.jsonObject(with: response.data)
                print(myJson)

                let jsonData = try JSON(data: response.data , options: [.fragmentsAllowed])
                print(jsonData)
                let statusCode = jsonData["code"].boolValue
                if statusCode {
                    
                    // data里面不返回数据 只是简单的网络请求 无需转模型
                    if jsonData["data"].dictionaryObject == nil, jsonData["data"].arrayObject == nil { // 返回字符串
                        
                        let result1 = jsonData["data"].string
                        let result2 = jsonData["data"].number
                        if let result1 = result1{
                         
                            successCallback?(result1)
                        }else if let result2 = result2{
                            
                            successCallback?(result2)
                        }else{
                            successCallback?(nil)
                        }
                        return
                    }

                    if jsonData["data"]["records"].arrayObject != nil {
                        
                        if let model =  [T].deserialize(from: jsonData["data"]["records"].arrayObject)  {
                            
                            let amount = jsonData["data"]["total"].intValue
                                
                                successCallback?((datas:model,amount:amount))
                        } else {
                            print("解析失败")
                            failureCallback?(-1, "解析失败")
                        }
                    }else if jsonData["data"]["content"].arrayObject != nil{
                        
                        if let model =  [T].deserialize(from: jsonData["data"]["content"].arrayObject)  {
                            
                            let amount = jsonData["data"]["totalElements"].intValue
                                
                                successCallback?((datas:model,amount:amount))
                        } else {
                            print("解析失败")
                            failureCallback?(-1, "解析失败")
                        }

                    } else if jsonData["data"].dictionaryObject != nil { // 字典转model
                        
                        if let model =  T.deserialize(from: jsonData["data"].dictionaryObject)  {
                            successCallback?(model)
                            print(model)
                        } else {
                            print("解析失败")
                            failureCallback?(-1, "解析失败")
                        }
                    } else if jsonData["data"].arrayObject != nil { // 数组转model
                        if let model = [T].deserialize(from: jsonData["data"].arrayObject) {
                            successCallback?(model)
                        } else {
                            print("解析失败")
                            failureCallback?(-1, "解析失败")
                        }
                    }
                }else{
                     
                    let code = jsonData["code"].intValue

                    if code == 50{
                        userManager.userLogout()
                        let notificationName = Notification.Name(rawValue: "AutoLogout")
                        NotificationCenter.default.post(name: notificationName, object: nil)
                        HudManager.showOnlyText("未登录")
//                        userManager.logout()
                    }else if code == 16008{
                        
                        let vc =  UIApplication.shared.windows.first?.rootViewController
                        vc?.dismiss(animated: true)
//                        failureCallback?(16008, jsonData["message"].stringValue)
                        
                    
                    }else{
                        
                        let message = jsonData["message"].stringValue
                        failureCallback?(code, message)
                    }
                }
            } catch {
                failureCallback?(response.statusCode, String(data:response.data,encoding:.utf8) ?? "fail")
            }
        case let .failure(error):
            // 网络连接失败，提示用户****
//            HudManager.showOnlyText("can not connect to Internet")
            failureCallback?(error.errorCode, "")
        }
    }
}

/// 基于Alamofire,网络是否连接，，这个方法不建议放到这个类中,可以放在全局的工具类中判断网络链接情况
/// 用计算型属性是因为这样才会在获取isNetworkConnect时实时判断网络链接请求，如有更好的方法可以fork

extension UIDevice {
    static var isNetworkConnect: Bool {
        let network = NetworkReachabilityManager()
        return network?.isReachable ?? true // 无返回就默认网络已连接
    }
}


