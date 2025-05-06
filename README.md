# PerseusGeoKit — Xcode 14.2+

[`iOS approbation app`](https://github.com/perseusrealdeal/TheOneRing) [`macOS approbation app`](https://github.com/perseusrealdeal/Arkenstone)

> Simple Geo API wrapper in Swift for Location Services API. Hereinafter `PGK` stands for `P`erseus `G`eo `K`it.

> - To be informed about current Location Services Access Status.<br/>
> - To request permission for Location Services.<br/>
> - To redirect to system settings app for changing Location Services Access Status.<br/>
> - To get current location and location updates.

> `PGK` is a single author and personale solution developed in `person-to-person` relationship paradigm.

[![Actions Status](https://github.com/perseusrealdeal/PerseusGeoLocationKit/actions/workflows/main.yml/badge.svg)](https://github.com/perseusrealdeal/PerseusGeoKit/actions/workflows/main.yml)
[![Style](https://github.com/perseusrealdeal/PerseusGeoLocationKit/actions/workflows/swiftlint.yml/badge.svg)](https://github.com/perseusrealdeal/PerseusGeoKit/actions/workflows/swiftlint.yml)
[![Version](https://img.shields.io/badge/Version-1.0.0-green.svg)](/CHANGELOG.md)
[![Platforms](https://img.shields.io/badge/Platforms-macOS%2010.13+Cocoa_|_iOS%2011.0+UIKit-orange.svg)](https://en.wikipedia.org/wiki/List_of_Apple_products)
[![Xcode 14.2](https://img.shields.io/badge/Xcode-14.2+-red.svg)](https://en.wikipedia.org/wiki/Xcode)
[![Swift 5.7](https://img.shields.io/badge/Swift-5.7-red.svg)](https://www.swift.org)
[![License](http://img.shields.io/:License-MIT-blue.svg)](/LICENSE)

## Integration Capabilities

[![Standalone](https://img.shields.io/badge/Standalone%20-available-informational.svg)](/PGKStar.swift)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-4BC51D.svg)](/Package.swift)

# Support Code

[![Standalone](https://img.shields.io/badge/Standalone-available-informational.svg)](/PGKSupportingStar.swift)
[![License](http://img.shields.io/:License-Unlicense-green.svg)](http://unlicense.org/)

> [`PGKSupportingStar.swift`](/PGKSupportingStar.swift) is a peace of code a widly helpful in accord with PGK.

> `PGKSupportingStar.swift` goes as an external part of `PGK`.

## Approbation Matrix

> [`A3 Environment and Approbation`](/APPROBATION.md) / [`CHANGELOG`](/CHANGELOG.md) for details.

## In brief > Idea to use, the Why

> HAVE A DEAL WITH WHERE YOU ARE.</br>

> - TODO: screenshots

<table>
  <tr>
    <th>iOS</th>
    <th>macOS</th>
  </tr>
  <tr>
    <td>
        <img src="?" width="200" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/></br>
        <img src="?" width="200" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/>
    </td>
    <td>
        <img src="?" width="200" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/></br>
        <img src="?" width="200" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/>
    </td>
  </tr>
</table>

## Build system requirements

- [macOS Monterey 12.7.6+](https://apps.apple.com/by/app/macos-monterey/id1576738294) / [Xcode 14.2+](https://developer.apple.com/services-account/download?path=/Developer_Tools/Xcode_14.2/Xcode_14.2.xip)

## First-party software

- [ConsolePerseusLogger](https://github.com/perseusrealdeal/ConsolePerseusLogger) / [1.1.0](https://github.com/perseusrealdeal/ConsolePerseusLogger/releases/tag/1.1.0)

## Third-party software

- Style [SwiftLint](https://github.com/realm/SwiftLint) / [Shell Script](/SucceedsPostAction.sh)
- Action [mxcl/xcodebuild@v3](https://github.com/mxcl/xcodebuild/releases/tag/v3.5.1)
- Action [cirruslabs/swiftlint-action@v1](https://github.com/cirruslabs/swiftlint-action/releases/tag/v1.0.0)

# Installation

`Step 1:` Import PGK either with SPM or standalone

> Standalone: the single source code file [PGKStar.swift](/PGKStar.swift)

> Swift Package Manager: `https://github.com/perseusrealdeal/PerseusGeoKit`

`Step 2:` Declare a reference to GeoAgent and register for Geo events

```swift

import Foundation

import ConsolePerseusLogger
import PerseusGeoKit

class GeoCoordinator: NSObject {

    // MARK: - Properties

    public let locationDealer = GeoAgent.shared

    // MARK: - Singletone

    public static let shared: GeoCoordinator = { return GeoCoordinator() }()

    private override init() {

        log.message("[\(GeoCoordinator.self)].\(#function)", .info)

        super.init()

        GeoAgent.register(self, #selector(locationErrorHandler(_:)), .locationError)
        GeoAgent.register(self, #selector(locationStatusHandler(_:)), .locationStatus)
        GeoAgent.register(self, #selector(currentLocationHandler(_:)), .currentLocation)
        GeoAgent.register(self, #selector(locationUpdatesHandler(_:)), .locationUpdates)
    }
}

// MARK: - Event handlers

extension GeoCoordinator {

    @objc private func locationErrorHandler(_ notification: Notification) {
        log.message("[\(type(of: self))].\(#function) [EVENT]", .info)
    }

    @objc private func locationStatusHandler(_ notification: Notification) {
        log.message("[\(type(of: self))].\(#function) [EVENT]", .info)
    }

    @objc private func currentLocationHandler(_ notification: Notification) {
        log.message("[\(type(of: self))].\(#function) [EVENT]", .info)
    }

    @objc private func locationUpdatesHandler(_ notification: Notification) {
        log.message("[\(type(of: self))].\(#function) [EVENT]", .info)
    }
}

```

# Usage

## Get Current Location Services Status

```swift

```

## Request permission for Location Services

```swift

```

## Redirect to system settings app

```swift

```

## Request Current Location

> [!IMPORTANT]
> Method **GeoAgent.requestCurrentLocation()** will stop location updates if started already. You will need to restart location updates.

```swift

```

## Request Location Updates

```swift

```

## Process Geo Events

```swift

```

# Points taken into account

- Preconfigured Swift Package manifest [Package.swift](/Package.swift)
- Preconfigured SwiftLint config [.swiftlint.yml](/.swiftlint.yml)
- Preconfigured SwiftLint CI [swiftlint.yml](/.github/workflows/swiftlint.yml)
- Preconfigured GitHub config [.gitignore](/.gitignore)
- Preconfigured GitHub CI [main.yml](/.github/workflows/main.yml)

# License MIT

Copyright © 7531 - 7533 Mikhail A. Zhigulin of Novosibirsk<br/>
Copyright © 7533 PerseusRealDeal

- The year starts from the creation of the world according to a Slavic calendar.
- September, the 1st of Slavic year. It means that "Sep 01, 2024" is the beginning of 7533.

[LICENSE](/LICENSE) for details.

## Credits

<table>
<tr>
    <td>Balance and Control</td>
    <td>kept by</td>
    <td>Mikhail A. Zhigulin</td>
</tr>
<tr>
    <td>Source Code</td>
    <td>written by</td>
    <td>Mikhail A. Zhigulin</td>
</tr>
<tr>
    <td>Documentation</td>
    <td>prepared by</td>
    <td>Mikhail A. Zhigulin</td>
</tr>
<tr>
    <td>Product Approbation</td>
    <td>tested by</td>
    <td>Mikhail A. Zhigulin</td>
</tr>
</table>

- Language support: [Reverso](https://www.reverso.net/)
- Git clients: [SmartGit](https://syntevo.com/) and [GitHub Desktop](https://github.com/apps/desktop)

# Author

> Mikhail A. Zhigulin of Novosibirsk.
