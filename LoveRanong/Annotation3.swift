//
//  Annotation.swift
//  LoveRanong
//
//  Created by Lapp on 10/2/2561 BE.
//  Copyright © 2561 Lapp. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Annotation3: NSObject,MKAnnotation {
    var coordinate : CLLocationCoordinate2D
    var title:String?
    var subtitle:String?
    var image:UIImage?
    var url:String?
    var pin:String?
    var id:Int?
    
    
    init(coordinate:CLLocationCoordinate2D, title:String, subtitle:String, image:UIImage?,url:String?,pin:String?,id:Int?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.url = url
        self.pin = pin
        self.id = id
    }
    
    
    
}


