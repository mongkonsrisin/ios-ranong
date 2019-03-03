//
//  PackageDetailViewController.swift
//  LoveRanong
//
//  Created by Lapp on 23/2/2561 BE.
//  Copyright © 2561 Ranong. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class PackageDetailViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    var packagePoiArray = [AnyObject]()
    var packageId = 0
    var poiId = 0
    var poiName = ""
    var poiPhoto = ""
    var poiDescription = ""
    var poiCat = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBAction func viewDirection(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "segueDirection", sender: nil)
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            tableView.rowHeight = 256;
        } else {
            tableView.rowHeight = 100;

        }
        
        customActivityIndicatory(self.view, startAnimate: true)
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        //Call API here...
        let url = Http.getUrl() + "package_detail.php"
        
        let parameters: Parameters=["pkid":packageId]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                let packageObj = jsonData.value(forKey: "data") as! NSDictionary
                let poiObj = packageObj.value(forKey: "pk_routedetail") as! NSArray
                self.packagePoiArray =  poiObj as [AnyObject]

                
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packagePoiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPackagePoi", for: indexPath) as! PackagePoiTableViewCell
        let poiName = packagePoiArray[indexPath.row]["poi_name"] as? String
        let poiPhoto = packagePoiArray[indexPath.row]["poi_photo"] as? String
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.accessoryType = .disclosureIndicator
        cell.imageViewPhoto.sd_setImage(with: URL(string: poiPhoto!), placeholderImage: UIImage(named: "mock.png"))
        cell.labelCount.text = String(indexPath.row + 1)
        cell.labelTitle.text = poiName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        poiPhoto = packagePoiArray[indexPath.row]["poi_photo"] as! String
        poiName = packagePoiArray[indexPath.row]["poi_name"] as! String
        poiId = packagePoiArray[indexPath.row]["poi_id"] as! Int
        poiCat = packagePoiArray[indexPath.row]["poi_cat"] as! Int

        poiDescription = packagePoiArray[indexPath.row]["poi_description"] as! String
        performSegue(withIdentifier: "segueViewDetail", sender: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueViewDetail") {
            if let destinationViewController = segue.destination as? PoiItemDetailViewController {
                destinationViewController.poiPhoto = poiPhoto
                destinationViewController.poiName = poiName
                destinationViewController.poiId = poiId
                destinationViewController.poiCat = poiCat
                destinationViewController.poiDescription = poiDescription
                
            }
        }
    }

    

}
