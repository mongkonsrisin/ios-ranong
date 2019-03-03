//
//  MenuViewController.swift
//  LoveRanong
//
//  Created by Lapp on 10/2/2561 BE.
//  Copyright © 2561 Lapp. All rights reserved.
//

import UIKit
import Alamofire

class MenuViewController: UIViewController {
    
    
    var poiCat = 0
    var titleBar = ""
    
    
    
    @IBOutlet weak var viewLogo: UIImageView!
    @IBOutlet weak var viewAccommodation: UIImageView!
    @IBOutlet weak var viewPackage: UIImageView!
    @IBOutlet weak var viewTour: UIImageView!
    @IBOutlet weak var viewProduct: UIImageView!
    @IBOutlet weak var viewSearch: UIImageView!
    @IBOutlet weak var viewFood: UIImageView!
    
    @IBOutlet var menuLabels: [UILabel]!
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @objc func accommodationTapped(tapGestureAccommodation: UITapGestureRecognizer) {
        poiCat = 1
        titleBar = "ที่พัก"
        performSegue(withIdentifier: "segueViewList", sender: nil)
    }
    
    @objc func tourTapped(tapGestureTour: UITapGestureRecognizer) {
        poiCat = 2
        titleBar = "สถานที่ท่องเที่ยว"
        performSegue(withIdentifier: "segueViewList", sender: nil)
    }
    
    @objc func foodTapped(tapGestureFood: UITapGestureRecognizer) {
        poiCat = 3
        titleBar = "ร้านอาหาร"
        performSegue(withIdentifier: "segueViewList", sender: nil)
    }
    
    @objc func productTapped(tapGestureProduct: UITapGestureRecognizer) {
        poiCat = 4
        titleBar = "สินค้าชุมชน"
        performSegue(withIdentifier: "segueViewList", sender: nil)
    }
    
    @objc func packageTapped(tapGesturePackage: UITapGestureRecognizer) {
        performSegue(withIdentifier: "segueViewPackage", sender: nil)
    }
    
    @objc func searchTapped(tapGestureSearch: UITapGestureRecognizer) {
        performSegue(withIdentifier: "segueSearch", sender: nil)
    }
    
    @objc func logoTapped(tapGestureLogo: UITapGestureRecognizer) {
        let urlCheck = Http.getUrl() + "apple_review.php"
        
        Alamofire.request(urlCheck, method: .get).responseJSON {
            response in
            
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                let value = jsonData.value(forKey: "data") as! Int
                if (value == 0) {
                    self.performSegue(withIdentifier: "segueAbout", sender: nil)
                }
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let urlCheck = Http.getUrl() + "apple_review.php"
       
        Alamofire.request(urlCheck, method: .get).responseJSON {
            response in
            
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                let value = jsonData.value(forKey: "data") as! Int
                if (value == 0) {
                    //Check version
                    //Call API here...
                    let url = Http.getUrl() + "app_version.php"
                    let parameters: Parameters=["platform":"ios"]
                    
                    Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
                        response in
                        
                        if let result = response.result.value {
                            let jsonData = result as! NSDictionary
                            let value = jsonData.value(forKey: "data") as! NSDictionary
                            let version = value.value(forKey: "cfg_value") as! String
                            
                            if (version != "1.0.2") {
                                let title = "แจ้งเตือน"
                                let message =  "กรุณาอัพเดตแอพเป็นเวอร์ชัน " + version + "\n" + "(เวอร์ชันปัจจุบันของคุณคือ 1.0.2)"
                                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                                let NowAction = UIAlertAction(title: "อัพเดตตอนนี้", style: .default, handler: {(action:UIAlertAction!) in
                                   
                                    
                                    
                                    
                                    if let url = URL(string: "itms-apps://itunes.apple.com/app/id1351250082"),
                                        UIApplication.shared.canOpenURL(url)
                                    {
                                        if #available(iOS 10.0, *) {
                                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                        } else {
                                            UIApplication.shared.openURL(url)
                                        }
                                    }
                                  
                                    
                                    
                                    

                                })
                                let LaterAction = UIAlertAction(title: "อัพเดตภายหลัง", style: .default, handler: nil)
                                alertController.addAction(NowAction)
                                alertController.addAction(LaterAction)
                                self.present(alertController, animated: true, completion: nil)
                            }
                            
                            
                            
                
                            
                            
                        } else {
                            let title = "Error"
                            let message = response.error?.localizedDescription
                            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(OKAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        customActivityIndicatory(self.view, startAnimate: false)
                        UIApplication.shared.endIgnoringInteractionEvents()
                    } // end Alamofire2
                }
                
                
            } else {
                let title = "Error"
                let message = response.error?.localizedDescription
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
            }
            customActivityIndicatory(self.view, startAnimate: false)
            UIApplication.shared.endIgnoringInteractionEvents()
        } // end Alamofire
        
        
        
        
        
        
        
        
        
        
        

        
        
        
        viewAccommodation.isUserInteractionEnabled = true
        viewPackage.isUserInteractionEnabled = true
        viewTour.isUserInteractionEnabled = true
        viewProduct.isUserInteractionEnabled = true
        viewSearch.isUserInteractionEnabled = true
        viewFood.isUserInteractionEnabled = true
        viewSearch.isUserInteractionEnabled = true
        viewLogo.isUserInteractionEnabled = true
        
       let tapGestureAccommodation = UITapGestureRecognizer(target: self, action: #selector(accommodationTapped(tapGestureAccommodation:)))
        viewAccommodation.addGestureRecognizer(tapGestureAccommodation)
        
        let tapGestureTour = UITapGestureRecognizer(target: self, action: #selector(tourTapped(tapGestureTour:)))
        viewTour.addGestureRecognizer(tapGestureTour)
        
        let tapGestureProduct = UITapGestureRecognizer(target: self, action: #selector(productTapped(tapGestureProduct:)))
        viewProduct.addGestureRecognizer(tapGestureProduct)
        
        let tapGesturePackage = UITapGestureRecognizer(target: self, action: #selector(packageTapped(tapGesturePackage:)))
        viewPackage.addGestureRecognizer(tapGesturePackage)
        
        let tapGestureFood = UITapGestureRecognizer(target: self, action: #selector(foodTapped(tapGestureFood:)))
        viewFood.addGestureRecognizer(tapGestureFood)

        let tapGestureSearch = UITapGestureRecognizer(target: self, action: #selector(searchTapped(tapGestureSearch:)))
        viewSearch.addGestureRecognizer(tapGestureSearch)
        
        let tapGestureLogo = UITapGestureRecognizer(target: self, action: #selector(logoTapped(tapGestureLogo:)))
        viewLogo.addGestureRecognizer(tapGestureLogo)

     
    }
    
   
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //Hide label when iPhone landscape
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone {
            if UIDevice.current.orientation.isLandscape {
                for menuLabel in menuLabels { menuLabel.isHidden = true }
            } else {
                for menuLabel in menuLabels { menuLabel.isHidden = false }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if (segue.identifier == "segueViewList") {
            if let destinationViewController = segue.destination as? ListPoiViewController {
                destinationViewController.poiCat = poiCat
                destinationViewController.titleBar = titleBar
            
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

   

}
