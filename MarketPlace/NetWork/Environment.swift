//
//  Environment.swift
//  MarketPlace
//
//  Created by tanktank on 2022/4/22.
//

import Foundation

enum Environment {
    case debug
    case production
    case release
}

extension Environment {
    var baseUrl: URL {
        switch self {
        case .debug://192.168.0.4:16000  http://www.flord.top
            return URL(string: "http://47.98.156.218")!//192.168.0.11:80
        default:
            return URL(string: "https://network.io")!
        }
    }
    
    var wsUrl: URL {
        switch self {
        case .debug:
            return URL(string: "ws://172.16.1.250/ws/zh_cn/")!
        default:
            return URL(string: "ws://8.888.888.888:3333/")!
        }
    }
    
    static var current: Environment {
       
        return .debug
        return .release

        #if DEBUG
        return .debug
        #elseif PRODUCTION
        return .production
        #elseif RELEASE
        return .release
        #endif
        return .debug
    }
    
   
    var rcKey: String {
        switch self {
        case .debug:
            return ""
        default:
            return ""
        }
    }
    
  
}
