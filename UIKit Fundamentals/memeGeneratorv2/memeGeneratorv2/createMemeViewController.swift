//
//  createMemeViewController.swift
//  memeGeneratorv2
//
//  Created by Wilson Muñoz on 9/10/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

import UIKit

class createMemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    //MARK: - Outlets
    @IBOutlet var image_center: UIImageView!
    @IBOutlet var camera_button: UIBarButtonItem!
    @IBOutlet var top_textfield: UITextField!
    @IBOutlet var bottom_textfield: UITextField!
    @IBOutlet var toolbar_bottom: UIToolbar!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    //MARK: - Properties
    var holderForKeyboardHeight:CGFloat?
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        self.camera_button.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeNotificationKeyboardWillAppear()
        subscribeNotificationKeyboardWillDisappear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        top_textfield.layer.opacity = 0
        bottom_textfield.layer.opacity = 0
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: 0]
        top_textfield.defaultTextAttributes = memeTextAttributes
        bottom_textfield.defaultTextAttributes = memeTextAttributes
        top_textfield.textAlignment =  .center
        bottom_textfield.textAlignment = .center
        bottom_textfield.backgroundColor = UIColor.clear
        top_textfield.backgroundColor = UIColor.clear
        top_textfield.delegate = self
        bottom_textfield.delegate = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    //MARK: - IBActions
    //PickPhoto
    @IBAction func pickPhoto(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    //Saves Meme
    @IBAction func save() {
        // Create the meme
        let meme = Meme(topText: self.top_textfield.text!, bottomText: self.bottom_textfield.text!, originalImage: self.image_center.image!, memedImage: generateMemedImage())
        
        //Save to model on AppDelegate
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        
        
        //Uncomment and comment the next part based on if you want to give a Activity Controller for sharing, on my case nop.
        
        //Work Activity Controller for sharing stuff
//        let activityController = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
//        
//        //Present Activity Controller and if success Alert.
//        self.present(activityController, animated: true, completion: nil)
//        activityController.completionWithItemsHandler = {
//            (activity, success, items, error) in
//            print("Activity: \(activity) Success: \(success) Items: \(items) Error: \(error)")
//            if(success){
//                
//                let alertViewController = UIAlertController(title: "Success", message: "Image saved to Album", preferredStyle: .alert)
//                let alertOkAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
//                    self.dismiss(animated: true, completion: nil)
//                }
//                alertViewController.addAction(alertOkAction)
//                self.present(alertViewController, animated: true, completion: nil)
//            }
//            
//        }
        let alertViewController = UIAlertController(title: "Success", message: "Image saved to Album", preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alertViewController.addAction(alertOkAction)
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    //MARK: - Image Picker Control Handlers
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("User canceled picking photo")
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.image_center.image = image
            //self.image_center.contentMode = .center
            dismiss(animated: true, completion: {
                self.top_textfield.layer.opacity = 1
                self.bottom_textfield.layer.opacity = 1
                self.saveButton.isEnabled = true
            })
        }
    }
    
    //MARK: - TextFields Handlers
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        //        if self.holderForKeyboardHeight != nil {
        //            self.view.frame.origin.y += self.holderForKeyboardHeight!
        //        }
        return false
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
    
    //MARK: - Helpers
    //Conforms memed image.
    func generateMemedImage() -> UIImage {
        
        //Hide
        self.toolbar_bottom.layer.opacity = 0
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.toolbar_bottom.layer.opacity = 1
        
        return memedImage
    }

}
