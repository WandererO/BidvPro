//
//  MPSelectTopTableView.swift
//  MarketPlace
//
//  Created by mac on 2023/6/11.
//

import UIKit
enum dataType {
case coinList
}

class MPSelectTopTableView: UIView {
    let disposeBag = DisposeBag()
    
    
    
    var selectIndex = -1
    var cellFont : UIFont = FONT_M(size: 14)
    var rowHeight : CGFloat = 56
    var cellSelectColor : UIColor? = kMainColor
    //Y轴
    var marginY:CGFloat = 0 {
        didSet {
            self.frame = CGRect(x: 0, y: marginY, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - marginY)
        }
    }
    
    var didSelectRowIndex : SelectBlock?
    var didmissBlock: NormalBlock?
    
    var isShowHeader : Bool  = false {
        
        didSet{
            if isShowHeader{
             
                self.tableView.tableHeaderView = haderView
                self.tableView.tableHeaderView?.height = rowHeight
            }
        }
    }
    
    var headerTitle : String = "" {
        didSet{
//            self.datas.insert(headerTitle, at: 0)
//            self.tableView.reloadData()
        }
    }
    
    var datas : Array<Any> = ["全部"] {
        didSet{

            if headerTitle.isEmpty == false{
                datas.insert(headerTitle, at: 0)
            }
            
            let height = datas.count * Int(rowHeight)
            let maxHeight = SCREEN_HEIGHT/2 - marginY
            var resultHeight = height
            if height > Int(maxHeight) {
                resultHeight = Int(maxHeight)
            }
            self.tableView.snp.remakeConstraints { make in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(resultHeight)
            }
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
        lazy var cancelBtn = UIButton()
        cancelBtn.setTitle(headerTitle, for: .normal)
        cancelBtn.setTitleColor(.hexColor("333333"), for: .normal)
        cancelBtn.titleLabel?.font = cellFont
        cancelBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        cancelBtn.contentHorizontalAlignment = .left
        cancelBtn.tag = 10000
        bottomView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            
            make.top.left.right.bottom.equalToSuperview()
        }
        cancelBtn.rx.tap.subscribe ({ [weak self] _ in
            guard let self = self else{return}
//            self.didselect?(cancelBtn.tag)
            self.didSelectRowIndex?(cancelBtn.tag)
            self.dismiss()
        }).disposed(by: self.disposeBag)

        return bottomView
    }()
    
    lazy var tableView : BaseTableView = {
        
        let table = BaseTableView(frame: CGRect.zero, style: .plain)
        table.backgroundColor = .hexColor("FFFFFF")
        table.showsVerticalScrollIndicator = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(UINib(nibName: "MPBottomSheetCell", bundle: nil), forCellReuseIdentifier: "MPBottomSheetCell")
        table.autoresizingMask  = .flexibleHeight
        return table
    }()
    
    func show() {
        UIApplication.shared.delegate?.window??.addSubview(self)
    }
    
    func dismiss() {
        self.removeFromSuperview()
        self.didmissBlock?()
    }
    
    func setBackGroundFrame(frame:CGRect) {
        self.frame = frame
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: marginY, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - marginY))
        self.backgroundColor = .hexColor("000000", alpha: 0.3)
        
        self.addSubview(tableView)
        
//        let height = datas.count * Int(rowHeight)
        
        tableView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
//            make.height.equalTo(100)
        }
        
//        self.isUserInteractionEnabled = true
//        self.addTapForView().subscribe { [weak self] _ in
//            guard let self = self else{return}
//            self.dismiss()
//        }.disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension MPSelectTopTableView : UITableViewDataSource , UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MPBottomSheetCell", for: indexPath) as! MPBottomSheetCell
        
        let str = self.datas[indexPath.row] as? String
        cell.titleLabel.text = str
        cell.titleLabel.font = cellFont
        cell.titleLabel.textColor = .hexColor("333333")
        cell.titleLabel.textAlignment = .left
        if indexPath.row == selectIndex {
            cell.titleLabel.textColor = cellSelectColor
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss()
        let myCell = tableView.cellForRow(at: indexPath) as? MPBottomSheetCell
        didSelectRowIndex?(indexPath.row)
        
        setRowTextColor(textColor: kMainColor, Index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let myCell = tableView.cellForRow(at: indexPath) as? MPBottomSheetCell
        
    }
    
    func setRowTextColor(textColor:UIColor, Index:Int) {
        selectIndex = Index
        cellSelectColor = textColor
        self.tableView.reloadData()
    }

}
