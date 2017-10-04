import PackageDescription

let package = Package(
    name: "SwiftSalutations-Server",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1)
    ]
)
