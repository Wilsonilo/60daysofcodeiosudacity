//
//  DetailViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Wilson Muñoz on 9/18/17.
//
//

import UIKit
import Photos

class DetailViewController: UIViewController {
    
    var gif:Gif?
    
    @IBOutlet var image: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.gif != nil {
            self.image.image = self.gif?.gifImage

        }
    }

    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func share(_ sender: Any) {
        var itemsToShare = [NSData]()
        let data = UIImagePNGRepresentation((self.gif?.gifImage)!) as NSData?
        itemsToShare.append(data!)
        
        
        let activityVC = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        activityVC.completionWithItemsHandler = {
            (activity, success, items, error) in
            print("Activity: \(activity) Success: \(success) Items: \(items) Error: \(error)")
            if(success){
                
                let alertViewController = UIAlertController(title: "Success", message: "Gif Shared", preferredStyle: .alert)
                let alertOkAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                    let rootVC = self.navigationController?.viewControllers[0]
                    _ = self.navigationController?.popToViewController(rootVC!, animated: true)
                }
                alertViewController.addAction(alertOkAction)
                self.present(alertViewController, animated: true, completion: nil)
            }
            
        }
        self.present(activityVC, animated: true, completion: nil)
    }
 

}
