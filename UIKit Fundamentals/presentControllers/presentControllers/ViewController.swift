//
//  ViewController.swift
//  presentControllers
//
//  Created by Wilson Muñoz on 9/5/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var showActivityController:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func showActivityContr(_ sender: Any) {
        

        //Present Activity
//        let image = UIImage()
//        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
//        self.present(activityController, animated: true, completion: nil)
        
        
        //Alert
        let alertViewController = UIAlertController(title: "Title of Alert", message: "Message of Alert", preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alertViewController.addAction(alertOkAction)
        self.present(alertViewController, animated: true, completion: nil)
        
    }
}

