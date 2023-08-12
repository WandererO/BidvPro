//
//  MPSelectPopView.swift
//  MarketPlace
//
//  Created by mac on 2023/4/25.
//

import UIKit

class MPSelectPopView: UIView {
    let disposeBag = DisposeBag()
    
    let contentView = UIView()
    
    var payment : String = "全部"
    
    var titleData :[String] = []
    
    var dismissClick : NormalBlock?
    
    var selectIdx = -1
    
//    var selectBlock : ((_ index : IndexPath )->())?
    
    var selectBlock : SelectBlock?
    
    override init(frame: CGRect) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        //        self.backgroundColor = .hexColor("000000",alpha: 0.15)
        self.backgroundColor = .clear
        
        self.addSubview(contentView)
        contentView.backgroundColor = .white
        contentView.snp.makeConstraints { make in
            
            make.height.equalTo(349)
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(48 + STATUSBAR_HIGH)
        }
        let backView = UIView()
        backView.backgroundColor = .hexColor("000000",alpha: 0.15)
        self.addSubview(backView)
        backView.snp.makeConstraints { make in
            
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(contentView.snp.bottom)
        }
        
        backView.addTapForView().subscribe { [weak self] _ in
            guard let self = self else{return}
            self.dismiss()
        }.disposed(by: disposeBag)
        
        let topView = UIView()
        contentView.addSubview(topView)
        topView.snp.makeConstraints { make in
            
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    func popToRoot(AnyView:UIView) {
        
        let window = UIApplication.shared.delegate?.window
        if let window , let realWindow = window {
            
//            var btnAry:[UIButton] = []
            var lastBtn = UIButton()
            let rect = AnyView.convert(AnyView.bounds , to: realWindow)
            let contentHeight = 50 * titleData.count
            contentView.snp.remakeConstraints{ make in
                
                make.height.equalTo(contentHeight)
                make.left.right.equalToSuperview()
                make.top.equalToSuperview().offset(rect.origin.y + rect.size.height)
            }
            
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.spacing = 0
            stackView.distribution = .fillEqually
            contentView.addSubview(stackView)
            
//            let titles = ["全部","银行卡","支付宝","微信"]
            var i = 0
            for title in titleData{
                let btn = UIButton()
                btn.tag = i
//                btnAry.append(btn)
                btn.contentHorizontalAlignment = .left
                btn.setTitle(title, for: .normal)
                btn.titleLabel?.font = FONT_M(size: 14)
//                btn.setTitleColor(kMainColor, for: .selected)
                btn.setTitleColor(kBlack3TextColor, for: .normal)
                btn.addBottomLine()
                if btn.tag == selectIdx {
                    btn.setTitleColor(kMainColor, for: .normal)
                    btn.isSelected = true
                    lastBtn.isSelected = false
                    lastBtn.setTitleColor(kBlack3TextColor, for: .normal)
                    btn.setTitleColor(kMainColor, for: .normal)
                    lastBtn = btn
                }
                stackView.addArrangedSubview(btn)
                btn.rx.tap.subscribe(onNext: { [weak self] in
                    guard let self = self else {return}
                    let tag = btn.tag
                    btn.isSelected = true
                    lastBtn.isSelected = false
                    lastBtn.setTitleColor(kBlack3TextColor, for: .normal)
                    btn.setTitleColor(kMainColor, for: .normal)
                    lastBtn = btn
                    
                    self.selectBlock?(tag)
                    self.payment = self.titleData[tag]
                    self.dismiss()
                }).disposed(by: self.disposeBag)
                i += 1
                btn.isSelected = payment == title
            }
//            let contentHeight = 50 * titleData.count
//            contentView.snp.remakeConstraints{ make in
//
//                make.height.equalTo(contentHeight)
//                make.left.right.equalToSuperview()
//                make.top.equalToSuperview().offset(rect.origin.y + rect.size.height)
//            }
            stackView.snp.makeConstraints { make in
                make.left.equalTo(Margin_WIDTH)
                make.right.equalTo(-Margin_WIDTH)
                make.top.bottom.equalToSuperview()
            }
        }
        self.show()
    }
    
    
    func show() {
        UIApplication.shared.delegate?.window??.addSubview(self)
    }
    
    func dismiss(){
        self.dismissClick?()
        self.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class MPCollectionSelectPopView: UIView {
        
    let disposeBag = DisposeBag()
    let contentView = UIView()
    var selectBlock : ((_ index : IndexPath )->())?
    var selectMainBlock : ((_ select : [String] )->())?
    var selectSubBlock : ((_ select : [String] )->())?
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        self.backgroundColor = .clear
        
        self.addSubview(contentView)
        contentView.backgroundColor = kMainBackgroundColor
        contentView.snp.makeConstraints { make in
            
            make.height.equalTo(349)
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(48 + STATUSBAR_HIGH)
        }
        
        let topBackView = UIView()
        self.addSubview(topBackView)
        topBackView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(contentView.snp.top)
        }
        let bottomBackView = UIView()
        bottomBackView.backgroundColor = .hexColor("000000",alpha: 0.15)
        self.addSubview(bottomBackView)
        bottomBackView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(contentView.snp.bottom)
        }
        topBackView.addTapForView().subscribe { [weak self] _ in
            self?.dismiss()
        }.disposed(by: disposeBag)
        bottomBackView.addTapForView().subscribe { [weak self] _ in
            self?.dismiss()
        }.disposed(by: disposeBag)
                                
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        // 列间距
        layout.minimumLineSpacing = 8
        // 行间距
        layout.minimumInteritemSpacing = 10
        // 设置item的四边边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // 设置背景颜色
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = kMainBackgroundColor
        contentView.addSubview(collectionView)
        collectionView.register(UINib(nibName: "MPCollectionSelectCell", bundle: nil), forCellWithReuseIdentifier: "MPCollectionSelectCell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        collectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(10)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func dismiss(){
        self.removeFromSuperview()
    }
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    var collectionDatas : Array<String>?
    var collectionSectionDatas : Array<[String:Any]>?

    var selectTopCollectionIndex : Int =  -1
    var selectMainCollection : [String] = []{
        didSet{
            selectMainBlock?(selectMainCollection)
            collectionView.reloadData()
        }
    }
    var selectSubCollection : [String] = []{
        didSet{
            selectSubBlock?(selectSubCollection)
            collectionView.reloadData()
        }
    }

    func popToRoot(AnyView:UIView) {
        
        let window = UIApplication.shared.delegate?.window
        var height : CGFloat = 0
        if let window , let realWindow = window {
            
            if let collectionDatas {
                let isggh = ((collectionDatas.count % 4) == 0)
                let numbers = collectionDatas.count / 4 + (isggh ? 0 : 1)
                height += CGFloat(35 * numbers + 15)
            }else if let collectionSectionDatas{
                
                height += CGFloat(collectionSectionDatas.count * 38)
                for dict in collectionSectionDatas {
                    if let arr = dict["value"] as? [String] {

                        let isggh = ((arr.count % 4) == 0)
                        let numbers = arr.count / 4 + (isggh ? 0 : 1)
                         height += CGFloat(35 * numbers)
                    }
                }
            }
            let rect = AnyView.convert(AnyView.bounds , to: realWindow)
            contentView.snp.remakeConstraints{ make in
                
                make.height.equalTo(height)
                make.left.right.equalToSuperview()
                make.top.equalToSuperview().offset(rect.origin.y + rect.size.height)
            }
        }
        self.show()
    }
    func show() {
        UIApplication.shared.delegate?.window??.addSubview(self)
    }
}

extension MPCollectionSelectPopView : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
            
