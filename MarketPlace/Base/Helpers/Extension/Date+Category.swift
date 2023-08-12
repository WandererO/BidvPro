//
//  Date+Category.swift
//  doctor
//
//  Created by apple on 2017/3/30.
//  Copyright © 2017年 digital. All rights reserved.
//

import Foundation

extension Date {
    
    /// 时间格式化
    /// - Parameter date: date
    static func string(y date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        
        return formatter.string(from: date)
    }
    
    /// 时间格式化
    /// - Parameter date: date
    static func string(ymdhms date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.string(from: date)
    }
    
    
    /// 时间格式化
    /// - Parameter date: date
    static func string(ymd date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: date)
    }
    
    /// 时间格式化
    /// - Parameter date: date
    static func string(date: Date , dateFormat:String = "yyyy-MM-dd" ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        
        return formatter.string(from: date)
    }

    
    /// 获取时间
    /// - Parameter dateStr: 时间字符串
    static func date(ymd dateStr: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.date(from: dateStr)
    }
    
    
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        //            let week = 7 * day
        let year = 365 * day
        
        if secondsAgo < minute {
            return "just now"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute)m ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour)h ago"
        } else if secondsAgo < year {
            return "\(secondsAgo / day)d ago"
        }
        return "\(secondsAgo / year)y ago"
    }

}

extension Date {
    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    /// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
}
