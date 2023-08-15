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
  ]
)
