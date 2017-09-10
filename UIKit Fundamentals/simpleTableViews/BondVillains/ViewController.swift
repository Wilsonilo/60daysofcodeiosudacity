//
//  ViewController.swift
//  BondVillains
//
//  Created by Jason on 11/19/14.
//  Copyright (c) 2014 Udacity. All rights reserved.
//

import UIKit

// MARK: - ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Properties
    
    // Get ahold of some villains, for the table
    // This is an array of Villain instances
    let allVillains = Villain.allVillains

    // MARK: Table View Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allVillains.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! VillianTableViewCell
        let villain = self.allVillains[(indexPath as NSIndexPath).row]

        // Set the name and image
        cell.title.text = villain.name
        cell.subtitle.text = villain.evilScheme
        cell.villianImae.image = UIImage(named: villain.imageName)
        

        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
