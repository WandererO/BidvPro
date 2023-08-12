//
//  Float+Extension.swift
//  MarketPlace
//
//  Created by tanktank on 2022/5/16.
//

import UIKit

extension Float {
    /// 准确的小数尾截取 - 没有进位
    func decimalString(_ base: Self = 1) -> String {
        let tempCount: Self = pow(10, base)
        let temp = self*tempCount
        let target = Self(Int(temp))
        let stepone = target/tempCount
        if stepone.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", stepone)
        }else{
            return "\(stepone)"
        }
    }
}

extension Double {
    /// 准确的小数尾截取 - 没有进位
    func decimalString(_ base: Self = 1) -> String {
        let tempCount: Self = pow(10, base)
        let temp = self*tempCount
        let target = Self(Int(temp))
        let stepone = target/tempCount
        if stepone.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", stepone)
        }else{
            return "\(stepone)"
        }
    }
    
    func roundTo(places:Int) -> Double {

            let divisor = pow(10.0, Double(places))

            return (self * divisor).rounded() / divisor

    }
}


