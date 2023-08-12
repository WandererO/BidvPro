//
//  Views.swift
//  MarketPlace
//
//  Created by mac on 2023/3/6.
//

import UIKit


class BaseView : UIView{
    let disposeBag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
     }
     required init?(coder: NSCoder) {
         super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension BaseView{
    func getIndexOf(datas:[String] , string:String?) -> Int{
        if let string , let index =  datas.firstIndex(of: string) {
            return index
        }else{
            return -1
        }
    }

}


class LineView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = kLineColor
     }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class LabelView :UIView {
    
    var margin :CGFloat = 6{
        didSet{
            label.snp.updateConstraints { make in
                make.left.equalTo(margin)
                make.right.equalTo(-margin)
            }
        }
    }
    var font : UIFont {
        set{
            label.font = newValue
        }
        get{
            label.font
        }
    }
       
    var text : String? {
        set{
            label.text = newValue
        }
        get{
            label.text
        }
    }

    var textColor : UIColor {
        set{
            label.textColor = newValue
        }
        get{
            label.textColor
        }
    }
    
    private let label : UILabel = {
        let label = UILabel()
        label.font = FONT_R(size: 12)
        label.textColor = kBlack3TextColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.corner(cornerRadius: 4)
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
            make.center.equalToSuperview()
        }
        self.backgroundColor = kLineColor
     }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setUI(){
        
        self.corner(cornerRadius: 4)
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(margin)
            make.right.equalTo(-margin)
            make.center.equalToSuperview()
        }
        self.backgroundColor = kLineColor
        
    }
}
