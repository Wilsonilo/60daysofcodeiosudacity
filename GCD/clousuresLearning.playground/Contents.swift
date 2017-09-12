import UIKit
import PlaygroundSupport


//With vars

let f = { (x:Int) -> Int in
    return x + 42
}
f(42)


var filteredHouses : (String, [String], String) -> String = {
    print("running")
    if $1.contains($0) {
        return $2 + " Contained!"
    } else {
        return $2 + " NOT contained"
    }
}

//func
func greaterThanPredicateClosure(numbers: [Int], closure: (Int) -> Bool) -> [Int]{
    var result = [Int]()
    for number in numbers{
        if closure(number){
            result.append(number)
        }
    }
    
    return result
}

print(greaterThanPredicateClosure(numbers: [1,2,3,4,5]) { (num) -> Bool in
    return num > 3
})


////
let gameScoresTop3 = [45,18,250,3,7854,123,10524,345,25004]
let top3Scores = gameScoresTop3.filter {
    (score: Int) -> Bool in
    var sorted = gameScoresTop3.sorted()
    return score > sorted[3]
}

top3Scores

var sayThis = ["Swift", "With", "Shani", "is", "fun!"]

let string = sayThis.reduce("") {
    if $0 == "" {
        return $1
    } else {
        return $0 + " " + $1
    }
}
string
