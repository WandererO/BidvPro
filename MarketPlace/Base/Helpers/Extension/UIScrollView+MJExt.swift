//
//  UIScrollView+MJExt.swift
//  SaaS
//
//  Created by 袁涛 on 2021/10/25.
//


fileprivate var ktMJRefreshBackFooterKey = ""
fileprivate var ktMJRefreshNormalHeaderKey = ""
fileprivate var ktRefreshPageKey = ""
fileprivate var ktRefreshPageSizeKey = ""

extension UIScrollView {
    
    
    var mjFooter : MJRefreshBackNormalFooter? {
        
        set {
            objc_setAssociatedObject(self, &ktMJRefreshBackFooterKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        
        get {
            return objc_getAssociatedObject(self, &ktMJRefreshBackFooterKey) as? MJRefreshBackNormalFooter
        }
    }
    
    var mjHeader : MJRefreshNormalHeader? {
        
        set {
            objc_setAssociatedObject(self, &ktMJRefreshNormalHeaderKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        
        get {
            return objc_getAssociatedObject(self, &ktMJRefreshNormalHeaderKey) as? MJRefreshNormalHeader
        }
    }
    
    var page : Int {
        
        set {
            objc_setAssociatedObject(self, &ktRefreshPageKey, NSNumber(integerLiteral: newValue), .OBJC_ASSOCIATION_RETAIN)
        }
        
        get {
            if let k = objc_getAssociatedObject(self, &ktRefreshPageKey) as? NSNumber {
                return k.intValue
            }
            return 1
        }
    }
    
    var pageSize : Int {
        
        set {
            objc_setAssociatedObject(self, &ktRefreshPageSizeKey, NSNumber(integerLiteral: newValue), .OBJC_ASSOCIATION_RETAIN)
        }
        
        get {
            if let k = objc_getAssociatedObject(self, &ktRefreshPageSizeKey) as? NSNumber {
                return k.intValue
            }
            
            return 20
        }
    }
    
    
    func nomalMJHeaderRefresh(_ refreshingBlock : @escaping (() -> ())) {
        if mjHeader == nil {
            mjHeader = MJRefreshNormalHeader(refreshingBlock: {
                refreshingBlock()
            })
            mjHeader?.backgroundColor = .clear
            mjHeader?.lastUpdatedTimeLabel?.isHidden = true

            mjHeader?.setTitle("", for: MJRefreshState.idle)
            mjHeader?.setTitle("", for: MJRefreshState.pulling)
            mjHeader?.setTitle("", for: MJRefreshState.refreshing)

            self.mj_header = mjHeader
        }
    }
    
    func nomalMJFooterRefresh(_ refreshingBlock : @escaping (() -> ())){
        if mjFooter == nil {
            mjFooter = MJRefreshBackNormalFooter(refreshingBlock: {
                if let header = self.mjHeader {
                    if header.isRefreshing  {
                        self.mjFooter!.endRefreshing()
                        return
                    }
                }
                refreshingBlock()
            })
            mjFooter?.setTitle("", for: MJRefreshState.idle)
            mjFooter?.setTitle("", for: MJRefreshState.pulling)
            mjFooter?.setTitle("", for: MJRefreshState.refreshing)

            self.mj_footer = mjFooter
        }
//        self.mjFooter?.endRefreshingWithNoMoreData()
    }
    
    func endMJRefresh() {
        if let header = mjHeader {
            if header.isRefreshing  {
                header.endRefreshing()
            }
        }
        
        if let footer = mjFooter {
            if footer.isRefreshing {
                footer.endRefreshing()
            }
        }
    }
    
    func resetMoreData(by more : Bool) {
        if let footer = mjFooter {
            more ? footer.resetNoMoreData() : footer.endRefreshingWithNoMoreData()
        }
    }
    
    func beginMJPullRefresh() {
        if let header = mjHeader {
            if !header.isRefreshing  {
                header.beginRefreshing()
            }
        }
    }
    
    func beginRefresh(_ refreshingBlock : @escaping (() -> ())){
        if let header = mjHeader {
            if !header.isRefreshing {
                header.beginRefreshing {
                    refreshingBlock()
                }
            }
        }
    }
    
    
}
