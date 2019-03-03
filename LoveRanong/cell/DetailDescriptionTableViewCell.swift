//
//  DetailDescriptionTableViewCell.swift
//  LoveRanong
//
//  Created by Lapp on 14/2/2561 BE.
//  Copyright © 2561 Ranong. All rights reserved.
//

import UIKit

class DetailDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var labelDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelDescription.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
