//
//  BaseTableView.swift
//  test
//
//  Created by tanktank on 2022/4/18.
//

import UIKit

class BaseTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configyrationLatestVersion()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configyrationLatestVersion()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configyrationLatestVersion()
    }
}

// MARK:- 版本适配
extension BaseTableView {
    
    /// 适配新版本
    func configyrationLatestVersion() {
        if #available(iOS 11.0, *)  {
            self.contentInsetAdjustmentBehavior = .never
        }
        
        if #available(iOS 13.0, *) {
            self.automaticallyAdjustsScrollIndicatorInsets = false
        }
        ///ios15 分组悬停默认22高度改为0
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0
        }
        
        self.estimatedRowHeight = 0
        self.estimatedSectionHeaderHeight = 0
        self.estimatedSectionFooterHeight = 0
        self.tableFooterView = UIView()
        self.tableFooterView?.backgroundColor = .clear
        self.tableFooterView?.height = 1
    }
}

//extension BaseTableView : EmptyDataSetSource , EmptyDataSetDelegate {
//
//
//}
//
class NoDataView : BaseView{
    
    var content:String = "" {
        didSet {
            contenLabel.text = content
        }
    }
    
    var imageStr:String = "" {
        didSet{
            imageview.image = UIImage(named: imageStr)
        }
    }
    

//    private let titleLabel = UILabel()
    private let contenLabel = UILabel()
    let imageview = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        
        
        self.addSubview(imageview)
        imageview.contentMode = .bottom
        imageview.snp.makeConstraints { make in
            make.width.equalTo(159)
            make.height.equalTo(100)
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        contenLabel.textColor = .hexColor("999999")
        contenLabel.font = FONT_SB(size: 16)
        contenLabel.textAlignment = .center
        self.addSubview(contenLabel)
        contenLabel.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(imageview.snp.bottom).offset(20)
            make.height.equalTo(17)
        }
        
        
}
    
}

public extension UITableView {
    
    func scrollToFirst(at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard numberOfSections > 0 else { return }
        guard numberOfRows(inSection: 0) > 0 else { return }
        let indexPath = IndexPath(item: 0, section: 0)
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
    
    func scrollToLast(at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard numberOfSections > 0 else { return }
        let lastSection = numberOfSections - 1
        guard numberOfRows(inSection: 0) > 0 else { return }
        let lastIndexPath = IndexPath(item: numberOfRows(inSection: lastSection)-1, section: lastSection)
        scrollToRow(at: lastIndexPath, at: scrollPosition, animated: animated)
    }
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}

extension BaseTableView {
    
    func scrollToBottom(at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard numberOfSections > 0 else { return }
        let lastSection = numberOfSections - 1
        guard numberOfRows(inSection: 0) > 0 else { return }
        let lastIndexPath = IndexPath(item: numberOfRows(inSection: lastSection)-1, section: lastSection)
        scrollToRow(at: lastIndexPath, at: scrollPosition, animated: animated)
    }
    
    func scrollToTop(at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard numberOfSections > 0 else { return }
        guard numberOfRows(inSection: 0) > 0 else { return }
        let indexPath = IndexPath(item: 0, section: 0)
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }

    func addTopBounceAreaView(color: UIColor = .white) {
        var frame = UIScreen.main.bounds
        frame.origin.y = -frame.size.height
        let view = UIView(frame: frame)
        view.backgroundColor = color
        
        self.addSubview(view)
        self.sendSubviewToBack(view)
    }
    
    func showNoDataView(dataAry:[Any], image:UIImage? = nil, content:String?="暂无数据",  EqualTop:Float) {
        if dataAry.count > 0 {
            self.backgroundView = nil
            return
        }
        
        let bgView = UIView()
        bgView.backgroundColor = .white
        
        let img = UIImageView()
//        img.contentMode = .center
        bgView.addSubview(img)
        img.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(70)
            make.top.equalTo(EqualTop)
            make.centerX.equalToSuperview()
        }
        
        if image != nil {
            img.image = image
        }else {
            img.image = UIImage(named: "contract_nodata")
        }
        
        
        let titlab = UILabel()
        titlab.text = content
        titlab.textColor = .hexColor("#999999")
        titlab.font = FONT_M(size: 14)
        titlab.textAlignment = .center
        bgView.addSubview(titlab)
        titlab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(img.snp.bottom).offset(10)
            make.height.equalTo(17)
        }
        
        
        self.backgroundView = bgView
        
    }
}


class TableViewFooterView: BaseView {

    var content : String?{
        get{
            label.text
        }
        set{
            label.text = newValue
        }
    }
    
    var isNodata :Bool{
        set{
            nodataView.isHidden = !newValue
        }get{
            nodataView.isHidden
        }
    }
    
    private let imageview = UIImageView(image: UIImage(named: "contract_nodata"))
    private let label : UILabel = {
        let label = UILabel()
        label.text = "暂无数据"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = FONT_R(size: 12)
        label.textColor = .hexColor("999999")
        return label
    }()

    lazy var nodataView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical // 水平方向布局
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.addArrangedSubviews([imageview , label])
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUI(){
        
        self.addSubview(nodataView)
        nodataView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(43)
        }
        
    }
}
