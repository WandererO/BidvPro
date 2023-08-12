
//
//  String+Extension.swift
//  MarketPlace
//
//  Created by tanktank on 2022/4/19.
//

import UIKit
import Foundation
import CommonCrypto

extension String {
    /// MD5
    ///
    /// - Returns: 转为MD5
//    public func stringFromMD5() -> NSString {
//        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
//        if let data = self.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue) ?? .utf8) {
//            CC_MD5((data as NSData).bytes, CC_LONG(data.count), &digest)
//        }
//
//        let digestHex = digest.map { String(format: "%02x", $0) }.joined(separator: "")
//
//        return digestHex as NSString
//    }
    func hideEmail() -> String {
        
        var mail = self
        let arraySubstrings: [Substring] = mail.split(separator: "@")
        let arrayStrings: [String] = arraySubstrings.compactMap { "\($0)" } // i将Substring转为string
        var str = ""
        if arrayStrings[0].count < 3 {
            for _ in 0 ..< arrayStrings[0].count {
                str += "*"
            }
            return str + arrayStrings[1]
        } else {
        for _ in 0 ..< arrayStrings[0].count - 2 {
            str += "*"
        }
            let start = mail.index(mail.startIndex, offsetBy: 1)
            let end = mail.index(mail.startIndex, offsetBy: arrayStrings[0].count - 1)
            let range = Range(uncheckedBounds: (lower: start, upper: end))
            mail.replaceSubrange(range, with: str)
            return mail
        }
    }
    
    func hidePhoneNumber(number: String) -> String {
            
            if number.count < 5 {
                var str = ""
                for _ in 0 ..< number.count {
                    str += "*"
                }
                return str
            } else {
                //替换一段内容，两个参数：替换的范围和用来替换的内容
                let start = number.index(number.startIndex, offsetBy: (number.count - 5) / 2)
                let end = number.index(number.startIndex, offsetBy: (number.count - 5) / 2 + 4)
                let range = Range(uncheckedBounds: (lower: start, upper: end))
                return number.replacingCharacters(in: range, with: "****")
            }
        }
    
    /// 获取高度计算
    ///
    /// - Parameters:
    ///   - size: 矩形已知范围
    ///   - attributes: 文字属性
    /// - Returns: 高度
    public func height(_ size: CGSize, _ attributes: [NSAttributedString.Key: Any]?) -> CGFloat {

        let string = self as NSString

        let stringSize = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

        return stringSize.height

    }
    /// 获取宽度计算
    ///
    /// - Parameters:
    ///   - size: 矩形已知范围
    ///   - attributes: 文字属性
    /// - Returns: 宽度
    public func width(_ size: CGSize, _ attributes: [NSAttributedString.Key: Any]?) -> CGFloat {

        let string = self as NSString

        let stringSize = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

        return stringSize.width

    }
    
    
    
    public func isBlank() -> Bool {
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }
    

    public func textWidth(font: UIFont, height: CGFloat) -> CGFloat{
        
        return self.boundingRect(with:CGSize(width: CGFloat(MAXFLOAT), height:height), options: .usesLineFragmentOrigin, attributes: [.font:font], context:nil).size.width
    }

    
    //截取字符
    func interceptString(sourceString:String ,separator:String) -> String {
        let strAry = sourceString.components(separatedBy: separator)
        let resultStr:String = strAry.last!
        return resultStr
    }
    
    func localString()-> String{
        return LanguageManager.localValue(self)
    }
    
    func transferToCGFloat()-> CFloat {
        let doubleStr = Double(self) ?? 0
        let floatStr = CGFloat(doubleStr)
        return CFloat(floatStr)
    }
    
    
}
public extension String {
    /*
     *去掉首尾空格
     */
    var removeHeadAndTailSpace:String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉首尾空格 包括后面的换行 \n
     */
    var removeHeadAndTailSpacePro:String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉所有空格
     */
    var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
    var removeEditingSapce: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    var replaceEmpty: String {
        
        if self.isEmpty {
                
            return "-"
        }
        return self
    }

    
    /*
     *去掉首尾空格 后 指定开头空格数
     */
    func beginSpaceNum(num: Int) -> String {
        var beginSpace = ""
        for _ in 0..<num {
            beginSpace += " "
        }
        return beginSpace + self.removeHeadAndTailSpacePro
    }
    
