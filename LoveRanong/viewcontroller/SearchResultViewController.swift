//
//  SearchResultViewController.swift
//  LoveRanong
//
//  Created by Lapp on 28/2/2561 BE.
//  Copyright © 2561 Ranong. All rights reserved.
//

import UIKit
import Alamofire

class SearchResultViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    var packageId = 0
    var packageArray = [AnyObject]()
    
    
    var datestart = ""
    var dateend = ""
    var category = 0
    var type = 0
    var budget = 0
    var people = 0

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        
        
        
        customActivityIndicatory(self.view, startAnimate: true)
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        //Call API here...
        let url = Http.getUrl() + "search_package.php"
        let parameters: Parameters=["datestart":datestart,"dateend":dateend,"category":category,"type":type,"budget":budget,"people":people]
    
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            
            if let result = response.result.value {
                print (result)
                if let jsonData = result as? NSDictionary {
                let packageObj = jsonData.value(forKey: "data") as! NSArray
                
                    
                    if (packageObj.count == 0) {
                        let title = "ข้อผิดพลาด"
                        let message = "ไม่พบโปรแกรมท่องเที่ยวตามเงื่อนไขที่ค้นหา"
                        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(OKAction)
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        self.packageArray = packageObj as [AnyObject]
                        self.tableView.reloadData()
                    }
                } else {
                    let title = "ข้อผิดพลาด"
                    let message = "ไม่พบโปรแกรมท่องเที่ยวตามเงื่อนไขที่ค้นหา"
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
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packageArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellResult", for: indexPath)
        
        cell.textLabel?.text = packageArray[indexPath.row]["pk_title"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        packageId = packageArray[indexPath.row]["pk_id"] as! Int
        performSegue(withIdentifier: "segueSearchToDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueSearchToDetail") {
            if let destinationViewController = segue.destination as? PackageDetailViewController {
                destinationViewController.packageId = packageId
            }
        }
    }

}
