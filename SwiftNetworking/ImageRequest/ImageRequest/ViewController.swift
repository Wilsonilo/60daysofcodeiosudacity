//
//  ViewController.swift
//  ImageRequest
//
//  Created by Jarrod Parkes on 11/3/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import UIKit

// MARK: - ViewController: UIViewController

class ViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DispatchQueue.global(qos: .userInteractive).async {
//            
//            guard let urlImg = URL(string: "https://upload.wikimedia.org/wikipedia/commons/4/4d/Cat_November_2010-1a.jpg") else {
//             return }
//            let dataImg = try? Data(contentsOf: urlImg)
//            if dataImg != nil {
//                let image = UIImage(data: dataImg!)
//                DispatchQueue.main.async {
//                    self.imageView.image = image
//                }
//            }
//            
//        }
        guard let urlImg = URL(string: "https://upload.wikimedia.org/wikipedia/commons/4/4d/Cat_November_2010-1a.jpg") else {
         return }
        
        let urlRequestSession = URLSession.shared.dataTask(with: urlImg) { (data, response, error) in
            print(response?.description as String!)
            if error == nil {
                
                if let imgData:Data = data {
                    
                    DispatchQueue.main.async {
                        let imgFromData = UIImage(data: imgData)
                        self.imageView.image = imgFromData
                    }
                }
                
            } else {
                print("Error: ", error as Error!)
            }
        }
        urlRequestSession.resume()
        
    }
}
