//
//  PreviewViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Wilson Muñoz on 9/15/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit
import Photos

class PreviewViewController: UIViewController{
    
    //MARK: - Properties
    var gif:Gif?
    
    //MARK: - IBOulets
    @IBOutlet var previewUIImage: UIImageView!
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if self.gif != nil {
            self.previewUIImage.image = self.gif?.gifImage
        } else {
            print("nil", gif ?? "No gif info")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func shareGif(sender:UIButton){
        
        let animatedGifData = NSData(contentsOf: (self.gif?.url)!)
        let itemsToShare = [animatedGifData]
        
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
    
    @IBAction func saveGif(sender: UIButton){
        
        //Save
        //UISaveVideoAtPathToSavedPhotosAlbum((self.gif?.videoURL?.path)!, nil, nil, nil)
        //Assets Library deprecated
        //https://stackoverflow.com/questions/29482738/swift-save-video-from-nsurl-to-user-camera-roll
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: (self.gif?.url)!)
        }) { saved, error in
            if saved {
                //Present Alert
                let alertViewController = UIAlertController(title: "Success", message: "Gif Saved", preferredStyle: .alert)
                let alertOkAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                    let rootVC = self.navigationController?.viewControllers[0]
                    _ = self.navigationController?.popToViewController(rootVC!, animated: true)
                }
                alertViewController.addAction(alertOkAction)
                self.present(alertViewController, animated: true, completion: nil)
            } else {
                //Present Alert
                let alertViewController = UIAlertController(title: "Error", message: "Problem Saving Gif to your Libreary", preferredStyle: .alert)
                let alertOkAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                    let rootVC = self.navigationController?.viewControllers[0]
                    _ = self.navigationController?.popToViewController(rootVC!, animated: true)
                }
                alertViewController.addAction(alertOkAction)
                self.present(alertViewController, animated: true, completion: nil)
            }
        }


    }

}
