//
//  animals.playground
//  iOS Networking
//
//  Created by Jarrod Parkes on 09/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForAnimalsJSON = Bundle.main.path(forResource: "animals", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawAnimalsJSON = try? Data(contentsOf: URL(fileURLWithPath: pathForAnimalsJSON!))

/* Error object */
var parsingAnimalsError: NSError? = nil

/* Parse the data into usable form */
var parsedAnimalsJSON = try! JSONSerialization.jsonObject(with: rawAnimalsJSON!, options: .allowFragments) as! NSDictionary

func parseJSONAsDictionary(_ dictionary: NSDictionary) {
    //print(dictionary)
    guard let photos = dictionary["photos"] as? [String:Any], let photosArray = photos["photo"] as? Array<[String:Any]> else {
        print("Problems converting array")
        return
    }
    
    print(photosArray.count)
    for photo in photos {
        print(photo)
    }
}

parseJSONAsDictionary(parsedAnimalsJSON)