            if let collectionSectionDatas,let title = collectionSectionDatas[indexPath.section]["key"] as? String{
                headerView.label.text = title
            }

            return headerView
        }
        return UICollectionReusableView()
    }
    
    
    // 返回追加视图尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionSectionDatas != nil {
            return CGSize(width: collectionView.frame.size.width, height: 38)
        }
        return CGSize(width: collectionView.frame.size.width, height: 0)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let collectionSectionDatas {
            return collectionSectionDatas.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let collectionDatas {
            return collectionDatas.count
        }else if let collectionSectionDatas{
            
            let dict = collectionSectionDatas[section]
            if let arr = dict["value"] as? [String] {
                return arr.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MPCollectionSelectCell", for: indexPath) as! MPCollectionSelectCell
        
        if let collectionDatas {

            let str = collectionDatas[indexPath.row]
            cell.titleLabel.text = str
            cell.isChoose = selectTopCollectionIndex == indexPath.row

        }else if let collectionSectionDatas{
            let dict = collectionSectionDatas[indexPath.section]
            if let arr = dict["value"] as? [String] {
                let str = arr[indexPath.row]
                cell.titleLabel.text = str
                if indexPath.section == 0{
                    cell.isChoose = selectMainCollection.contains(str)
                }else{
                    cell.isChoose = selectSubCollection.contains(str)
                }
            }
        }        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30 - 24) / 4
        return CGSize(width: width, height: 25 )
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let collectionSectionDatas{
            let dict = collectionSectionDatas[indexPath.section]
            if let arr = dict["value"] as? [String] {
                let str = arr[indexPath.row]
                
                if indexPath.section == 0 {
                    if selectMainCollection.count == 0 {
                        
                        selectMainCollection.append(str)
                    }else{
                        if let index = selectMainCollection.firstIndex(of: str)  {
                            selectMainCollection.remove(at: index)
                        }else{
                            selectMainCollection.removeAll()
                            selectMainCollection.append(str)
                        }
                    }
                }else{
                    if selectSubCollection.count == 0 {
                        
                        selectSubCollection.append(str)
                    }else{
                        if let index = selectSubCollection.firstIndex(of: str)  {
                            selectSubCollection.remove(at: index)
                        }else{
                            selectSubCollection.removeAll()
                            selectSubCollection.append(str)
                        }
                    }
                }

            }
        }else{
            selectBlock?(indexPath)
        }
        self.dismiss()
    }
}
private class HeaderView: UICollectionReusableView {
        
    let label: UILabel = {
        let label = UILabel()
        label.font = FONT_M(size: 12)
        label.textColor = kBlack3TextColor
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



