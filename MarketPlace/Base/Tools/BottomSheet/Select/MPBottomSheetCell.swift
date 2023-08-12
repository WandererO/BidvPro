//
//  MPBottomSheetCell.swift
//  MarketPlace
//
//  Created by mac on 2023/3/21.
//

import UIKit

class MPBottomSheetCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    var id = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
