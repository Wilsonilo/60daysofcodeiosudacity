//
//  ViewController.swift
//  FlickFinder
//
//  Created by Jarrod Parkes on 11/5/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import UIKit

// MARK: - ViewController: UIViewController

class ViewController: UIViewController {
    
    // MARK: Properties
    
    var keyboardOnScreen = false
    
    // MARK: Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var phraseTextField: UITextField!
    @IBOutlet weak var phraseSearchButton: UIButton!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var latLonSearchButton: UIButton!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phraseTextField.delegate = self
        latitudeTextField.delegate = self
        longitudeTextField.delegate = self
        subscribeToNotification(.UIKeyboardWillShow, selector: #selector(keyboardWillShow))
        subscribeToNotification(.UIKeyboardWillHide, selector: #selector(keyboardWillHide))
        subscribeToNotification(.UIKeyboardDidShow, selector: #selector(keyboardDidShow))
        subscribeToNotification(.UIKeyboardDidHide, selector: #selector(keyboardDidHide))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromAllNotifications()
    }
    
    // MARK: Search Actions
    
    @IBAction func searchByPhrase(_ sender: AnyObject) {

        userDidTapView(self)
        setUIEnabled(false)
        
        if !phraseTextField.text!.isEmpty {
            photoTitleLabel.text = "Searching..."
            // TODO: Set necessary parameters!
            var methodParameters: [String: AnyObject] = [:]
            methodParameters["text"] = phraseTextField.text as AnyObject
            methodParameters[Constants.FlickrParameterKeys.Method] = Constants.FlickrParameterValues.SearchMethod as AnyObject?
            methodParameters[Constants.FlickrParameterKeys.APIKey] = Constants.FlickrParameterValues.APIKey as AnyObject?
            methodParameters[Constants.FlickrParameterKeys.SafeSearch] = Constants.FlickrParameterValues.UseSafeSearch as AnyObject?
            methodParameters[Constants.FlickrParameterKeys.Extras] = Constants.FlickrParameterValues.MediumURL as AnyObject?
            methodParameters[Constants.FlickrParameterKeys.Format] = Constants.FlickrParameterValues.ResponseFormat as AnyObject?
            methodParameters[Constants.FlickrParameterKeys.NoJSONCallback] = Constants.FlickrParameterValues.DisableJSONCallback as AnyObject?
            displayImageFromFlickrBySearch(methodParameters)
        } else {
            setUIEnabled(true)
            photoTitleLabel.text = "Phrase Empty."
        }
    }
    
    @IBAction func searchByLatLon(_ sender: AnyObject) {

        userDidTapView(self)
        setUIEnabled(false)
        
        if isTextFieldValid(latitudeTextField, forRange: Constants.Flickr.SearchLatRange) && isTextFieldValid(longitudeTextField, forRange: Constants.Flickr.SearchLonRange) {
            photoTitleLabel.text = "Searching..."
            // TODO: Set necessary parameters!
            var methodParameters: [String: AnyObject] = [:]
            methodParameters[Constants.FlickrParameterKeys.Method] = Constants.FlickrParameterValues.SearchMethod as AnyObject?
            methodParameters[Constants.FlickrParameterKeys.BoundingBox] = self.getBoundBox() as AnyObject?
            methodParameters[Constants.FlickrParameterKeys.APIKey] = Constants.FlickrParameterValues.APIKey as AnyObject?
            methodParameters[Constants.FlickrParameterKeys.SafeSearch] = Constants.FlickrParameterValues.UseSafeSearch as AnyObject?
            methodParameters[Constants.FlickrParameterKeys.Extras] = Constants.FlickrParameterValues.MediumURL as AnyObject?
            methodParameters[Constants.FlickrParameterKeys.Format] = Constants.FlickrParameterValues.ResponseFormat as AnyObject?
            methodParameters[Constants.FlickrParameterKeys.NoJSONCallback] = Constants.FlickrParameterValues.DisableJSONCallback as AnyObject?
            displayImageFromFlickrBySearch(methodParameters)
        }
        else {
            setUIEnabled(true)
            photoTitleLabel.text = "Lat should be [-90, 90].\nLon should be [-180, 180]."
        }
    }
    
    func getBoundBox() -> String{
        
        if let latitude = Double(latitudeTextField.text!), let longitude = Double(longitudeTextField.text!) {
            let minimumLon = max(longitude - Constants.Flickr.SearchBBoxHalfWidth, Constants.Flickr.SearchLonRange.0)
            let minimumLat = max(latitude - Constants.Flickr.SearchBBoxHalfHeight, Constants.Flickr.SearchLatRange.0)
            let maximumLon = min(longitude + Constants.Flickr.SearchBBoxHalfWidth, Constants.Flickr.SearchLonRange.1)
            let maximumLat = min(latitude + Constants.Flickr.SearchBBoxHalfHeight, Constants.Flickr.SearchLatRange.1)
            return "\(minimumLon),\(minimumLat),\(maximumLon),\(maximumLat)"
        } else {
            return "0,0,0,0"
        }
    }
    
    // MARK: Flickr API
    private func displayImageFromFlickrBySearch(_ methodParameters: [String: AnyObject], withPage: Int) {

        var methodParametersWithPageNumber = methodParameters
        methodParametersWithPageNumber[Constants.FlickrParameterKeys.Page] = withPage as AnyObject?

        let url = flickrURLFromParameters(methodParameters)
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            
            // if an error occurs, print it and re-enable the UI
            func displayError(_ error: String) {
                print(error)
                print("URL at time of error: \(url)")
                performUIUpdatesOnMain {
                    self.setUIEnabled(true)
                    self.photoTitleLabel.text = "No photo fetched."
                    self.photoImageView.image = nil
                }
            }
            
            guard (error == nil) else {
                displayError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                displayError("No data was returned by the request!")
                return
            }
            
            //Work data into Desarilization
            var parsedResult:[String:Any]! = nil
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            } catch {
                displayError("Problem on JSON Serialization")
                return
            }
            
            
            //Get into the photos key
            guard let photosKey = parsedResult[Constants.FlickrResponseKeys.Photos] as? [String:Any] else {
                displayError("Problem getting into the photos key")
                return
            }

            guard let photosArray = photosKey[Constants.FlickrResponseKeys.Photo] as? [[String:Any]] else {
                displayError("Problem creating array of photos")
                return
            }

            // select a random photo
            let randomPhotoIndex = Int(arc4random_uniform(UInt32(photosArray.count)))
            let photoDictionary = photosArray[randomPhotoIndex] as [String:Any]
            let photoTitle = photoDictionary[Constants.FlickrResponseKeys.Title] as? String

            //Work url request for image
            guard let photoURL = photoDictionary[Constants.FlickrResponseKeys.MediumURL] as? String else {
                displayError("Problem confirming URL for image")
                return
            }

            let urlImage = URL(string: photoURL)

            if let dataImage = try? Data(contentsOf: urlImage!) {

                let finalImage = UIImage(data: dataImage)

                //GCD main
                DispatchQueue.main.async {
                    //Set title and image if we are good and recover UI Habiliy
                    self.setUIEnabled(true)
                    self.photoTitleLabel.text = photoTitle
                    self.photoImageView.image = finalImage
                }
                
            } else {
                displayError("Trying to get data from image \(urlImage?.absoluteString)")
            }
            
            
        }
        task.resume()
    }
    
    private func displayImageFromFlickrBySearch(_ methodParameters: [String: AnyObject]) {
        
        let url = flickrURLFromParameters(methodParameters)
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            
            // if an error occurs, print it and re-enable the UI
            func displayError(_ error: String) {
                print(error)
                print("URL at time of error: \(url)")
                performUIUpdatesOnMain {
                    self.setUIEnabled(true)
                    self.photoTitleLabel.text = "No photo fetched."
                    self.photoImageView.image = nil
                }
            }
            
            guard (error == nil) else {
                displayError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                displayError("No data was returned by the request!")
                return
            }
            
            //Work data into Desarilization
            var parsedResult:[String:Any]! = nil
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            } catch {
                displayError("Problem on JSON Serialization")
                return
            }
            
            
            //Get into the photos key
            guard let photosKey = parsedResult[Constants.FlickrResponseKeys.Photos] as? [String:Any] else {
                displayError("Problem getting into the photos key")
                return
            }
            guard let pageNumber = photosKey[Constants.FlickrResponseKeys.Pages] as? Int else {
                displayError("Problem getting number of pages")
                return
            }
            
            //One approach
            //let randomPageNumber = Int(arc4random_uniform(UInt32(pageNumber)))
            
            //Udacity:
            let pageLimit = min(pageNumber, 40) // 40 being the max of pages on Flickr docu
            //https://www.flickr.com/services/api/flickr.photos.search.html
            let randomPage = Int(arc4random_uniform(UInt32(pageLimit))) + 1
            self.displayImageFromFlickrBySearch(methodParameters, withPage: randomPage)
            
            
        }
        task.resume()
        
    }
    
    // MARK: Helper for Creating a URL from Parameters
    
    private func flickrURLFromParameters(_ parameters: [String: AnyObject]) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.Flickr.APIScheme
        components.host = Constants.Flickr.APIHost
        components.path = Constants.Flickr.APIPath
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
}

