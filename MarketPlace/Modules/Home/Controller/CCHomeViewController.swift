//
//  CCHomeViewController.swift
//  MarketPlace
//
//  Created by XXX on 6/8/22.
//

import UIKit
import RxSwift
import SafariServices
 



class CCHomeViewController : BaseHiddenNaviController{
    
    
    let dataSource = [
        
        [["text":"Smart Kids".localString(),"img":"icSmartKids_Normal"],
         ["text":"Elite account opening".localString(),"img":"icTaiKhoanDinhDanh_Normal"],
         ["text":"Taxi booking".localString(),"img":"ic48PxMainGoiTaxi_Normal"],
         ["text":"Interbank transfer to account".localString(),"img":"pack_chuyen_tien_48px_Normal"],
         ["text":"Topup".localString(),"img":"pack_naptiendt_48px_Normal"],
         ["text":"Open Online savings".localString(),"img":"pack_tiet_kiem_48px_Normal"],
         ["text":"Deposit on online cumulative accounts".localString(),"img":"icMainThanhToanGuiTichLuyOnline_Normal"],
         ["text":"Ouick loan/Quick card".localString(),"img":"pack_tien_vay_48px_Normal"],
         ["text":"BSMS registration".localString(),"img":"pack_ott_48px_Normal"]],
                       
                       
                       [["text":"Electricity bill","img":"icTienDienHome_Normal"],
                        ["text":"Water bill","img":"icTienNuocHome_Normal"],
                        ["text":"Telecom bill","img":"icMainVienThongHome_Normal"],
                        ["text":"Cable TV bill","img":"icTruyenHinhHome_Normal"],
                        ["text":"Securities","img":"icNapTienChungKhoanHome_Normal"],
                        ["text":"View more","img":"icXemThemHome_Normal"]
                      ],
                        
                       
                       
                        [["text":"Taxi","img":"ic48PxMainGoiTaxi_Normal"],
                         ["text":"Airline ticket","img":"icoRewardVemaybay_Normal"],
                         ["text":"Book bus ticket","img":"packSDKVeXe_Normal"],
                         ["text":"VnShop","img":"packSDKVNSHOP_Normal"],
                         ["text":"Book train ticket","img":"packSDKVeTau_Normal"],
                         ["text":"View more","img":"pack_ott_48px_Normal"]],
                         
                      
                        
                   ]
    
    let itemWidth : CGFloat =  CGFloat(SCREEN_WIDTH - 4*20 - 20)/5
    
    let tableHeader = MPTableVIewHeadView.fromNib()
    
    lazy var tableView : BaseTableView = {
        let table = BaseTableView(frame: CGRect.zero, style: .grouped)
        tableHeader.backgroundColor = .white
        table.tableHeaderView = tableHeader
        table.showsVerticalScrollIndicator = false
        //tableView 背景色 //UIColor(17, 34, 42, 0).withAlphaComponent(0.8)
        table.backgroundColor = .white
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.separatorColor = .clear
        table.register(UINib(nibName: "MPHomeCell", bundle: nil), forCellReuseIdentifier: "MPHomeCell")
//        table.autoresizingMask  = .flexibleHeight
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
        return table
    }()
    
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
            
           reloadHeaderView()
           
      }
    
    func reloadHeaderView(){
        if let header = tableView.tableHeaderView {
            /// 前提是xib中设置好约束  设置tableView.tableHeaderView高度
            let height = tableView.tableHeaderView?.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height ?? 200
            
            var frame = tableView.tableHeaderView?.frame
            frame?.size.height = height + 80
            print(height)
            
            tableView.tableHeaderView?.frame = frame!
            tableView.tableHeaderView = header
        }
    }
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.headerView.isHidden = true
        
        setUI()
    }
    
    
    
    func setUI(){
        
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.bottom.right.top.equalToSuperview()
        }
        
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    
    
}


extension CCHomeViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //需要动态返回高度，根据数组里面的count 计算有几行 * 高度
        let arr = dataSource[indexPath.section]
        let itemHeight : CGFloat = (SCREEN_WIDTH/3)
        let columnCount = Int(ceilf(Float(arr.count) * 1.0 / 3))
        let allHeight  = CGFloat(columnCount) * itemHeight
        print(allHeight)
        return indexPath.section ==  9 ? 120 + allHeight: allHeight
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "MPHomeCell", for: indexPath) as! MPHomeCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.dataSource = self.dataSource[indexPath.section]
        
        
        //模拟banner显示
        cell.topImageBanner.isHidden = indexPath.section != 9
        cell.bannerHieght.constant = indexPath.section == 9 ? 100 : 0
        cell.topImageBanner.image = UIImage(named: "7_Normal")
        cell.topImageBanner.IB_cornerRadius = 10
        
         return cell
  
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        
        let setionView = MPHomeSectionView.fromNib()
        setionView.bottomV.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        setionView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 30)
        
        let titleArray = ["Favourite services".localString(),
                          "Payment services".localString(),
                          "Shopping".localString()]
        setionView.titleName.text = titleArray[section]
        
        setionView.rightBtn.isHidden = section > 0
        
        return setionView
    }
     
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 30
    }
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView{
            let y = scrollView.contentOffset.y
//            self.menuToolView.isHidden = y < 180
        }
    }
    
}




