//
//  Dictionary+Extension.swift
//  MarketPlace
//
//  Created by mac on 2023/3/15.
//

import Foundation

extension Dictionary {
    
    func toJsonString() -> String {
        
        if let selfDic = self as? [String:String]{
            
            let keyArray = selfDic.keys.sorted { key1, key2 in
                
                return key1.localizedStandardCompare(key2) == ComparisonResult.orderedAscending
            }
            var resultString = ""
            var isLast = false
            for key in keyArray{
              
                isLast = key == keyArray.last
                if let value = selfDic[key]{

                    resultString += "\(key)=\(value)\(isLast ? "" : "&")"
                }
            }
            return resultString
        }
        return ""
    }
}
