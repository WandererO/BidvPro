//
//  MPHomeOtherServicesCell.swift
//  MarketPlace
//
//  Created by mac on 2023/8/6.
//

import UIKit

class MPHomeOtherServicesCell: UICollectionViewCell {
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .white
        self.corner(cornerRadius: 10)
        
        titleLab.text = "Financial package of Vietnamese family".localString()
        contentLab.text = "Promotions for the whole family".localString()
        
//        self.clipsToBounds = false
//        self.setShadow(width: 0, bColor: kLineColor, sColor: kBlackTextColor, offset: CGSize(width: 0, height: 3), opacity: 0.1, radius: 8)
//        self.layer.shadowRadius = 14
    }

}
