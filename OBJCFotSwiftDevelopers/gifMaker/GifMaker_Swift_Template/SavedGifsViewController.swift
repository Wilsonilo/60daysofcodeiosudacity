//
//  SavedGifsViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Wilson Muñoz on 9/18/17.
//
//

import UIKit

class SavedGifsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PreviewViewControllerProtocol {
    

    //MARK: - Properties
    var gifs = [Gif]()
    let marginCell = CGFloat(12.0)

    //MARK: - IBOultets
    @IBOutlet var emptyView: UIStackView!
    @IBOutlet var collectionView: UICollectionView!
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        reloadCollectionView()

        self.emptyView.isHidden = (self.gifs.count != 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkWelcome()
        
    }
    
    //MARK: - Collection View Delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SavedGifCollectionViewCell
        cell.gifImage.image = self.gifs[indexPath.row].gifImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - (marginCell * 2)) / 2.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let element = self.gifs[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        detailVC.gif = element
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    

    //MARK: - Helpers
    func reloadCollectionView(){
        
        
        //Fetch from archiver
        self.gifs = NSKeyedUnarchiver.unarchiveObject(withFile: gifsFilePath) as! [Gif]
        self.collectionView.reloadData()
    }
    func checkWelcome(){
        if !UserDefaults.standard.bool(forKey: "WelcomeViewSeen") {
            let welcomeVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
            self.navigationController?.pushViewController(welcomeVC, animated: true)
        }
        
    }
    
    //MARK: - Procol Implementation
    func newGif(gif: Gif) {
        print("got new gif:", gif)
        self.gifs.append(gif)
        NSKeyedArchiver.archiveRootObject(gifs, toFile: gifsFilePath)

    }
    
}
