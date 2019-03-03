//
//  MapViewController.swift
//  LoveRanong
//
//  Created by Lapp on 9/2/2561 BE.
//  Copyright © 2561 Lapp. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage

class MapViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var poiName:String = ""
    var poiLat = ""
    var poiLng = ""
    var poiPhoto = ""
    
   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        
        if(poiLat == "" || poiLng == "") {
            //ศาลหลักเมือง
            poiLat = "9.962533"
            poiLng = "98.640371"
        }
        
        
        let annotation = Annotation(coordinate: CLLocationCoordinate2DMake(Double(poiLat)!, Double(poiLng)!), title: poiName, subtitle: "", image: UIImage(named:"mock.png"))
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(poiLat)!, Double(poiLng)!)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
        mapView.showAnnotations([annotation], animated: true)
        mapView.selectAnnotation(annotation, animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Annotation
    func mapView(_ mapView: MKMapView,viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        let identifier = "POI"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            
        }
        
        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let v = annotation as! Annotation
        
        //leftIconView.image = v.image
        leftIconView.sd_setImage(with: URL(string: poiPhoto), placeholderImage: UIImage(named: "mock.png"))
        annotationView?.leftCalloutAccessoryView = leftIconView
        let calloutButton = UIButton(type: .detailDisclosure)
        annotationView?.rightCalloutAccessoryView = calloutButton
        return annotationView
        
    }
    
    
    
    //Annotation tapped
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let a = view.annotation as? Annotation
           
  
            //Navigate in Map
            let lat:CLLocationDegrees = Double(poiLat)!
            let lng:CLLocationDegrees = Double(poiLng)!
            
            let regionDistance:CLLocationDistance = 1000;
            let coordinates = CLLocationCoordinate2DMake(lat, lng)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
            
            let placemark = MKPlacemark(coordinate: coordinates)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = poiName
            mapItem.openInMaps(launchOptions: options)
            
        }
    }
    
    
    
    

    

}
