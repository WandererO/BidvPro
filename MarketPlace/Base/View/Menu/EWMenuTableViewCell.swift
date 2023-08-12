//
//  EWMenuTableViewCell.swift
//  coiuntrade-ios
//
//  Created by Chamcha on 2022/5/5.
//

import UIKit

/// imageView左侧留白
let kLineXY: CGFloat = 10
/// imageView宽度
let kImageWidth: CGFloat = 20
/// imageView与label之间留白
let kImgLabelWidth: CGFloat = 8.0

class EWMenuTableViewCell: UITableViewCell {
    static let identifier = "EWMenuTableViewCell"

    private lazy var iconImg: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: kLineXY, y: (itemHeight - kImageWidth)/2, width: kImageWidth, height: kImageWidth))
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    public lazy var conLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 42, y: 0, width: itemWidth - 57, height: itemHeight))
        label.textColor = kBlackTextColor
        label.font = FONT_R(size: 16)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var checkImg: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: kLineXY, y: (itemHeight - kImageWidth)/2, width: kImageWidth, height: kImageWidth))
        imageView.backgroundColor = UIColor.clear
        imageView.image = UIImage(named: "c2c_check")
        imageView.isHidden = true
        return imageView
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        drawMyView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawMyView() {
        self.addSubview(iconImg)
        self.addSubview(conLabel)
        self.addSubview(checkImg)
    }
    public func setContentBy(titArray: [String], imgArray: [String], row: Int) {
        if imgArray.isEmpty {
            self.iconImg.isHidden = true
            self.conLabel.snp.makeConstraints { make in
                
                make.left.equalTo(kLineXY)
                make.top.right.bottom.equalToSuperview()
                make.right.equalToSuperview().offset(-kLineXY)
            }

        } else {
            self.iconImg.isHidden = false
            
            self.conLabel.snp.makeConstraints { make in
                
                make.left.equalTo(self.iconImg.snp.right).offset(kImgLabelWidth)
                make.top.right.bottom.equalToSuperview()
            }
            self.iconImg.image = UIImage(named: imgArray[row]) //?.withTintColor(kGreyTextColor)
        }
        
        self.checkImg.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
    }
}
