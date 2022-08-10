import ProjectDescription
let projectName = "DeliveryHero-Case"
let bundleId = "com.yasinkbas.\(projectName)"

let appTarget = Target(
    name: projectName,
    platform: .iOS,
    product: .app,
    bundleId: bundleId,
    deploymentTarget: .iOS(targetVersion: "11.0", devices: [.iphone]),
    infoPlist: .extendingDefault(with: [
        "UILaunchScreen": [:]
    ]),
    sources: ["\(projectName)/**"],
    resources: ["\(projectName)/**/*.xcassets"],
    dependencies: [
        // Externals
        .external(name: "NLab"),
        .external(name: "UILab"),
        .xcframework(path: "Frameworks/GRDB.xcframework"),
        
        // Internal Kits
        .project(target: "NetworkManagerKit", path: .relativeToManifest("Kits/NetworkManagerKit")),
        .project(target: "DependencyManagerKit", path: .relativeToManifest("Kits/DependencyManagerKit")),
        
        // Internal Modules
        .project(target: "MovieModule", path: .relativeToManifest("Modules/MovieModule")),
    ]
)


let project = Project(
    name: projectName,
    organizationName: bundleId,
    targets: [
        appTarget
    ]
)