    func get64Str() -> String {
        
        var calculateStr = self
        if calculateStr.hasPrefix("0x"){

            calculateStr.remove(at: index(calculateStr.startIndex, offsetBy: 1))
            calculateStr.remove(at: calculateStr.startIndex)

        }
        
        let count = calculateStr.count
        
        if count < 64 {
            
            var addZeroCount = 64 - count
            
            var string = ""
            
            while addZeroCount != 0{
                
                string += "0"
                addZeroCount -= 1
            }
           return  string + calculateStr
        }else{
            return calculateStr
        }
    }
    
}


extension String {
//    public var md55: String {
//        guard let data = data(using: .utf8) else {
//            return self
//        }
//        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH));
//
//#if swift(>=5.0)
//
//        _ = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
//            return CC_MD5(bytes.baseAddress, CC_LONG(data.count), &digest)
//        }
//
//#else
//        _ = data.withUnsafeBytes { bytes in
//                return CC_MD5(bytes, CC_LONG(data.count), &digest)
//           }
//
//           #endif
//
//           return digest.map { String(format: "%02x", $0) }.joined()
//
//    }

    func md5() -> String {
        let data = Data(utf8) as NSData
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(data.bytes, CC_LONG(data.length), &hash)
        
        let str = hash.map { String(format: "%02hhx", $0) }.joined()
        return str.lowercased()
    }
    
    func getShowTime(formate:String? = nil) ->String{
        let date:Date = Date.init(timeIntervalSince1970: (Double(self) ?? 1000) / 1000 )
        if let formate {
            return Date.string(date: date, dateFormat: formate)
        }
        return Date.string(ymdhms: date)

    }
    // 秒 时间戳
    func getShowSecondTime(formate:String? = nil) ->String{
        let date:Date = Date.init(timeIntervalSince1970: (Double(self) ?? 0) )
        if let formate {
            return Date.string(date: date, dateFormat: formate)
        }
        return Date.string(ymdhms: date)
    }
    
    static func getTimeStringYMDHms(stampStr:String) -> String {
//        guard let timeStamp = Double(self) else { return "" }
//        //转换为时间
//        let timeInterval:TimeInterval = TimeInterval(timeStamp)
//        let date = Date(timeIntervalSince1970: timeInterval)
        let timeStamp:Int = Int(stampStr) ?? 0
        
        let date = Date(timeIntervalSince1970: TimeInterval.init(timeStamp/1000))
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return dformatter.string(from: date)
    }
    
    static func getTimeStringYMD(stampStr:String) -> String {
//        guard let timeStamp = Double(self) else { return "" }
//        //转换为时间
//        let timeInterval:TimeInterval = TimeInterval(timeStamp)
//        let date = Date(timeIntervalSince1970: timeInterval)
        let timeStamp:Int = Int(stampStr) ?? 0
        
        let date = Date(timeIntervalSince1970: TimeInterval.init(timeStamp/1000))
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "YYYY-MM-dd"
        return dformatter.string(from: date)
    }
    
