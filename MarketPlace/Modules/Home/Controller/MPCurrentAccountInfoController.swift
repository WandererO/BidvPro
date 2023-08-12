//
//  MPCurrentAccountInfoController.swift
//  MarketPlace
//
//  Created by mac on 2023/8/6.
//

import UIKit

class MPCurrentAccountInfoController: BaseHiddenNaviController {
    @IBOutlet weak var tkttLab: UILabel!
    @IBOutlet weak var accountLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var availableLab: UILabel!
    @IBOutlet weak var amountLab: UILabel!
    @IBOutlet weak var currentLab: UILabel!
    
    @IBOutlet weak var recentView: UIView!
    @IBOutlet weak var infoBgView: UIView!
    
    @IBOutlet weak var transferLab: UILabel!
    @IBOutlet weak var savingLab: UILabel!
    @IBOutlet weak var paymentLab: UILabel!
    @IBOutlet weak var cashLab: UILabel!
    @IBOutlet weak var recentLab: UIButton!
    @IBOutlet weak var viewAllBtn: UIButton!
    
    
    let viewModel = MPPublicViewModel()
    
    lazy var tableView : BaseTableView = {
        
        let table = BaseTableView(frame: CGRect.zero, style: .grouped)
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .clear
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.estimatedRowHeight = 170
        table.register(UINib(nibName: "MPTranstionCell", bundle: nil), forCellReuseIdentifier: "MPTranstionCell")
        table.autoresizingMask  = .flexibleHeight
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Current account(s)".localString()
        self.view.backgroundColor = RGBCOLOR(r: 243, g: 246, b: 248)
        // Do any additional setup after loading the view.
        self.infoBgView.clipsToBounds = false
        self.infoBgView.setShadow(width: 0, bColor: kLineColor, sColor: kBlackTextColor, offset: CGSize(width: 0, height: 6), opacity: 0.1, radius: 8)
        self.infoBgView.layer.shadowRadius = 14
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(recentView.snp.bottom)
        }
        
        reuestData()
        
        let amount = Archive.getDefaultsForKey(key: "money").getShowPrice()
        let account = Archive.getDefaultsForKey(key: "account")
        let name = Archive.getDefaultsForKey(key: "nickName")
        
        tkttLab.text = "TKTT FIRST KHTN (CN) VND".localString()
        accountLab.text = account
        nameLab.text = name
        nameLab.font = FONT_HN(size: 14)
        availableLab.text = "Available balance".localString()
        amountLab.text = amount
        amountLab.font = FONT_Cus(size: 20)
        
        currentLab.text = "Current balance: ".localString() + amount + " VND"
        currentLab.font = FONT_HN(size: 14)
        
        recentLab.setTitle("Recent transaction(s)".localString(), for: .normal)
        transferLab.text = "Transfer".localString()
        savingLab.text = "Saving".localString()
        paymentLab.text = "Payment".localString()
        cashLab.text = "Cash".localString()
        viewAllBtn.setTitle("View all".localString(), for: .normal)
        
    }
    
    func reuestData() {
        viewModel.requestTransferRecord(token: "", type: "0", startTime: "", endTime: "").subscribe(onNext: {[weak self] _ in
            guard let self = self else {return}
            
            self.tableView.reloadData()
            
        }).disposed(by: disposeBag)
    }

    @IBAction func allClick(_ sender: Any) {
        
        let vc = MPTransferHistoryController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MPCurrentAccountInfoController : UITableViewDataSource , UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.recordeModel.count > 3 {
            return 3
        }else{
            return viewModel.recordeModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MPTranstionCell", for: indexPath) as! MPTranstionCell
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
