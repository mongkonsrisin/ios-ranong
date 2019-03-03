//
//  LargeImageViewController.swift
//  LoveRanong
//
//  Created by Mongkon Srisin on 1/31/19.
//  Copyright © 2019 Ranong. All rights reserved.
//

import UIKit
import SDWebImage

class LargeImageViewController: UIViewController,UIScrollViewDelegate {
    
    var url = ""
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var close: UIButton!
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        // Do any additional setup after loading the view.
        imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "mock.png"))
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imageView
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
