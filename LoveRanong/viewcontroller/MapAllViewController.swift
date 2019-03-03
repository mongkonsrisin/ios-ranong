//
//  MapAllViewController.swift
//  LoveRanong
//
//  Created by Lapp on 13/3/2561 BE.
//  Copyright © 2561 Ranong. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class MapAllViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var poiCat:Int = 0
    var poiPin = ""
    var poiId:Int = 0
    var poiUrl:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        
        
        
       
        
        let parameters: Parameters=["poicatid":poiCat]
        
        let url = Http.getUrl() + "poi_location.php"
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON
            {
                response in
        
        if let result = response.result.value {
            
            let jsonData = result as! NSDictionary
            let poiObj = jsonData.value(forKey: "data") as! NSArray
            
            print(poiObj)
            for  pois in poiObj {
                
                let poi = pois as! NSDictionary
                
                let id = poi.value(forKey: "poi_id") as! Int

                let lat = poi.value(forKey: "lat") as! Double
                let lng = poi.value(forKey: "lng") as! Double
                let name = poi.value(forKey: "poi_name") as! String
                let photo = poi.value(forKey: "poi_photo") as! String
                self.poiPin = poi.value(forKey: "pin") as! String
                let myAnno = Annotation3(coordinate: CLLocationCoordinate2DMake(lat, lng), title: name, subtitle: "", image: UIImage(named:"mock.png"),url:photo,pin:self.poiPin,id:id)
            self.mapView.showAnnotations([myAnno], animated: false)
            }
            let span:MKCoordinateSpan = MKCoordinateSpanMake(1, 1)
            
            let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(9.962533, 98.640371)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
            self.mapView.setRegion(region, animated: true)
            
            
                }
        
        
        }
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func mapView(_ mapView: MKMapView,viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        let identifier = "MyPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if (annotation is MKUserLocation) {
            return nil
        }
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            
        }
        
        
        
        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let v = annotation as! Annotation3
        
        leftIconView.sd_setImage(with: URL(string: v.url!), placeholderImage: UIImage(named: "mock.png"))

        annotationView?.leftCalloutAccessoryView = leftIconView
        let calloutButton = UIButton(type: .detailDisclosure)
        annotationView?.rightCalloutAccessoryView = calloutButton
        
        let pinImage = UIImage(named:v.pin!)
        annotationView?.image = pinImage
        
        return annotationView
        
    }
    //Annotation tapped
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let a = view.annotation as? Annotation3
            //print(a?.pin!)
            poiId = (a?.id!)!
            poiUrl = (a?.url!)!
            performSegue(withIdentifier: "segueViewDetail", sender: nil)

            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueViewDetail") {
            if let destinationViewController = segue.destination as? PoiItemDetailViewController {
                destinationViewController.poiPhoto = poiUrl
                destinationViewController.poiName = ""
                destinationViewController.poiId = poiId
                destinationViewController.poiCat = poiCat
                destinationViewController.poiDescription = ""
                
            }
        }
    }
    
    
    
    
    

}
