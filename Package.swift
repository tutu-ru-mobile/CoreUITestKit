// swift-tools-version:5.0
import Foundation
import PackageDescription

let package = Package(
  name: "CoreUITestKit",
  platforms: [
    .iOS(.v11),
    .macOS(.v10_10),
    .tvOS(.v10)
  ],
  products: [
    .library(
      name: "CoreUITestKit",
      targets: ["CoreUITestKit"]),
  ],
  targets: [
    .target(
      name: "CoreUITestKit")
  ]
  dependencies: [
    .package(
        url: "https://github.com/tutu-ru-mobile/CoreUITestKit",
        from: "0.0.2"
    )
        url: "https://github.com/tutu-ru-mobile/CoreUITestKit",
        from: "0.0.2"
    )
      url: "https://github.com/tutu-ru-mobile/CoreUITestKit", from: "0.0.2")
  ]
)
