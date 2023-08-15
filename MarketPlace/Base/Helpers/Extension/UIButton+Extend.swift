//
//  UIButton+Extend.swift
//  Gregarious
//
//  Created by Admin on 2021/3/25.
//

import UIKit
import Kingfisher

@objcMembers
class ExpandEdgeInsets: NSObject {
    var top: CGFloat
    var left: CGFloat
    var bottom: CGFloat
    var right: CGFloat
    init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }

    convenience init(edge: CGFloat = 0) {
        self.init(top: edge, left: edge, bottom: edge, right: edge)
    }
}

// 扩大点击区域
extension UIButton{
    
    private struct ExpandeResponseAreaKey {
        static var key = "mmh_expand_response_area"
        static var videokey = "all_video_key"
    }
     
    /// 是否可以点击和选择更多相册视频
     var isSelectAllVideo: Bool? {
        get {
            if let allVideo = objc_getAssociatedObject(self, &ExpandeResponseAreaKey.videokey){
                return  allVideo as? Bool
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &ExpandeResponseAreaKey.videokey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 需要扩充的点击边距
    @objc var expandClickArea: ExpandEdgeInsets? {
        get {
            if let radius = objc_getAssociatedObject(self, &ExpandeResponseAreaKey.key) as? ExpandEdgeInsets {
                return radius
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &ExpandeResponseAreaKey.key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

    }
    // 重写系统方法修改点击区域
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)
        var bounds = self.bounds
        if (expandClickArea != nil) {
            let x: CGFloat = -(expandClickArea?.left ?? 0)
            let y: CGFloat = -(expandClickArea?.top ?? 0)
            let width: CGFloat = bounds.width + (expandClickArea?.left ?? 0) + (expandClickArea?.right ?? 0)
            let height: CGFloat = bounds.height + (expandClickArea?.top ?? 0) + (expandClickArea?.bottom ?? 0)
            bounds = CGRect(x: x, y: y, width: width, height: height) //负值是方法响应范围
        }
        return bounds.contains(point)
    }
}

extension UIButton {
    /// 对同时设置了Image和Title的场景时UIButton中的图片和文字的关系
    ///
    /// - left: 图片在左，文字在右，整体居中
    /// - right: 图片在右，文字在左，整体居中
    /// - top: 图片在上，文字在下，整体居中
    /// - bottom: 图片在下，文字在上，整体居中
    /// - centerTitleTop: 图片居中，文字在图片上面
    /// - centerTitleBottom: 图片居中，文字在图片下面
    enum ImagePosition: Int {
        case left, right, top, bottom, centerTitleTop, centerTitleBottom
    }
    
    /// 调整按钮的文本和image的布局，前提是title和image同时存在才会调整；padding是调整布局时整个按钮和图文的间隔
    func setupImagePosition(_ position: ImagePosition = ImagePosition.left, padding: CGFloat) {
        if self.imageView?.image == nil || self.titleLabel?.text == nil { return }
        self.titleEdgeInsets = UIEdgeInsets.zero
        self.imageEdgeInsets = UIEdgeInsets.zero
        
        let imageRect = self.imageView!.frame
        let titleRect = self.titleLabel!.frame
        let totalHeight = imageRect.height + titleRect.height + padding
        let height = self.frame.height
        let width = self.frame.width
        
        switch position {
        case .left: do {
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: padding / 2.0, bottom: 0, right: -padding / 2.0)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -padding / 2.0, bottom: 0, right: padding / 2.0)
            }
        case .right: do {
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageRect.width + padding / 2.0), bottom: 0, right: (imageRect.width + padding / 2.0))
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: (titleRect.width + padding / 2), bottom: 0, right: -(titleRect.width + padding / 2))
            }
        case .top: do {
            self.titleEdgeInsets = UIEdgeInsets(top: ((height - totalHeight) / 2.0 + imageRect.height + padding - titleRect.origin.y),
                                                left: (width / 2.0 - titleRect.origin.x - titleRect.width / 2.0) - (width - titleRect.width) / 2.0,
                                                bottom: -((height - totalHeight) / 2.0 + imageRect.height + padding - titleRect.origin.y),
                                                right: -(width / 2.0 - titleRect.origin.x - titleRect.width / 2.0) - (width - titleRect.width) / 2.0)
            self.imageEdgeInsets = UIEdgeInsets(top: ((height - totalHeight) / 2.0 - imageRect.origin.y),
                                                left: (width / 2.0 - imageRect.origin.x - imageRect.width / 2.0),
                                                bottom: -((height - totalHeight) / 2.0 - imageRect.origin.y),
                                                right: -(width / 2.0 - imageRect.origin.x - imageRect.width / 2.0))
            }
        case .bottom: do {
            self.titleEdgeInsets = UIEdgeInsets(top: ((height - totalHeight) / 2.0 - titleRect.origin.y),
                                                left: (width / 2.0 - titleRect.origin.x - titleRect.width / 2.0) - (width - titleRect.width) / 2.0,
                                                bottom: -((height - totalHeight) / 2.0 - titleRect.origin.y),
                                                right: -(width / 2.0 - titleRect.origin.x - titleRect.width / 2.0) - (width - titleRect.width) / 2.0)
            self.imageEdgeInsets = UIEdgeInsets(top: ((height - totalHeight) / 2.0 + titleRect.height + padding - imageRect.origin.y),
                                                left: (width / 2.0 - imageRect.origin.x - imageRect.width / 2.0),
                                                bottom: -((height - totalHeight) / 2.0 + titleRect.height + padding - imageRect.origin.y),
                                                right: -(width / 2.0 - imageRect.origin.x - imageRect.width / 2.0))
            }
        case .centerTitleTop: do {
            self.titleEdgeInsets = UIEdgeInsets(top: -(titleRect.origin.y + titleRect.height - imageRect.origin.y + padding),
                                                left: (width / 2.0 -  titleRect.origin.x - titleRect.width / 2.0) - (width - titleRect.width) / 2.0,
                                                bottom: (titleRect.origin.y + titleRect.height - imageRect.origin.y + padding),
                                                right: -(width / 2.0 -  titleRect.origin.x - titleRect.width / 2.0) - (width - titleRect.width) / 2.0)
            self.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                left: (width / 2.0 - imageRect.origin.x - imageRect.width / 2.0),
                                                bottom: 0,
                                                right: -(width / 2.0 - imageRect.origin.x - imageRect.width / 2.0))
            }
        case .centerTitleBottom: do {
            self.titleEdgeInsets = UIEdgeInsets(top: (imageRect.origin.y + imageRect.height - titleRect.origin.y + padding),
                                                left: (width / 2.0 -  titleRect.origin.x - titleRect.width / 2.0) - (width - titleRect.width) / 2.0,
                                                bottom: -(imageRect.origin.y + imageRect.height - titleRect.origin.y + padding),
                                                right: -(width / 2.0 -  titleRect.origin.x - titleRect.width / 2.0) - (width - titleRect.width) / 2.0)
            self.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                left: (width / 2.0 - imageRect.origin.x - imageRect.width / 2.0),
                                                bottom: 0,
                                                right: -(width / 2.0 - imageRect.origin.x - imageRect.width / 2.0))
            }
        }
    }
}

 
