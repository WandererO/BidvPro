//
//  UIImage+Extension.swift
//  MarketPlace
//
//  Created by tanktank on 2022/4/21.
//

import Foundation
import UIKit

extension UIImage{
    
    /// 返回一张纯颜色的图像
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        
        if size.width <= 0 || size.height <= 0 { return nil }
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        self.init(cgImage: image.cgImage!, scale: 2, orientation: .up)
    }
    
    /// 将颜色转换为图片
    ///
    /// - Parameter color: UIColor
    /// - Returns: UIImage
    class func getImageWithColor(color:UIColor)->UIImage{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static func getViewScreenshot(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    class func convertStrToImage(_ imageStr:String) ->UIImage?{
        if let data: NSData = NSData(base64Encoded: imageStr, options:NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        {
            if let image: UIImage = UIImage(data: data as Data)
            {
                return image
            }
        }
        return nil
    }
    
//    extension UIImage {
        // 修复图片旋转
        func fixOrientation() -> UIImage {
            if self.imageOrientation == .up {
                return self
            }
             
            var transform = CGAffineTransform.identity
             
            switch self.imageOrientation {
            case .down, .downMirrored:
                transform = transform.translatedBy(x: self.size.width, y: self.size.height)
                transform = transform.rotated(by: .pi)
                break
                 
            case .left, .leftMirrored:
                transform = transform.translatedBy(x: self.size.width, y: 0)
                transform = transform.rotated(by: .pi / 2)
                break
                 
            case .right, .rightMirrored:
                transform = transform.translatedBy(x: 0, y: self.size.height)
                transform = transform.rotated(by: -.pi / 2)
                break
                 
            default:
                break
            }
             
            switch self.imageOrientation {
            case .upMirrored, .downMirrored:
                transform = transform.translatedBy(x: self.size.width, y: 0)
                transform = transform.scaledBy(x: -1, y: 1)
                break
                 
            case .leftMirrored, .rightMirrored:
                transform = transform.translatedBy(x: self.size.height, y: 0);
                transform = transform.scaledBy(x: -1, y: 1)
                break
                 
            default:
                break
            }
             
            let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: self.cgImage!.bitmapInfo.rawValue)
            ctx?.concatenate(transform)
             
            switch self.imageOrientation {
            case .left, .leftMirrored, .right, .rightMirrored:
                ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.height), height: CGFloat(size.width)))
                break
                 
            default:
                ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.width), height: CGFloat(size.height)))
                break
            }
             
            let cgimg: CGImage = (ctx?.makeImage())!
            let img = UIImage(cgImage: cgimg)
             
            return img
        }

}

extension CGImage {
    var isDark: Bool {
        get {
            guard let imageData = self.dataProvider?.data else { return false }
            guard let ptr = CFDataGetBytePtr(imageData) else { return false }
            let length = CFDataGetLength(imageData)
            let threshold = Int(Double(self.width * self.height) * 0.45)
            var darkPixels = 0
            for i in stride(from: 0, to: length, by: 4) {
                let r = ptr[i]
                let g = ptr[i + 1]
                let b = ptr[i + 2]
                let luminance = (0.299 * Double(r) + 0.587 * Double(g) + 0.114 * Double(b))
                if luminance < 150 {
                    darkPixels += 1
                    if darkPixels > threshold {
                        return true
                    }
                }
            }
            return false
        }
    }
}

extension UIImage {
    var isDark: Bool {
        get {
            return self.cgImage?.isDark ?? false
        }
    }
    
    func cropping(to rect: CGRect) -> UIImage? {
          let scale = UIScreen.main.scale
          let x = rect.origin.x * scale
          let y = rect.origin.y * scale
          let width = rect.size.width * scale
          let height = rect.size.height * scale
          let croppingRect = CGRect(x: x, y: y, width: width, height: height)
          // 截取部分图片并生成新图片
          guard let sourceImageRef = self.cgImage else { return nil }
          guard let newImageRef = sourceImageRef.cropping(to: croppingRect) else { return nil }
          let newImage = UIImage(cgImage: newImageRef, scale: scale, orientation: .up)
          return newImage
      }
}
