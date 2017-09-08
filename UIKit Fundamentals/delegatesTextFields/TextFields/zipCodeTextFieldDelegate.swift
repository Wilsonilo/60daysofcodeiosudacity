//
//  zipCodeTextFieldDelegate.swift
//  TextFields
//
//  Created by Wilson Muñoz on 9/7/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class zipCodeTextFieldDelegate: NSObject, UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        ///https://stackoverflow.com/questions/25223407/max-length-uitextfield
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        //print(range.location, string, newText)
        
        //https://stackoverflow.com/questions/30973044/how-to-restrict-uitextfield-to-take-only-numbers-in-swift
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet) && newLength <= 5
    }
    
}
