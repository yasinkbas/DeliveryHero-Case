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
        
        // Internal Modules
    ]
)


let project = Project(
    name: projectName,
    organizationName: bundleId,
    targets: [
        appTarget
    ]
)
