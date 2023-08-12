//
//  MPBottomPopUpTableController.swift
//  MarketPlace
//
//  Created by Work on 3/21/23.
//

import UIKit

class MPBottomPopUpTableController: UITableViewController {
 
    let disposebag = DisposeBag()
    var selectIndex = -1
    var didselect : SelectBlock?
    var didSelectWithId:SelectBlockStr?
    var rowHeight : CGFloat = 56
    var cellTextColor : UIColor? = kMainColor
//    var cellFont : UIFont = FONT_R(size: 14)
    var cellFont : UIFont = FONT_M(size: 14)
    var idsAry:[String] = []
    
//    var reloadData 
    
    var isShowBottomView : Bool  = false {
        
        didSet{
            if isShowBottomView{
             
                self.tableView.tableFooterView = bottomView
                self.tableView.tableFooterView?.height = rowHeight
            }
        }
    }
    var isShowHeader : Bool  = false {
        
        didSet{
            if isShowHeader{
             
                self.tableView.tableHeaderView = haderView
                self.tableView.tableHeaderView?.height = rowHeight
            }
        }
    }

    var datas : Array<Any> = ["全部"] {
        didSet{
            self.tableView.reloadData()
        }
    }
    override var title: String?{
     
        didSet{
            
            titleLabel.text = title
        }
    }
    
    var subtitle: String?{
     
        didSet{
            
            if let _ = subtitle {
             
                subtitleLabel.text = subtitle
                self.headView.height = 90
            }
        }
    }
    
    lazy var headView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            
            make.left.right.top.equalToSuperview()
            make.height.equalTo(40)
        }
        view.addSubview(subtitleLabel)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = kGreyTextColor
        subtitleLabel.font = FONT_R(size: 12)
        subtitleLabel.snp.makeConstraints { make in

            make.left.equalToSuperview().offset(Margin_WIDTH)
            make.right.equalToSuperview().offset(-Margin_WIDTH)
            make.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        return view
    }()
    
    lazy var bottomView : UIView = {
        let bottomView = UIView()
        let cancelBtn = UIButton()
        cancelBtn.setTitle("取消".localString(), for: .normal)
        cancelBtn.setTitleColor(.hexColor("333333"), for: .normal)
        cancelBtn.titleLabel?.font = cellFont
        bottomView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            
            make.top.left.right.bottom.equalToSuperview()
        }
        cancelBtn.rx.tap.subscribe ({ [weak self] _ in
            guard let self = self else{return}
            self.dismiss()
        }).disposed(by: self.disposebag)

        return bottomView
    }()
    lazy var haderView : UIView = {
        let bottomView = UIView()
        let lineV = UIView()
        lineV.backgroundColor = .hexColor("#F5F5F5")
        bottomView.addSubview(lineV)
        lineV.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        let cancelBtn = UIButton()
        cancelBtn.setTitle("全部".localString(), for: .normal)
        cancelBtn.setTitleColor(kBlack3TextColor, for: .normal)
        cancelBtn.titleLabel?.font = cellFont
        cancelBtn.tag = 10000
        bottomView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            
            make.top.left.right.bottom.equalToSuperview()
        }
        cancelBtn.rx.tap.subscribe ({ [weak self] _ in
            guard let self = self else{return}
            self.didselect?(cancelBtn.tag)
            self.dismiss()
        }).disposed(by: self.disposebag)

        return bottomView
    }()
    

    func dismiss() {
        
        self.dismiss(animated: true)
    }
   
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.roundCorners([.topLeft, .topRight], radius: 15)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.rowHeight = rowHeight
        self.tableView.backgroundColor = .white
        self.tableView.separatorStyle = .none
        self.tableView.isScrollEnabled = false
        self.tableView.register(UINib(nibName: "MPBottomSheetCell", bundle: nil), forCellReuseIdentifier: "MPBottomSheetCell")
        self.tableView.insetsLayoutMarginsFromSafeArea = false
        titleLabel.textColor = kBlackTextColor
        titleLabel.font = FONT_SB(size: 14)
        titleLabel.textAlignment = .center
        
        if #available(iOS 11.0, *)  {
            self.tableView.contentInsetAdjustmentBehavior = .never
        }
        
        if #available(iOS 13.0, *) {
            self.tableView.automaticallyAdjustsScrollIndicatorInsets = false
        }
        ///ios15 分组悬停默认22高度改为0
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        }

        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.datas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MPBottomSheetCell", for: indexPath) as! MPBottomSheetCell
        
        let str = self.datas[indexPath.row] as? String
        cell.titleLabel.text = str?.localString()
        cell.titleLabel.font = cellFont
        cell.titleLabel.textColor = .hexColor("333333")
        if indexPath.row == selectIndex {
            cell.titleLabel.textColor = cellTextColor
        }
        
        if idsAry.isEmpty == false {
            cell.id = idsAry[indexPath.row]
        }
        
        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss()
        let myCell = tableView.cellForRow(at: indexPath) as? MPBottomSheetCell
        didSelectWithId?(myCell?.id ?? "")
        didselect?(indexPath.row)
    }
    
    func setRowTextColor(textColor:UIColor, Index:Int) {
        selectIndex = Index
        cellTextColor = textColor
    
    }
    
    func show(on VC : UIViewController){
        
        var configuration = NBBottomSheetConfiguration(sheetSize: .fixed(rowHeight * CGFloat(self.datas.count < 7 ? self.datas.count : 6)  +  (self.tableView.tableHeaderView?.height ?? 0) +  (self.tableView.tableFooterView?.height ?? 0) ))
        configuration.backgroundViewColor = UIColor.black.withAlphaComponent(0.5)
        configuration.animationDuration = 0.5
        
        if self.datas.count >= 6 {
            
            self.tableView.isScrollEnabled = true
        }
        let bottomSheetController = NBBottomSheetController(configuration: configuration)
        bottomSheetController.present(self, on: VC)
    }
    
    func show(on VC : UIViewController , with height : CGFloat){
        
        var configuration = NBBottomSheetConfiguration(sheetSize: .fixed(height + (self.tableView.tableFooterView?.height ?? 0)  + 20))
        configuration.backgroundViewColor = UIColor.black.withAlphaComponent(0.5)
        configuration.animationDuration = 0.5
        if self.datas.count >= 6 {
            
            self.tableView.isScrollEnabled = true
        }
        
        let bottomSheetController = NBBottomSheetController(configuration: configuration)
        bottomSheetController.present(self, on: VC)
    }

    func show(on VC : UIViewController , height : CGFloat){
        
        var configuration = NBBottomSheetConfiguration(sheetSize: .fixed(height))
        configuration.backgroundViewColor = UIColor.black.withAlphaComponent(0.5)
        configuration.animationDuration = 0.5
        if self.datas.count >= 6 {
            
            self.tableView.isScrollEnabled = true
        }
        
        let bottomSheetController = NBBottomSheetController(configuration: configuration)
        bottomSheetController.present(self, on: VC)
    }
}
