//
//  GifEditorViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Wilson Muñoz on 9/15/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class GifEditorViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Properties
    var gifElement:Gif?
    
    //MARK: - IBACtions
    @IBOutlet var gigImage: UIImageView!
    @IBOutlet var addCaption: UITextField!
    
    //MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Subscribe to Keyboard Notifications
        subscribeNotificationKeyboardWillAppear()
        subscribeNotificationKeyboardWillDisappear()
        
        //Set gif on UIImage
        if self.gifElement != nil {
            let gifFromRecording = UIImage.gif(url: (self.gifElement?.url?.absoluteString)!)
            self.gigImage.image = gifFromRecording
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addCaption.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    

    //MARK: - IBActions
    @IBAction func presentPreview(sender:Any){
        
        //Add caption to gif Object
        self.gifElement?.caption = self.addCaption.text
        
        //Conform gif
        let newRegif = Regift(sourceFileURL: (self.gifElement?.videoURL)!, destinationFileURL: nil, frameCount: frameCount, delayTime: delayTime, loopCount: 0)
        let gifWithCaption = newRegif.createGif(caption: self.addCaption.text, font: self.addCaption.font)
        let finalGif = Gif(url: gifWithCaption!, videoURL: (self.gifElement?.videoURL)!, caption: self.addCaption.text)

        //Prepare PreviewViewController
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let previewVC = storyboard.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
        previewVC.gif = finalGif
        for viewcontroller in (self.navigationController?.viewControllers)!{
            
            if viewcontroller is SavedGifsViewController{
                print("declared protocol delegate")
                previewVC.delegate = viewcontroller as! SavedGifsViewController
            }
            
        }
        
        //Present
        self.navigationController?.pushViewController(previewVC, animated: true)
        
    }
    
    //MARK: - UITextField Delegate Handlers
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //textField.resignFirstResponder()
        self.view.endEditing(true)
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.addCaption.placeholder = ""
    }
    
    //MARK: - Keyboard Handlers
    //https://classroom.udacity.com/courses/ud788/lessons/4798201455/concepts/36746285410923
    func subscribeNotificationKeyboardWillAppear() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    }
    func subscribeNotificationKeyboardWillDisappear() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification){
        self.view.frame.origin.y = 0 - getKeyboardHeight(notification: notification)
        //self.holderForKeyboardHeight = getKeyboardHeight(notification: notification)
    }
    func keyboardWillHide(notification: NSNotification){
        self.view.frame.origin.y +=  getKeyboardHeight(notification: notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func unsubscribeFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }

}
