//
//  SecondViewController.swift
//  memeGeneratorv2
//
//  Created by Wilson Muñoz on 9/10/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    //MARK: - Properties
    var memes = [Meme]()
    
    //MARK: - Outlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewLayout: UICollectionViewFlowLayout!
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        fetchMemes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        collectionViewLayout.minimumInteritemSpacing = space
        collectionViewLayout.minimumLineSpacing = space
        collectionViewLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    //MARK: - Collection Handlers
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MemeCollectionViewCell
        cell.meme.image = self.memes[indexPath.row].memedImage
        return cell
    }
    
    //MARK: - Helpers
    func fetchMemes(){
        
        let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memes = applicationDelegate.memes
        self.collectionView.reloadData()
    }
    
    
}