// MARK: - ViewController: UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Show/Hide Keyboard
    
    func keyboardWillShow(_ notification: Notification) {
        if !keyboardOnScreen {
            view.frame.origin.y -= keyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if keyboardOnScreen {
            view.frame.origin.y += keyboardHeight(notification)
        }
    }
    
    func keyboardDidShow(_ notification: Notification) {
        keyboardOnScreen = true
    }
    
    func keyboardDidHide(_ notification: Notification) {
        keyboardOnScreen = false
    }
    
    func keyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func resignIfFirstResponder(_ textField: UITextField) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
    
    @IBAction func userDidTapView(_ sender: AnyObject) {
        resignIfFirstResponder(phraseTextField)
        resignIfFirstResponder(latitudeTextField)
        resignIfFirstResponder(longitudeTextField)
    }
    
    // MARK: TextField Validation
    
    func isTextFieldValid(_ textField: UITextField, forRange: (Double, Double)) -> Bool {
        if let value = Double(textField.text!), !textField.text!.isEmpty {
            return isValueInRange(value, min: forRange.0, max: forRange.1)
        } else {
            return false
        }
    }
    
    func isValueInRange(_ value: Double, min: Double, max: Double) -> Bool {
        return !(value < min || value > max)
    }
}

// MARK: - ViewController (Configure UI)

private extension ViewController {
    
     func setUIEnabled(_ enabled: Bool) {
        photoTitleLabel.isEnabled = enabled
        phraseTextField.isEnabled = enabled
        latitudeTextField.isEnabled = enabled
        longitudeTextField.isEnabled = enabled
        phraseSearchButton.isEnabled = enabled
        latLonSearchButton.isEnabled = enabled
        
        // adjust search button alphas
        if enabled {
            phraseSearchButton.alpha = 1.0
            latLonSearchButton.alpha = 1.0
        } else {
            phraseSearchButton.alpha = 0.5
            latLonSearchButton.alpha = 0.5
        }
    }
}

// MARK: - ViewController (Notifications)

private extension ViewController {
    
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}
