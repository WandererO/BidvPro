//
//  MPCollectionSelectCell.swift
//  MarketPlace
//
//  Created by tank on 6/11/23.
//

import UIKit

class MPCollectionSelectCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.corner(cornerRadius: 4)
        // Initialization code
    }

    var isChoose : Bool {
        set {
            if newValue {
                self.contentView.backgroundColor =  kMainColor(alpha: 0.12)
                self.titleLabel.textColor = kMainColor
            }else{
                self.contentView.backgroundColor = .hexColor("#F4F5F7")
                self.titleLabel.textColor = kBlackTextColor
            }
        }get{
            return true
        }
    }
}
