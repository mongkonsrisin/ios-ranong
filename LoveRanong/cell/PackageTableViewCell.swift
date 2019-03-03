//
//  PackageTableViewCell.swift
//  LoveRanong
//
//  Created by Lapp on 23/2/2561 BE.
//  Copyright © 2561 Ranong. All rights reserved.
//

import UIKit

class PackageTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewPackage: UIImageView!
    
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
