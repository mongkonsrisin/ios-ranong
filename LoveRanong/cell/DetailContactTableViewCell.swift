//
//  DetailContactTableViewCell.swift
//  LoveRanong
//
//  Created by Lapp on 15/2/2561 BE.
//  Copyright © 2561 Ranong. All rights reserved.
//

import UIKit

class DetailContactTableViewCell: UITableViewCell {

    @IBOutlet weak var labelKey: UILabel!
    @IBOutlet weak var labelValue: UILabel!
    @IBOutlet weak var imageViewIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        labelValue.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