    static func getCurrentSysDate() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MM/YYYY"// 自定义时间格式
        // GMT时间 转字符串，直接是系统当前时间
//        dateformatter.string(from: Date())
        return dateformatter.string(from: Date())
    }
    
    static func getLastMonth(num : Int) -> String {
        let curDate = Date()
        let formater = DateFormatter()
        formater.dateFormat = "dd/MM/YYYY"
        
        let calendar = Calendar(identifier: .gregorian)
        var lastMonthComps = DateComponents()
        // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
        lastMonthComps.month = num
        let newDate = calendar.date(byAdding: lastMonthComps, to: curDate)
        let dateStr = formater.string(from: newDate!)
        
        return dateStr
    }

    
    func getTimeAgoDisplay() ->String{
        let date:Date = Date.init(timeIntervalSince1970: (Double(self) ?? 1000) / 1000 )
        return date.timeAgoDisplay()
    }
    
    
    func getShowPrice() -> String {
        if Double(self) == 0 {
            
            return "0"
        }

        if let balance = Double(self) {
            let formatter = NumberFormatter()
            
            formatter.numberStyle = .decimal
            formatter.usesGroupingSeparator = true //分隔设true
            formatter.groupingSeparator = "," //分隔符
            formatter.groupingSize = 3  //分隔位数
            formatter.maximumFractionDigits = 6
            let result = formatter.string(from: NSNumber(value: balance))

            if let result{
                return result
            }else{
                return "---"
            }
        }else{
            return "---"
        }

        // result: $1,234,567
        
    }
        
    func getTotalPrice() -> String {
        return String(format: "%.2f", Double(self) ?? 0 )
    }
    
    func getMnumber() -> String{
        
        if self == ""{
            return ""
        }
        
        let value = Double(self) ?? 0
        
        if value > 1000 && value < 1000000 {
            
            return String(format: "%.2f", value/1000.0 ).removeUselessZero() + "K"
        } else if value >= 1000000 && value < 1000000000 {
            
            return String(format: "%.2f", value/1000000.0 ).removeUselessZero() + "M"
        }else if value >= 1000000000 {
         
            let final = value/1000000000.0
            
            return String(format: "%.2f", final ).removeUselessZero() + "B"
        }
        let final = String(format: "%.2f", value)

        if Double(final) == 0 {
            
            return "0"
        }
        return final.removeUselessZero()
    }
    
    func getKInt() -> String{
        
        if self == ""{
            return "---"
        }
        
        let value = Double(self) ?? 0
        
        if value > 1000 && value < 1000000 {
            
            return String(format: "%.2fK", value/1000.0 )
        } else if value >= 1000000 && value < 1000000000 {
            
            return String(format: "%.2fM", value/1000000.0 )
        }else if value >= 1000000000 {
            
            return String(format: "%.2fB", value/1000000000.0 )
        }
        let final = String(format: "%.0f", value)

        if Double(final) == 0 {
            
            return "0"
        }
        return final
    }
    
    func getpercent() -> String{
        
        if self == ""{
            return "-"
        }
        let value = (Double(self) ?? 0 ) * 100
        
        if value == 0 {
            
            return "-"
        }
        let resultStr = String(format: "%.2f ", value) + "%"
        return resultStr
    }
    
    func removeUselessZero() -> String{
            var outNumber = self
            var i = 1

            if self.contains("."){
                while i < self.count{
                    if outNumber.hasSuffix("0") {
                        outNumber.remove(at: outNumber.index(before: outNumber.endIndex))
                        i = i + 1
                    } else {
                        break
                    }
                }
                if outNumber.hasSuffix("."){
                    outNumber.remove(at: outNumber.index(before: outNumber.endIndex))
                }
                return outNumber
            } else {
                return self
            }
        }
    
    func getShowAddress()->String {
        
        let firStr = self.prefix(6)
        let lastStr = self.suffix(4)
        let address = String(firStr +  "..." + lastStr)
        return address
    }

    
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func getWidth(font : UIFont) -> CGFloat {
        
        let dict : [NSAttributedString.Key : Any]? = [NSAttributedString.Key.font : font]
        let size = self.size(withAttributes: dict)
        
        return size.width
    }
        
    func getNumberOfLineWith(font : UIFont , lineWidth : CGFloat) -> (Int , CGFloat){
        
        let dict : [NSAttributedString.Key : Any]? = [NSAttributedString.Key.font : font]
        let size = self.size(withAttributes: dict)
        
        var lineNum = Int(size.width / lineWidth)
        
        let chuyu =  size.width.truncatingRemainder(dividingBy: lineWidth)

        if chuyu != 0 {
            
            lineNum = lineNum + 1
        }

        return (lineNum , size.height)
    }


}

extension String {
    
