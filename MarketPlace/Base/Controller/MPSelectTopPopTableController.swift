//
//  MPSelectTopPopTableController.swift
//  MarketPlace
//
//  Created by mac on 2023/6/11.
//

import UIKit

class MPSelectTopPopTableController: UITableViewController {
    
    let disposeBag = DisposeBag()
    var selectIndex = -1
    var cellFont : UIFont = FONT_M(size: 14)
    var rowHeight : CGFloat = 56
    var cellSelectColor : UIColor? = kMainColor
    
    var didSelectRowIndex : SelectBlock?
    
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
        cancelBtn.setTitle("全部", for: .normal)
        cancelBtn.setTitleColor(.hexColor("333333"), for: .normal)
        cancelBtn.titleLabel?.font = cellFont
        cancelBtn.tag = 10000
        bottomView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            
            make.top.left.right.bottom.equalToSuperview()
        }
        cancelBtn.rx.tap.subscribe ({ [weak self] _ in
            guard let self = self else{return}
//            self.didselect?(cancelBtn.tag)
//            self.dismiss()
        }).disposed(by: self.disposeBag)

        return bottomView
    }()
    
    func dismiss() {
        
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = rowHeight
        self.tableView.backgroundColor = .white
        self.tableView.separatorStyle = .none
        self.tableView.isScrollEnabled = false
        self.tableView.register(UINib(nibName: "MPBottomSheetCell", bundle: nil), forCellReuseIdentifier: "MPBottomSheetCell")
        self.tableView.insetsLayoutMarginsFromSafeArea = false
        
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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.datas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MPBottomSheetCell", for: indexPath) as! MPBottomSheetCell
        
        let str = self.datas[indexPath.row] as? String
        cell.titleLabel.text = str
        cell.titleLabel.font = cellFont
        cell.titleLabel.textColor = .hexColor("333333")
        cell.titleLabel.textAlignment = .left
        if indexPath.row == selectIndex {
            cell.titleLabel.textColor = cellSelectColor
        }
        
//        if idsAry.isEmpty == false {
//            cell.id = idsAry[indexPath.row]
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss()
        let myCell = tableView.cellForRow(at: indexPath) as? MPBottomSheetCell
        didSelectRowIndex?(indexPath.row)
    }
    
    func setRowTextColor(textColor:UIColor, Index:Int) {
        selectIndex = Index
        cellSelectColor = textColor
    }

}
