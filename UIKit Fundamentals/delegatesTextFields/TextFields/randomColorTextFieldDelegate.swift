//
//  randomColorTextFieldDelegate.swift
//  TextFields
//
//  Created by Wilson Muñoz on 9/7/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class randomColorTextFieldDelegate: NSObject, UITextFieldDelegate{
    
    //MARK: - Methods for Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.textColor = randomColor()
        return true
    }
    
    //MARK: - Helpers
    //Returns a random Color
    //https://classictutorials.com/2014/08/generate-a-random-color-in-swift/
    func randomColor()-> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    
}
