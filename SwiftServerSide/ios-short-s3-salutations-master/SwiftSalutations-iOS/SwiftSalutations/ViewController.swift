//
//  ViewController.swift
//  SwiftSalutations
//
//  Created by Jarrod Parkes on 1/27/17.
//  Copyright © 2017 Jarrod Parkes. All rights reserved.
//

import UIKit

let salutationEndpoint = "http://localhost:8090/salutation"

// MARK: - ViewController: UIViewController

class ViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var salutationLabel: UILabel!
    
    // MARK: Actions
    
    @IBAction func getSalutation(_ sender: Any) {
        
        // create the task
        let task = URLSession.shared.dataTask(with: URL(string: salutationEndpoint)!) { (data, response, error) in
            
            // check for error
            if let error = error {
                print(error)
                return
            }
            
            // extract salutation and display in UI
            if let data = data {
                var salutation: [String:String]! = nil
                do {
                    salutation = try JSONSerialization.jsonObject(with: data) as? [String:String]
                } catch {
                    print("could not serialize \(data)")
                    return
                }
                DispatchQueue.main.async {
                    self.salutationLabel.text = salutation["text"]
                }
            } else {
                print("no data was returned")
            }
            
        }
        
        // start the task
        task.resume()        
    }
}

