//
//  PackagePoiTableViewCell.swift
//  LoveRanong
//
//  Created by Lapp on 23/2/2561 BE.
//  Copyright © 2561 Ranong. All rights reserved.
//

import UIKit

class PackagePoiTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewPhoto: UIImageView!
    
    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
