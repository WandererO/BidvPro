//
//  EWPopMenu.swift
//  coiuntrade-ios
//
//  Created by Chamcha on 2022/5/5.
//

import UIKit

let NavigationMenuShared = EWPopMenu.shared

class EWPopMenu: NSObject {
    static let shared = EWPopMenu()
    private var menuView: EWPopMenuView?

    public func showPopMenuSelecteWithFrameWidth(width: CGFloat, height: CGFloat, point: CGPoint, item: [String], imgSource: [String],darkMode :Bool = false,isIconFont:Bool = false, action: @escaping ((Int) -> Void)) {
        weak var weakSelf = self
        /// 每次重置保证显示效果
        if self.menuView != nil {
            weakSelf?.hideMenu()
        }
        let window = UIApplication.shared.windows.first
        self.menuView = EWPopMenuView(width: width, height: height, point: point, items: item, imgSource: imgSource, darkMode: darkMode ,isIconFont : isIconFont , action: { (index) in
            ///点击回调
            action(index)
            weakSelf?.hideMenu()
        })
        menuView?.touchBlock = {
            weakSelf?.hideMenu()
        }
        self.menuView?.backgroundColor = UIColor.black.withAlphaComponent(0.01)
        window?.addSubview(self.menuView!)
    }
    
    public func showPopMenuSelecteWithFrameWidth(width: CGFloat, cellHeight: CGFloat, point: CGPoint, item: [String] , selectIndex : Int, textAligment : NSTextAlignment = .left , isShowCheckMark :Bool = true, action: @escaping ((Int) -> Void)) {
        weak var weakSelf = self
        /// 每次重置保证显示效果
        if self.menuView != nil {
            weakSelf?.hideMenu()
        }
        let window = UIApplication.shared.windows.first
        self.menuView = EWPopMenuView(width: width, cellHeight: cellHeight, point: point, items: item,selectIndex: selectIndex,textAligment : textAligment , isShowCheckMark: isShowCheckMark,action: { (index) in
            ///点击回调
            action(index)
            weakSelf?.hideMenu()
        })
        menuView?.touchBlock = {
            weakSelf?.hideMenu()
        }
        self.menuView?.backgroundColor = UIColor.black.withAlphaComponent(0.01)
        window?.addSubview(self.menuView!)
    }

    
    public func hideMenu() {
        self.menuView?.removeFromSuperview()
        self.menuView = nil
    }
}
