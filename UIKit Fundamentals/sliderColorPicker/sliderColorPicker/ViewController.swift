//
//  ViewController.swift
//  sliderColorPicker
//
//  Created by Wilson Muñoz on 9/5/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //MARK: - Outlets
    @IBOutlet var label_red:UILabel!
    @IBOutlet var label_green:UILabel!
    @IBOutlet var label_blue:UILabel!
    @IBOutlet var slider_red:UISlider!
    @IBOutlet var slider_green:UISlider!
    @IBOutlet var slider_blue:UISlider!
    @IBOutlet var colorView:UIView!
    @IBOutlet var label_rgb:UILabel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setColor() // Run when is loaded
    }
    
    //MARK: - IBActions
    @IBAction func setColor(){
        
        //Update Labels
        let rgbRedValue         = CGFloat(slider_red.value)
        let rgbGreenValue       = CGFloat(slider_green.value)
        let rgbBlueValue        = CGFloat(slider_blue.value)
        //Felt lazy for the Alpha
        
        //Set View
        self.colorView.backgroundColor = UIColor(red: rgbRedValue, green: rgbGreenValue, blue: rgbBlueValue, alpha: 1.0)
        
        //Set labels
        self.label_rgb.text = "RGB: \( String(format:"%.2f", CGFloat(slider_red.value)) ), \( String(format:"%.2f", CGFloat(slider_green.value)) ), \(String(format:"%.2f", CGFloat(slider_blue.value)))"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

