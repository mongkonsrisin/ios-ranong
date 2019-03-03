//
//  PoiItemDetailViewController.swift
//  LoveRanong
//
//  Created by Lapp on 8/2/2561 BE.
//  Copyright © 2561 Lapp. All rights reserved.
//

import UIKit
import Alamofire

class PoiItemDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var poiArray = [AnyObject]()
    var poiId:Int = 0
    var poiPhoto:String = ""
    var poiName:String = ""
    var poiLat:String = ""
    var poiLng:String = ""
    var poiDescription:String = ""
    var poiCat:Int = 0
    
    
    var poiOpenDay:String = ""
    var poiOpenTime:String = ""
    var poiCloseTime:String = ""
    var poiPhone:String = ""
    var poiMobile:String = ""
    var poiWebsite:String = ""
    var poiEmail:String = ""
    var poiFacebook:String = ""
    var poiLine:String = ""
    var poiTime:String = ""
    
    var keys = ["วัน","เวลา","เบอร์มือถือ","เบอร์บ้าน","เว็บไซต์","อีเมล","Facebook","LINE"]
    var icons = ["calendar.png","clock.png","smartphone.png","telephone.png","world.png","mail.png","facebook.png","line.png"]
    @IBOutlet weak var tableView: UITableView!
    

    
    @IBOutlet weak var btnInfo: UIBarButtonItem!
    
    
    
    @IBAction func viewMap(_ sender: UIButton) {
        performSegue(withIdentifier: "segueViewMap", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueViewMap") {
            if let destinationViewController = segue.destination as? MapViewController {
                destinationViewController.poiName = poiName
                destinationViewController.poiLat = poiLat
                destinationViewController.poiLng = poiLng
                destinationViewController.poiPhoto = poiPhoto

            }
        }
        
        if (segue.identifier == "gallery") {
            if let destinationViewController = segue.destination as? GalleryCollectionViewController {
            
                destinationViewController.poiId = poiId
                
                
            }
        }
        
        if (segue.identifier == "segueProduct") {
            if let destinationViewController = segue.destination as? ProductViewController {
                destinationViewController.poiId = poiId
                destinationViewController.poiCat = poiCat
                
            }
        }
      
    }
    
    
    

    
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        
        let title = "TEST"
        let message = "TEST"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    @objc func getInfoAction() {
        performSegue(withIdentifier: "segueProduct", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    


       
        let urlCheck = Http.getUrl() + "apple_review.php"
        
        Alamofire.request(urlCheck, method: .get).responseJSON {
            response in
            
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                let value = jsonData.value(forKey: "data") as! Int
                if (value == 0) {
      
        //Create info button for restaurant , shop , hotel
                    if(self.poiCat != 2) {
            // Create the info button
            let infoButton = UIButton(type: .infoLight)
            
            // You will need to configure the target action for the button itself, not the bar button itemr
            infoButton.addTarget(self, action: #selector(self.getInfoAction), for: .touchUpInside)
            
            // Create a bar button item using the info button as its custom view
            let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
            
            // Use it as required
            self.navigationItem.rightBarButtonItem = infoBarButtonItem
        }
                }
            }
        } // End Alamofire
        
        customActivityIndicatory(self.view, startAnimate: true)
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
    
        
        
        //Call API here...
        let url = Http.getUrl() + "poi_detail.php"
        let parameters: Parameters=["poiid":poiId]

        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                let poi = jsonData.value(forKey: "data") as! NSDictionary
                self.poiName = poi.value(forKey: "poi_name") as! String
                self.poiLat = poi.value(forKey: "poi_lat") as! String
                self.poiLng = poi.value(forKey: "poi_lng") as! String
                self.poiDescription = poi.value(forKey: "poi_description") as! String
                self.poiPhone = poi.value(forKey: "poi_phone") as! String
                self.poiMobile = poi.value(forKey: "poi_mobile") as! String
                self.poiOpenDay = poi.value(forKey: "poi_openday") as! String
                self.poiOpenTime = poi.value(forKey: "poi_opentime") as! String
                self.poiCloseTime = poi.value(forKey: "poi_closetime") as! String
                self.poiTime = poi.value(forKey: "poi_time") as! String
                self.poiWebsite = poi.value(forKey: "poi_website") as! String
                self.poiEmail = poi.value(forKey: "poi_email") as! String
                self.poiFacebook = poi.value(forKey: "poi_facebook") as! String
                self.poiLine = poi.value(forKey: "poi_line") as! String
               
                self.tableView.reloadData()


                
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return tableView.frame.width / 2
        } else if (indexPath.row > 2) {
            return 50
        }
        return tableView.rowHeight
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0) {
            performSegue(withIdentifier: "gallery", sender: nil)
        }
        
    }
    
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            //Photo
            let cellPhoto = tableView.dequeueReusableCell(withIdentifier: "cellPhoto", for: indexPath) as! DetailPhotoTableViewCell
            cellPhoto.imageViewPhoto.sd_setImage(with: URL(string: poiPhoto), placeholderImage: UIImage(named: "mock.png"))
            return cellPhoto
        } else if (indexPath.row == 1) {
            //Title
            let cellTitle = tableView.dequeueReusableCell(withIdentifier: "cellTitle", for: indexPath) as! DetailTitleTableViewCell
            cellTitle.labelTitle.text = poiName
            return cellTitle
        } else  if (indexPath.row == 2){
            //Description
            let cellDescription = tableView.dequeueReusableCell(withIdentifier: "cellDescription", for: indexPath) as! DetailDescriptionTableViewCell
            cellDescription.labelDescription.text = poiDescription
            if (poiDescription == "") {
                cellDescription.labelDescription.text = "-"
            }
            return cellDescription
        } else {
            //Contact
                let cellContact = tableView.dequeueReusableCell(withIdentifier: "cellContact", for: indexPath) as! DetailContactTableViewCell
            let i = indexPath.row - 3
                cellContact.labelKey.text = keys[i]
            switch (i) {
                //Date
                case 0 : cellContact.labelValue.text = poiOpenDay
                    break
                
                //Time
                case 1 : cellContact.labelValue.text = poiTime
                    break
                
                //Mobile Tel
                case 2 : cellContact.labelValue.text = poiMobile
                    break
                
                //Home Tel
                case 3 : cellContact.labelValue.text = poiPhone
                    break
                
                //Web
                case 4 : cellContact.labelValue.text = poiWebsite
                    break
                
                //Email
                case 5 : cellContact.labelValue.text = poiEmail
                    break
                
                //FB
                case 6 : cellContact.labelValue.text = poiFacebook
            
                    break
                
                //LINE
                case 7 : cellContact.labelValue.text = poiLine
                    break
                
                
                default : cellContact.labelValue.text = "-"
                    break
                
                
                
            }
            cellContact.imageViewIcon.image = UIImage(named:icons[i])
            if(cellContact.labelValue.text == "") {
                cellContact.labelValue.text = "-"
            }
            return cellContact
        }
    }
  

}
