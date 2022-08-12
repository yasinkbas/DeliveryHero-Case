import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: SwiftPackageManagerDependencies([
        .package(url: "https://github.com/yasinkbas/NLab.git", .upToNextMajor(from: "1.1.3")),
        .package(url: "https://github.com/yasinkbas/UILab.git", .upToNextMajor(from: "0.3.3")),
    ], productTypes: [
        "NLab": .framework,
        "UILab": .framework
    ]),
    platforms: [.iOS]
)
