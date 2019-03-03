//
//  PoiItemCollectionDao.swift
//  LoveRanong
//
//  Created by Lapp on 10/2/2561 BE.
//  Copyright © 2561 Lapp. All rights reserved.
//

import Foundation

class PoiItemCollectionDao {
    
    var success: Bool
    var data: [PoiListItemDao]
    
    init(success:Bool,data:[PoiListItemDao]) {
       self.success = success
        self.data = data
    }
}
