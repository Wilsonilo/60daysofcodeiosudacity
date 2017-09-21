//
//  hearthstone.playground
//  iOS Networking
//
//  Created by Jarrod Parkes on 09/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForHearthstoneJSON = Bundle.main.path(forResource: "hearthstone", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawHearthstoneJSON = try? Data(contentsOf: URL(fileURLWithPath: pathForHearthstoneJSON!))

/* Error object */
var parsingHearthstoneError: NSError? = nil

/* Parse the data into usable form */
var parsedHearthstoneJSON = try! JSONSerialization.jsonObject(with: rawHearthstoneJSON!, options: .allowFragments) as! NSDictionary

func parseJSONAsDictionary(_ dictionary: NSDictionary) {
    
    var countMinions        :Int = 0
    var weaponsDurability   :Int = 0
    var minionsBattleCry    :Int = 0
    var minions             :Int = 0
    var avgCostMinion       :Int = 0
    guard let actions = dictionary["Basic"] as? Array<[String:Any]> else { return }
    for (key, action) in actions.enumerated() {
        //print(action["type"])
        
        //Minions 5
        if action["type"] as! String == "Minion" && action["cost"] as! Int == 5 {
            countMinions += 1
        }
        
        //Weapons Durability 2
        if action["type"] as! String == "Weapon" && action["durability"] as! Int == 2 {
            weaponsDurability += 1
        }
        
        
        if action["type"] as! String == "Minion"{
            
            minions += 1
            
            //Minions BattleCry
            if let text = action["text"] as? String  {
                if text.range(of: "Battlecry") != nil{
                    minionsBattleCry += 1
                }
            }
            
            
            //Avg Cost
            guard let cost = action["cost"] as? Int else {return}
            avgCostMinion += cost
        }
    }
    
    print((avgCostMinion/minions))
}

parseJSONAsDictionary(parsedHearthstoneJSON)
