import ProjectDescription
let projectName = "PersonModuleApp"
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
        .project(target: "PersonModule", path: .relativeToRoot("Modules/PersonModule"))
    ]
)

let project = Project(
    name: projectName,
    organizationName: bundleId,
    targets: [
        appTarget
    ]
)
