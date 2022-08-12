import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: SwiftPackageManagerDependencies([
        .package(url: "https://github.com/yasinkbas/NLab.git", .upToNextMajor(from: "1.1.3")),
        .package(url: "https://github.com/yasinkbas/UILab.git", .upToNextMajor(from: "0.3.3")),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.1.0")
    ], productTypes: [
        "NLab": .framework,
        "UILab": .framework,
        "SDWebImage": .framework,
    ]),
    platforms: [.iOS]
)
