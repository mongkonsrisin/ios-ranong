//
//  DirectionViewController.swift
//  LoveRanong
//
//  Created by Lapp on 19/3/2561 BE.
//  Copyright © 2561 Ranong. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class DirectionViewController: UIViewController,MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var poiId = 0
    var poiUrl = ""
    var poiCat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        
     
        
        
        let parameters: Parameters=["pkid":1]
        
        let url = Http.getUrl() + "package_detail.php"
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON
            {
                response in
                
                if let result = response.result.value {
                    
                    let jsonData = result as! NSDictionary
                    let data = jsonData.value(forKey: "data") as! NSDictionary
                    
                    let poiObj = data.value(forKey: "pk_routedetail") as! NSArray
                    
                    
                    for  i in 0..<poiObj.count {
                        
                    let poi = poiObj[i] as! NSDictionary

                        
                     
                        
                        
                        var lat = poi.value(forKey: "poi_lat") as! String
                        lat = lat.trimmingCharacters(in: .whitespacesAndNewlines)
                        var lng = poi.value(forKey: "poi_lng") as! String
                        lng = lng.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        let name = poi.value(forKey: "poi_name") as! String
                        let photo = poi.value(forKey: "poi_photo") as! String
                        let pin = poi.value(forKey: "poi_pin") as! Int
                        let id = poi.value(forKey: "poi_id") as! Int

                        let myAnno = Annotation3(coordinate: CLLocationCoordinate2DMake(Double(lat)!, Double(lng)!), title: name, subtitle: "", image: UIImage(named:"mock.png"), url: photo, pin: "pin"+String(pin)+".png", id: id)
                        
                        
                        if(i < poiObj.count-1) {
                        let d1 = poiObj[i] as! NSDictionary
                        let j = i+1
                        let d2 = poiObj[j] as! NSDictionary
                        var lat1 = d1.value(forKey: "poi_lat") as! String
                        lat1 = lat1.trimmingCharacters(in: .whitespacesAndNewlines)

                        var lng1 = d1.value(forKey: "poi_lng") as! String
                        lng1 = lng1.trimmingCharacters(in: .whitespacesAndNewlines)

                        var lat2 = d2.value(forKey: "poi_lat") as! String
                        lat2 = lat2.trimmingCharacters(in: .whitespacesAndNewlines)

                        var lng2 = d2.value(forKey: "poi_lng") as! String
                        lng2 = lng2.trimmingCharacters(in: .whitespacesAndNewlines)


                        
                        
                       
                        self.direction(fromLat: Double(lat1)!, fromLng: Double(lng1)!, toLat: Double(lat2)!, toLng: Double(lng2)!)
                        }
                        
                        self.mapView.showAnnotations([myAnno], animated: false)
                    }
                    let span:MKCoordinateSpan = MKCoordinateSpanMake(1, 1)
                    
                    let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(9.962533, 98.640371)
                    let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
                    self.mapView.setRegion(region, animated: true)
                    
                    
                }
                
                
        }
        
        
        
        
        
        
      

        
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.red
        return renderer
    
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func direction(fromLat lat1:Double,fromLng lng1:Double,toLat lat2:Double,toLng lng2:Double) {
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat1, longitude: lng1), addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat2, longitude: lng2), addressDictionary: nil))
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                self.mapView.add(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
        
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
