//
//  WelcomeViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Wilson Muñoz on 9/15/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - IBOutlers
    @IBOutlet var welcomGif: UIImageView!
    
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.welcomGif.loadGif(name: "hotlineBling")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
