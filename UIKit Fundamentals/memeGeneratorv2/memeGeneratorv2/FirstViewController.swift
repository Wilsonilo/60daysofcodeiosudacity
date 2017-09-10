//
//  FirstViewController.swift
//  memeGeneratorv2
//
//  Created by Wilson Muñoz on 9/10/17.
//  Copyright © 2017 Wilson Muñoz. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Properties
    var memes = [Meme]()
    
    //MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Lyfecycle
    override func viewWillAppear(_ animated: Bool) {
        fetchMemes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Table Handlers
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // On Section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.memes[indexPath.row].topText
        cell.imageView?.image = self.memes[indexPath.row].memedImage
        cell.detailTextLabel?.text = self.memes[indexPath.row].bottomText
        
        return cell
    }

    //MARK: - Helpers
    func fetchMemes(){
        
        let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memes = applicationDelegate.memes
        self.tableView.reloadData();
    }

}

