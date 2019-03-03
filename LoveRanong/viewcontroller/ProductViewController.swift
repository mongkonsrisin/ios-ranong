//
//  ProductViewController.swift
//  LoveRanong
//
//  Created by Lapp on 10/3/2561 BE.
//  Copyright © 2561 Ranong. All rights reserved.
//

import UIKit
import Alamofire


class ProductViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    var roomArray = [AnyObject]()
    var poiId:Int = 0
    var poiCat:Int = 0
    @IBOutlet weak var tableView: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        
        //Call API here...
        let url = Http.getUrl() + "product_detail.php"
        let parameters: Parameters=["poiid":poiId,"cat":poiCat]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                
                let success = jsonData.value(forKey: "success") as! Bool
                if(success) {
                let room = jsonData.value(forKey: "data") as! NSArray
                    if(room.count > 0) {
                        self.roomArray = room as [AnyObject]
                        
                        self.tableView.reloadData()
                    }
                
                } else {
                    let title = "ข้อผิดพลาด"
                    let message = "ไม่มีข้อมูลของสถานที่นี้"
                    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(OKAction)
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
        } // end Alamofire
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellProduct = tableView.dequeueReusableCell(withIdentifier: "cellProduct", for: indexPath)  as! ProductTableViewCell
      let price = roomArray[indexPath.row]["price"] as? Int
       let title = roomArray[indexPath.row]["name"] as! String
       let url = roomArray[indexPath.row]["photo"] as! String
        var roomSize = "";
//        switch(title) {
//        case "s": roomSize = "ห้องขนาดเล็ก"
//            break
//        case "m": roomSize = "ห้องขนาดกลาง"
//            break
//        case "l": roomSize = "ห้องขนาดใหญ่"
//            break
//        default : roomSize = ""
//            break
//
//        }
        //cellProduct.imageViewPhoto.image = UIImage(named:"bedsm.png")
      cellProduct.labelSubtitle.text = String(price!) + " บาท"
        cellProduct.labelTitle.text = title
       cellProduct.imageViewPhoto.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "mock.png"))
        return cellProduct
    }

 

}
