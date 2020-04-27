// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

/*
 * Copyright 2019 Google
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import PackageDescription

let package = Package(
  name: "ZipBuilder",
  products: [
    .executable(name: "firebase-pod-updater", targets: ["firebase-pod-updater"]),
    .executable(name: "ReleasePackager", targets: ["ZipBuilder"]),

    // Semantic versioning
    .library(name: "sem-versions", targets: ["sem-versions"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", .exact("0.0.1")),
    // Keep the generated protos in sync with the version below.
    // See https://github.com/firebase/firebase-ios-sdk/tree/master/ZipBuilder#updating-protobuf-generated-swift-files.
    .package(url: "https://github.com/apple/swift-protobuf.git", .exact("1.7.0")),
    .package(url: "https://github.com/kylef/PathKit", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "firebase-pod-updater",
      dependencies: ["ArgumentParser", "ManifestReader"]
    ),
    .target(
      name: "ZipBuilder",
      dependencies: ["ArgumentParser", "ManifestReader", "ShellUtils"]
    ),
    .target(
      name: "ManifestReader",
      dependencies: ["SwiftProtobuf"]
    ),
    .target(name: "ShellUtils"),

    // Semantic versioning
    .target(
      name: "sem-versions",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        "ShellUtils",
        "PathKit",
      ]
    ),
    .testTarget(
      name: "sem-versionsTests",
      dependencies: ["sem-versions"]
    ),
  ]
)
