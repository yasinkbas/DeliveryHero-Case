import ProjectDescription
let projectName = "MovieModuleApp"
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
        .project(target: "MovieModule", path: .relativeToRoot("Modules/MovieModule"))
    ]
)

let project = Project(
    name: projectName,
    organizationName: bundleId,
    targets: [
        appTarget
    ]
)
