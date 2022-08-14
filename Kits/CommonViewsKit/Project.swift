import ProjectDescription

let projectName = "CommonViewsKit"
let organizationName = "com.yasinkbas"
let bundleId = "\(organizationName).\(projectName)"

let project = Project(
    name: projectName,
    organizationName: organizationName,
    targets: [
        Target(
            name: projectName,
            platform: .iOS,
            product: .framework,
            bundleId: bundleId,
            deploymentTarget: .iOS(targetVersion: "11.0", devices: [.iphone]),
            infoPlist: .default,
            sources: ["Sources/**/*.swift"],
            resources: ["Sources/**/*.xcassets"],
            dependencies: [
                .project(target: "CommonKit", path: .relativeToManifest("../../Kits/CommonKit")),
                
                .external(name: "UILab")
            ])
    ])
