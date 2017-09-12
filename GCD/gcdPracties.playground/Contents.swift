//: Playground - noun: a place where people can play

import UIKit

let q = DispatchQueue.global(qos: .userInteractive)

q.async { () -> Void in
    print("tic")
}

print("tac")

//
let q1 = DispatchQueue(label: "queue1")
let q2 = DispatchQueue(label: "queue2")
let q3 = DispatchQueue(label: "queue3")

q1.async { () -> Void in
    print(1)
}

q2.async { () -> Void in
    print(2)
}

q3.async { () -> Void in
    print(3)
}

print("end")

//
// create a queue
let downloadQueue = DispatchQueue(label: "download")

// add a closure that encapsulates the blocking operation
// run it asynchronously: some time in the near future
downloadQueue.async { () -> Void in
    // Obtain the Data with the image
    let imgData = try? Data(contentsOf: url!)
    
    // Turn it into a UIImage
    let image = UIImage(data: imgData!)
    
    // Display it
    photoView.image = image
}
