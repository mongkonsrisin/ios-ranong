//
//  ProductTableViewCell.swift
//  LoveRanong
//
//  Created by Lapp on 10/3/2561 BE.
//  Copyright © 2561 Ranong. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageViewPhoto: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelSubtitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
