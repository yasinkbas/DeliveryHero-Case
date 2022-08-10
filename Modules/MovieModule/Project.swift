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
            dependencies: [
                .project(target: "DependencyManagerKit", path: .relativeToManifest("../../Kits/DependencyManagerKit")),
                .project(target: "NetworkManagerKit", path: .relativeToManifest("../../Kits/NetworkManagerKit")),
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
