import Kitura
import SwiftyJSON

#if os(Linux)
    import Glibc
    srand(UInt32(time(nil)))
#else
    import Darwin.C
#endif

// Create a new router
let router = Router()

// Create salutations
let salutations: [String] = [
    "Your most humble servant and most faithful friend,",
    "Adieu! take care of yourself; and, I entreat you, write!",
    "Your old friend and erstwhile companion,",
    "May your doom be other than mine, and your treasure remain with you to the end!",
    "A thousand greetings, etc.",
    "A tender adieu.",
    "Peace out."
]

// Handle HTTP GET requests to /
router.get("/") {
    request, response, next in
    response.send("Hello, World!")
    next()
}

// Handle HTTP GET requests to /salutation
router.get("/salutation") {
    request, response, next in
#if os(Linux)
    let idx = Int(random() % salutations.count)
#else
    let idx = Int(arc4random_uniform(UInt32(salutations.count)))
#endif
    response.send(json: JSON(["text": salutations[idx]]))
    next()
}

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8090, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()
