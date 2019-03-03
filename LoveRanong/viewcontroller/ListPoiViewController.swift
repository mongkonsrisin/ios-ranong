//
//  ListPoiViewController.swift
//  LoveRanong
//
//  Created by Lapp on 10/2/2561 BE.
//  Copyright © 2561 Lapp. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ListPoiViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {

    
    
    
    
    
    @IBAction func showMapAll(_ sender: Any) {
        performSegue(withIdentifier: "segueMapAll", sender: nil)
        
    }
    
    
    
    
    var poiArray = [AnyObject]()
    var poiArray2 = [AnyObject]()
    var poiPhoto = ""
    var poiName = ""
    var poiCat:Int = 0
    var poiId = 0
    var titleBar = ""
    var poiDescription = ""

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        poiArray2 = self.poiArray.filter({(($0["poi_name"] as! String).localizedCaseInsensitiveContains(searchText))})

        self.tableView.reloadData()
        
        
        if(searchText == "") {
            poiArray2 = self.poiArray
            self.tableView.reloadData()
            
        }

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            tableView.rowHeight = 256;
        }
        self.title = titleBar
        searchBar.delegate = self
        
        
        
        
    
        
        
        
        
        
        customActivityIndicatory(self.view, startAnimate: true)
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        //Call API here...
        let url = Http.getUrl() + "list_poi_by_cat.php"
        let parameters: Parameters=["poicatid":poiCat]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                let poiObj = jsonData.value(forKey: "data") as! NSArray
//                for item in poiObj {
//                    let obj = item as! NSDictionary
//                    print(obj["poi_name"])
//                }
                
                self.poiArray = poiObj as [AnyObject]
                self.poiArray2 = poiObj as [AnyObject]
                
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
        return poiArray2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PoiItemTableViewCell
        let poiTitle = poiArray2[indexPath.row]["poi_name"] as? String
        let poiPhoto = poiArray2[indexPath.row]["poi_photo"] as? String
        let poiDate = poiArray2[indexPath.row]["poi_openday"] as? String
        let poiPhone = poiArray2[indexPath.row]["poi_phone"] as? String
        let poiOpenTime = poiArray2[indexPath.row]["poi_opentime"] as? String
        let poiCloseTime = poiArray2[indexPath.row]["poi_closetime"] as? String
        let poiTime = poiArray2[indexPath.row]["poi_time"] as? String
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.labelTitle.text = poiTitle
        cell.labelDate.text = "🗓 " + poiDate!
        cell.labelTime.text = "🕘 " + poiTime!

       
        cell.labelPhone.text = "📞 " + poiPhone!
        cell.imageViewPhoto.sd_setImage(with: URL(string: poiPhoto!), placeholderImage: UIImage(named: "mock.png"))
        /*
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor(red: 222/255, green: 255/255, blue: 211/255, alpha: 1)
        } else {
            cell.backgroundColor = UIColor(red: 211/255, green: 255/255, blue: 250/255, alpha: 1)
            
        } */
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return tableView.frame.width / 3
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        poiPhoto = poiArray2[indexPath.row]["poi_photo"] as! String
        poiName = poiArray2[indexPath.row]["poi_name"] as! String
        poiId = poiArray2[indexPath.row]["poi_id"] as! Int
        poiDescription = poiArray2[indexPath.row]["poi_description"] as! String
        performSegue(withIdentifier: "segueViewDetail", sender: nil)
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
        if (segue.identifier == "segueMapAll") {
            if let destinationViewController = segue.destination as? MapAllViewController {
          
                destinationViewController.poiCat = poiCat
     
            }
        }
    }
    
    
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
   

}
