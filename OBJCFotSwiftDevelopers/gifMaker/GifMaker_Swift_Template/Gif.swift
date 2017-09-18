//
//  Gif.swift
//  GifMaker_Swift_Template
//
//  Created by Wilson Muñoz on 9/15/17.
//
//

import Foundation
import UIKit

class Gif: NSObject, NSCoding {
    
    var url         :URL?
    var caption     :String?
    var gifImage    :UIImage?
    var videoURL    :URL?
    var gifData     :NSData?
    
    
    init(name: String){
        self.gifImage = UIImage.gif(name: name)
    }
    
    
    init(url:URL, videoURL:URL, caption:String?) {
        self.url = url
        self.videoURL = videoURL
        self.caption = caption
        self.gifImage = UIImage.gif(url: url.absoluteString)!
        self.gifData = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        // Unarchive the data, one property at a time
        url = aDecoder.decodeObject(forKey: "gifURL") as! URL?
        caption = aDecoder.decodeObject(forKey: "caption") as! String?
        videoURL = aDecoder.decodeObject(forKey: "videoURL") as! URL?
        gifImage = aDecoder.decodeObject(forKey: "gifImage") as! UIImage?
        gifData = aDecoder.decodeObject(forKey: "gifData") as! NSData?
    }
    
    
    func encode(with aCoder: NSCoder) {
         aCoder.encode(url, forKey: "gifURL")
         aCoder.encode(caption, forKey: "caption")
         aCoder.encode(videoURL, forKey: "videoURL")
         aCoder.encode(gifImage, forKey: "gifImage")
         aCoder.encode(gifData, forKey: "gifData")
    }
    
}