    func getMaxDigitsNum(withMaxDigits digits : Int? , showZero:Bool = false , hasSeparator :Bool = false ,hasMinimumFractionDigits :Bool = false ,roundingMode : NumberFormatter.RoundingMode = .down) -> String {
       
        if Double(self) == 0 ,!showZero{
            
            return "-"
        }
        
        if let balance = Double(self) {
            let formatter = NumberFormatter()
            
            formatter.numberStyle = .decimal
            formatter.usesGroupingSeparator = hasSeparator //分隔设true
            formatter.groupingSeparator = "," //分隔符
            formatter.groupingSize = 3  //分隔位数
            formatter.maximumFractionDigits = digits ?? 0
            formatter.roundingMode = roundingMode
            formatter.minimumFractionDigits = hasMinimumFractionDigits ? (digits ?? 0) : 0
            let result = formatter.string(from: NSNumber(value: balance))

            if let result{
                return result
            }else{
                return "-"
            }
        }else{
            return "-"
        }
    }
}


extension KMBFormatter {
    enum Unit: String {
        case none = ""
        case K
        case M
        case B
    }
}
open class KMBFormatter: Formatter {

    private let numberFormatter = NumberFormatter()
    private let unitSize: [Unit: Double] = [.none: 1,
                                            .K: 1000,
                                            .M: pow(1000, 2),
                                            .B: pow(1000, 3)]

    open func string(fromNumber number: Int64) -> String {
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .down
        return convertValue(fromNumber: number)
    }

    open override func string(for obj: Any?) -> String? {
        guard let value = obj as? Double else {
            return nil
        }

        return string(fromNumber: Int64(value))
    }

    private func convertValue(fromNumber number: Int64) -> String {
        let number = Double(number)
        if number == 0 {
            return partsToIncludeFor(value: "Zero", unit: .none)
        } else {
            if number == 1 || number == -1 {
                return formatNumberFor(number: number, unit: .none)
            }else if number < unitSize[.K]! && number > -unitSize[.K]! {
                return divide(number, by: unitSize, for: .none)
            } else if number < unitSize[.M]! && number > -unitSize[.M]! {
                return divide(number, by: unitSize, for: .K)
            } else if number < unitSize[.B]! && number > -unitSize[.B]! {
                return divide(number, by: unitSize, for: .M)
            } else {
                return divide(number, by: unitSize, for: .B)
            }
        }
    }

    private func divide(_ number: Double, by unitSize: [Unit: Double], for unit: Unit) -> String {
        guard let numberSizeUnit = unitSize[unit] else {
            fatalError("Cannot find value \(unit)")
        }
        let result = number/numberSizeUnit
        return formatNumberFor(number: result, unit: unit)
    }

    private func formatNumberFor(number: Double, unit: Unit) -> String {

        switch unit {
        case .none, .K:
            numberFormatter.minimumFractionDigits = 0
            numberFormatter.maximumFractionDigits = 1
            let result = numberFormatter.string(from: NSNumber(value: number))
            return partsToIncludeFor(value: result!, unit: unit)
        case .M:
            numberFormatter.minimumFractionDigits = 0
            numberFormatter.maximumFractionDigits = 2
            let result = numberFormatter.string(from: NSNumber(value: number))
            return partsToIncludeFor(value: result!, unit: unit)
        default:
            let result: String
            numberFormatter.minimumFractionDigits = 0
            numberFormatter.maximumFractionDigits = 3
            if number < 0 && false{
                let negNumber = round(number * 100) / 100
                result = numberFormatter.string(from: NSNumber(value: negNumber))!
            } else {
                result = numberFormatter.string(from: NSNumber(value: number))!
            }
            return partsToIncludeFor(value: result, unit: unit)
        }

    }

    private func partsToIncludeFor(value: String, unit: Unit) -> String {
        if value == "Zero" {
            return "0\(unit.rawValue)"
        } else {
            return "\(value)\(unit.rawValue)"
        }
    }

    private func lengthOfInt(number: Int) -> Int {
        guard number != 0 else {
            return 1
        }
        var num = abs(number)
        var length = 0

        while num > 0 {
            length += 1
            num /= 10
        }
        return length
    }

}
