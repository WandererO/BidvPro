//
//  MPBaseCell.swift
//  MarketPlace
//
//  Created by tank on 6/4/23.
//

import UIKit

class MPBaseCell: UITableViewCell {

    let disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
