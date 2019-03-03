//
//  PackageViewController.swift
//  LoveRanong
//
//  Created by Lapp on 23/2/2561 BE.
//  Copyright © 2561 Ranong. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class PackageViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var packageArray = [AnyObject]()
    var packageId = 0
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        customActivityIndicatory(self.view, startAnimate: true)
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        //Call API here...
        let url = Http.getUrl() + "list_package.php"
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                let packageObj = jsonData.value(forKey: "data") as! NSArray
            
                self.packageArray = packageObj as [AnyObject]
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
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packageArray.count
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPackage", for: indexPath) as! PackageTableViewCell
        let packageTitle = packageArray[indexPath.row]["pk_title"] as? String
        let packagePhoto = packageArray[indexPath.row]["pk_photo"] as? String
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.labelTitle.text = packageTitle
        cell.imageViewPackage.sd_setImage(with: URL(string: packagePhoto!), placeholderImage: UIImage(named: "mock.png"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let h = packageArray[indexPath.row]["pk_days"] as! CGFloat
        
        
        let height = tableView.frame.width / 2 * h
        
        return height
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        packageId = packageArray[indexPath.row]["pk_id"] as! Int
        performSegue(withIdentifier: "segueViewPackage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueViewPackage") {
            if let destinationViewController = segue.destination as? PackageDetailViewController {
                destinationViewController.packageId = packageId
            }
        }
    }
}
