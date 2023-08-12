//
//  MPTransferHistoryController.swift
//  MarketPlace
//
//  Created by mac on 2023/8/7.
//

import UIKit

class MPTransferHistoryController: BaseHiddenNaviController {
    
    let viewModel = MPPublicViewModel()
    
    lazy var tableView : BaseTableView = {
        
        let table = BaseTableView(frame: CGRect.zero, style: .grouped)
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .clear
        table.dataSource = self
        table.delegate = self
        table.estimatedRowHeight = 170
        table.separatorStyle = .none
        table.register(UINib(nibName: "MPTranstionCell", bundle: nil), forCellReuseIdentifier: "MPTranstionCell")
        table.autoresizingMask  = .flexibleHeight
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Transaction history".localString()
        self.view.backgroundColor = RGBCOLOR(r: 243, g: 246, b: 248)
        topViewRightBtn.setImage(UIImage(named: "filter"), for: .normal)
        
        setUI()
        reuestData()
    }
    
    func setUI(){
        let headerV = MPHistoryHeaderView()
        view.addSubview(headerV)
        headerV.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(95)
            make.top.equalTo(TOP_HEIGHT)
        }
        
        let tipLab = UILabel()
        tipLab.text = "Last 20 transactions".localString()
        tipLab.textColor = kBlackTextColor
        tipLab.font = FONT_R(size: 14)
        self.view.addSubview(tipLab)
        tipLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerV.snp.bottom).offset(15)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(tipLab.snp.bottom).offset(15)
        }
    }
    
    func reuestData() {
        viewModel.requestTransferRecord(token: "", type: "0", startTime: "", endTime: "").subscribe(onNext: {[weak self] _ in
            guard let self = self else {return}
            
            self.tableView.reloadData()
            
        }).disposed(by: disposeBag)
    }

}

extension MPTransferHistoryController : UITableViewDataSource , UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.recordeModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = viewModel.recordeModel[section]
        return sectionModel.list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MPTranstionCell", for: indexPath) as! MPTranstionCell
//        cell.corner(cornerRadius: 6)
        let sectionModel = viewModel.recordeModel[indexPath.section]
        cell.selectionStyle = .none
        cell.model = sectionModel.list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionV = UIView()
        sectionV.backgroundColor = RGBCOLOR(r: 246, g: 247, b: 250)
        
        let timeLab = UILabel()
        timeLab.text  = viewModel.recordeModel[section].date
        timeLab.textColor = kBlackTextColor
        timeLab.font = FONT_M(size: 16)
        sectionV.addSubview(timeLab)
        timeLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
        
        return sectionV
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

    }
    

}
