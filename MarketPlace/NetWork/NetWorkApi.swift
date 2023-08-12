//
//  NetWorkApi.swift
//  MarketPlace
//
//  Created by tantankk on 2022/4/21.
//

import Foundation
import UIKit
import Moya
import AVFoundation

private func JSONResponseDataFormatter(_ data: Data) -> String {
  do {
    let dataAsJSON = try JSONSerialization.jsonObject(with: data)
    let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
    return String(data: prettyData, encoding: .utf8) ?? ""
  } catch {
    if JSONSerialization.isValidJSONObject(data) {
        return String(data: data, encoding: .utf8) ?? ""
    }
    return ""
  }
}

let configuration = NetworkLoggerPlugin.Configuration(
    formatter: NetworkLoggerPlugin.Configuration.Formatter(
        requestData: JSONResponseDataFormatter,
        responseData: JSONResponseDataFormatter
    ),
    logOptions: .verbose
)
let NetWorkProvider = MoyaProvider<RequestEnum>(plugins: [NetworkLoggerPlugin(configuration: configuration)])

// MARK: - Provider support
private extension String {
  var urlEscapedString: String {
    return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
}

public enum RequestEnum {

    
    ///登录
    case login(account:String, password:String)
    
    ///转账记录
    case getTransferRecord(type:String, startTime:String, endTime:String)

}


extension RequestEnum: TargetType {
    
    //地址
    public var path: String {
        switch self {
            
        case .login:
            return "/api/user/login"
        case .getTransferRecord:
            return "/api/user/changeDateList"
            

        default :
            return ""
        }
    }
    
    public var task: Task {
        
        switch self {
            
        case let .login(account, password):
            let dict = ["account":account, "password":password] as [String : Any]
            return .requestParameters(parameters: dict, encoding: URLEncoding.queryString)
            
        case let .getTransferRecord(type, startTime, endTime):
            let dict = ["type":type , "startTime":startTime, "endTime":endTime] as [String : Any]
            return .requestParameters(parameters: dict, encoding: URLEncoding.queryString)
            
            

        default :
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }
    
    
}

extension RequestEnum {
    
    public var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }

    public var baseURL: URL {
        //MARK: 拼接参数
        switch self {
                        
        default:
            return Environment.current.baseUrl
        }
    }
    public var headers: [String : String]? {
        
        switch self {
        default:
        return nil
        }
    }

    public var sampleData: Data {
        switch self {
        default:
            return "json.".data(using: String.Encoding.utf8)!
        }
    }
}

public func jsonToData(jsonDic:Dictionary<String, Any>) -> Data? {
    if (!JSONSerialization.isValidJSONObject(jsonDic)) {
        return nil
    }
    let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
    let str = String(data:data!, encoding: String.Encoding.utf8)
    print("请求数据:\(str!)")
    return data
}
