//
//  UIImageView+KFExt.swift
//
//
//  Created by  on 2021/12/6.
//

import Kingfisher

#if !os(watchOS)

#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension KingfisherWrapper where Base: KFCrossPlatformImageView {
        
    @discardableResult
    public func setImage( with url: String , placeholder:Placeholder? = nil, completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask? {
        
        return setImage(with: URL(string: url), placeholder: placeholder, options: nil,progressBlock: nil,completionHandler: completionHandler)
   }

    
     public func setImage( with resource: Resource?, placeholder: Placeholder? = nil, options: KingfisherOptionsInfo? = nil,completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask?{
         
         
        return setImage(with: resource, placeholder: placeholder, options: options,progressBlock: nil,completionHandler: completionHandler)
    }

}

#endif

extension UIImageView {
    
    
}
