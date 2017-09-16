//
//  UIViewController+Record.swift
//  GifMaker_Swift_Template
//
//  Created by Wilson Muñoz on 9/15/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices
import AVFoundation
import Photos

//MARK: - Properties
let frameCount = 16
let frameRate = 15
let delayTime: Float = 0.2
let loopCount = 0

//MARK: - UIViewCotnroller General
extension UIViewController {
    
    
    //MARK: - IBActions
    @IBAction func presentVideoOptions(sender: Any){
        
        //Set basic Action sheet for source of gif, photo library and cancel are defaults
        let alertpresentVideoOptions = UIAlertController(title: "Select Source", message: nil, preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "From Library", style: .default) { (UIAlertAction) in
            self.launchPhotoLibrary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertpresentVideoOptions .addAction(photoLibraryAction)
        alertpresentVideoOptions .addAction(cancelAction)
        alertpresentVideoOptions.view.tintColor = UIColor(red:1.000, green:0.388, blue:0.302, alpha:1.000)
        //If we have camera available we append it
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
                self.launchCamera()
            }
            alertpresentVideoOptions .addAction(cameraAction)
        }
        
        self.present(alertpresentVideoOptions, animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    func launchCamera(){
        
        let UIPickerInit = UIImagePickerController()
        UIPickerInit.allowsEditing = true
        UIPickerInit.sourceType = .camera
        UIPickerInit.mediaTypes = [kUTTypeMovie as String]
        UIPickerInit.delegate = self
        
        present(UIPickerInit, animated: true, completion: nil)
        
    }
    
    func launchPhotoLibrary(){
        
        let UIPickerInit = UIImagePickerController()
        UIPickerInit.allowsEditing = true
        UIPickerInit.sourceType = .photoLibrary
        UIPickerInit.mediaTypes = [kUTTypeMovie as String]
        UIPickerInit.delegate = self
        
        present(UIPickerInit, animated: true, completion: nil)
    
    }
    
    func createVideoToGif (videoURL: URL, start: NSNumber?, duration: NSNumber?){
        
        var regift: Regift?
        var gifURL: URL?
        if start == nil || duration == nil {
            // Untrimmed
            regift = Regift(sourceFileURL: videoURL, frameCount: frameCount, delayTime: delayTime)
            gifURL = regift?.createGif()

        }
        else {
            // trimmed
            regift = Regift(sourceFileURL: videoURL, startTime: Float(start!), duration: Float(duration!), frameRate: frameRate)
            gifURL = regift?.createGif()
        }
        //saveGif(gifURL, videoURL: croppedURL)
        let gif = Gif(url: gifURL!, videoURL: videoURL, caption: nil)
        self.displayGIF(gif: gif)
    }
    
    func displayGIF(gif: Gif){
        let editorVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GifEditorViewController") as! GifEditorViewController
        editorVC.gifElement = gif
        self.navigationController?.pushViewController(editorVC, animated: true)
        
    }
    func cropVideo(toSquare rawVideoURL: URL, start: NSNumber, duration: NSNumber) {
        
        //Create the AVAsset and AVAssetTrack
        let videoAsset = AVAsset(url: rawVideoURL)
        let videoTrack = videoAsset.tracks(withMediaType: AVMediaTypeVideo).first! as AVAssetTrack
        print(videoTrack)
        
        // Crop to square
        let composition = AVMutableComposition()
        composition.addMutableTrack(withMediaType: AVMediaTypeVideo, preferredTrackID: CMPersistentTrackID())
        
        let videoComposition = AVMutableVideoComposition()
        videoComposition.renderSize = CGSize( width: videoTrack.naturalSize.height, height: videoTrack.naturalSize.height )
        videoComposition.frameDuration = CMTimeMake(1, 30)


        let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRangeMake(kCMTimeZero, CMTimeMakeWithSeconds(60, 30))
        
        // rotate to portrait
        let transformer = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
        let t1 = CGAffineTransform(translationX: videoTrack.naturalSize.height, y: -(videoTrack.naturalSize.width - videoTrack.naturalSize.height) / 2)
        let t2: CGAffineTransform = t1.rotated(by: .pi/2)
        let finalTransform: CGAffineTransform = t2
        transformer.setTransform(finalTransform, at: kCMTimeZero)
        instruction.layerInstructions = [transformer]
        videoComposition.instructions = [instruction]

        
        //Export
        let exporter = AVAssetExportSession(asset: videoAsset, presetName: AVAssetExportPresetHighestQuality)
        exporter?.videoComposition = videoComposition
        //let path: String = createPath()

        exporter?.outputURL = URL(string: createPath())
        //AVFileTypeQuickTimeMovie
        //AVFileTypeMPEG4
        exporter?.outputFileType = AVFileTypeMPEG4
        exporter?.exportAsynchronously(completionHandler: {
            
            DispatchQueue.global().async {

                if exporter?.status == .completed {
                    //print("Completed:", exporter?.videoComposition)
                    print(exporter?.outputURL)
                    self.createVideoToGif(videoURL: (exporter?.outputURL)!, start: start, duration: duration)
                }
                if exporter?.status == .cancelled {
                    print("cancelled")

                }
                if exporter?.status == .failed{
                    print("Failed", exporter?.error)

                }
                
            }
            //            print("INFOR FROm EXPORTER: ", croppedURL!, start, duration)
            //            self.createVideoToGif(videoURL: croppedURL!, start: start, duration: duration)
        })



    }
    
//    func createPath() -> String {
//        let paths: [Any] = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
//        let documentsDirectory: String = (paths[0] as? String)!
//        let manager = FileManager.default
//        var outputURL: String = URL(fileURLWithPath: documentsDirectory).appendingPathComponent("trimvideos").absoluteString
//        try? manager.createDirectory(atPath: outputURL, withIntermediateDirectories: true, attributes: nil)
//        let pathURLApp = manager.containerURL(forSecurityApplicationGroupIdentifier: "gitfMaker.wisonmunoz.net")
//        outputURL = (URL(string: outputURL)?.appendingPathComponent("output.mov").absoluteString)!
//        // Remove Existing File
//        print( outputURL)
//        try? manager.removeItem(atPath: outputURL)
//        if  manager.fileExists(atPath: outputURL) {
//            print("file exists")
//        }
//        return outputURL
//    }
    
    func createPath() -> String {
        let filename = UUID().uuidString.appending(".mp4") // setting random file name
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileurl = documentsUrl.appendingPathComponent(filename).absoluteString
        try? FileManager.default.removeItem(atPath: fileurl)

        return fileurl
    }

}

//MARK: - UIImagePickerControllerDelegate
extension UIViewController: UIImagePickerControllerDelegate {

    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        if mediaType == kUTTypeMovie as String {
            
            let videoUrl = info[UIImagePickerControllerMediaURL] as! URL
            //print(info["_UIImagePickerControllerVideoEditingStart"] as? NSNumber, info.keys)
            let start = info["_UIImagePickerControllerVideoEditingStart"] as? NSNumber
            let end = info["_UIImagePickerControllerVideoEditingEnd"] as? NSNumber
            var duration: NSNumber?
            if let start = start {
                duration = NSNumber(value: (end!.floatValue) - (start.floatValue))
            } else {
                duration = nil
            }
            
            if duration == nil {
                self.createVideoToGif(videoURL: videoUrl, start: start, duration: duration as NSNumber?)
            } else {
                self.cropVideo(toSquare: videoUrl, start: start!, duration: duration!)
            }
            
            //UISaveVideoAtPathToSavedPhotosAlbum(videoUrl.path, nil, nil, nil)
            //self.createVideoToGif(videoURL: videoUrl, start: start, duration: duration as NSNumber?)
            //self.cropVideo(toSquare: videoUrl, start: start!, duration: duration!)
            dismiss(animated: true, completion: nil)
        }
        
    }
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UINavigationControllerDelegate
extension UIViewController: UINavigationControllerDelegate {
    
}
