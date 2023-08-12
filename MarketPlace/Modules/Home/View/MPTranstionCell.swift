//
//  MPTranstionCell.swift
//  MarketPlace
//
//  Created by mac on 2023/8/6.
//

import UIKit

class MPTranstionCell: UITableViewCell {
    
    var model = ListModel() {
        didSet{
            nameLab.text = model.receivername
            contentLab.text = model.content
            
            amountLab.font = FONT_HN(size: 18)
            
            if model.type == "1" {//转入
                moreImage.isHidden = true
                contentRightConstraint.constant = 30
                amountLab.text = "+" + model.amount.getShowPrice()
                amountLab.textColor = RGBCOLOR(r: 71, g: 172, b: 227)
            }else {
                moreImage.isHidden = false
                contentRightConstraint.constant = 15
                amountLab.text = "-" + model.amount.getShowPrice()
                amountLab.textColor = RGBCOLOR(r: 31, g: 61, b: 145)
            }
            
            if model.receivername.isEmpty == true {
                receiverLab.isHidden = true
                nameLab.isHidden = true
                contentTopConstraint.constant = 15
            }else{
                receiverLab.isHidden = false
                nameLab.isHidden = false
                contentTopConstraint.constant = 39
            }
            
            timeLab.text = model.time
            timeLab.textColor = RGBCOLOR(r: 51, g: 59, b: 65)
        }
    }

    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var amountLab: UILabel!
    @IBOutlet weak var receiverLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var moreImage: UIImageView!
    @IBOutlet weak var contentTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentRightConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
