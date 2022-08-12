import ProjectDescription

let projectName = "MovieModule"
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
            resources: [
                "Sources/**/*.xcassets"
            ],
            dependencies: [
                .project(target: "DependencyManagerKit", path: .relativeToManifest("../../Kits/DependencyManagerKit")),
                .project(target: "NetworkManagerKit", path: .relativeToManifest("../../Kits/NetworkManagerKit")),
                .project(target: "CommonKit", path: .relativeToManifest("../../Kits/CommonKit")),
                .project(target: "CoreViewsKit", path: .relativeToManifest("../../Kits/CoreViewsKit")),
                
                    .external(name: "UILab"),
            ]),
        Target(
            name: "\(projectName)Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "\(bundleId)Tests",
            deploymentTarget: .iOS(targetVersion: "11.0", devices: [.iphone]),
            infoPlist: .default,
            sources: ["UnitTests/**"],
            resources: ["UnitTests/**"],
            dependencies: [
                .target(name: projectName)
            ])
    ])
