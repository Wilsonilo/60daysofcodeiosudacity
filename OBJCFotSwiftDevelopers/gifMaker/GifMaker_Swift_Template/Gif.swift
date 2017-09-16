//
//  Gif.swift
//  GifMaker_Swift_Template
//
//  Created by Wilson Muñoz on 9/15/17.
//
//

import Foundation
import UIKit

class Gif {
    
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
}
