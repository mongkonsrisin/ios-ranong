//
//  GalleryCollectionViewController.swift
//  LoveRanong
//
//  Created by Mongkon Srisin on 1/31/19.
//  Copyright © 2019 Ranong. All rights reserved.
//

import UIKit
import Alamofire

class GalleryCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout
     {

    var poiArray = [String]()
    var poiId:Int = 0
    var url = ""

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = (collectionView.bounds.width/3.0)-2
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets.zero
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customActivityIndicatory(self.view, startAnimate: true)
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 20, left: 2, bottom: 10, right: 2)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 3
        collectionView!.collectionViewLayout = layout
        
        
        
        //Call API here...
        let url = Http.getUrl() + "image_gallery.php"
        let parameters: Parameters=["id":poiId]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                let poiObj = jsonData.value(forKey: "data") as! NSArray
                
                self.poiArray = poiObj as! [String]
                print(self.poiArray.count)
                self.collectionView?.reloadData()
                
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return poiArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellG", for: indexPath) as! GalleryCollectionViewCell
        //cell.imgGallery.image = UIImage(named: "appicon.png")
        // Configure the cell
        let url = poiArray[indexPath.row]
        cell.imgGallery.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "mock.png"))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        url = poiArray[indexPath.row]
        performSegue(withIdentifier: "largeImage", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "largeImage") {
            if let destinationViewController = segue.destination as? LargeImageViewController {
                destinationViewController.url = url
                
            }
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
