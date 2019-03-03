//
//  PoiItemTableViewCell.swift
//  LoveRanong
//
//  Created by Lapp on 8/2/2561 BE.
//  Copyright © 2561 Lapp. All rights reserved.
//

import UIKit

class PoiItemTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var labelTime: UILabel!
    
    @IBOutlet weak var labelPhone: UILabel!
    
    
    //@IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var imageViewPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelTitle.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 

}
