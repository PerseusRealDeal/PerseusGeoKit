# PerseusGeoKit — Xcode 14.2+

> [`iOS approbation app`](https://github.com/perseusrealdeal/TheOneRing) [`macOS approbation app`](https://github.com/perseusrealdeal/Arkenstone)<br/>

> Contains location manager wrapper called as GeoAgent in Swift for Location Services API.<br/>
> Hereinafter `PGK` stands for `P`erseus `G`eo `K`it.<br/>

> - To be awared of Location Services Status.<br/>
> - To request permission for Location Services.<br/>
> - To redirect to System Settings (Preferences).<br/>
> - To get Current Location.<br/>
> - To request Location Updates.

> `PGK` is a single author and personale solution developed in `person-to-person` relationship paradigm.

[![Actions Status](https://github.com/perseusrealdeal/PerseusGeoKit/actions/workflows/main.yml/badge.svg)](https://github.com/perseusrealdeal/PerseusGeoKit/actions/workflows/main.yml)
[![Style](https://github.com/perseusrealdeal/PerseusGeoKit/actions/workflows/swiftlint.yml/badge.svg)](https://github.com/perseusrealdeal/PerseusGeoKit/actions/workflows/swiftlint.yml)
[![Version](https://img.shields.io/badge/Version-1.0.1-green.svg)](/CHANGELOG.md)
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

> PGKSupportingStar.swift goes as an external part of PGK.

## Approbation Matrix

> [`A3 Environment and Approbation`](/APPROBATION.md) / [`CHANGELOG`](/CHANGELOG.md) for details.

## In brief > Idea to use, the Why

> HAVE A DEAL WITH WHERE YOU ARE.</br>

<table>
  <tr>
    <th>Approbation App: iOS 16.2</th>
    <th>Approbation App: macOS Monterey</th>
  </tr>
  <tr>
    <td>
        <img src="https://github.com/user-attachments/assets/1df511f6-40af-4679-a9e0-5d203f7ad740" width="350" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/></br>
        The Current Location Dialog</br>
        <img src="https://github.com/user-attachments/assets/42d00202-1626-44c5-9e3d-a6ffcd10ecf3" width="350" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/></br>
        The Redirect Dialog</br>
        <img src="https://github.com/user-attachments/assets/20afa708-7158-47e2-887e-af322b3592c8" width="350" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/></br>
        System Services</br>
        <img src="https://github.com/user-attachments/assets/9f344e74-8d47-4986-b2a8-700456c7937c" width="350" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/>
    </td>
    <td>
        <img src="https://github.com/user-attachments/assets/80834192-5d26-4d04-8aeb-f2fb3438232b" width="450" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/></br>
        The Current Location Dialog</br>
        <img src="https://github.com/user-attachments/assets/707bc81c-7f15-4e85-870b-0ada69785585" width="450" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/></br>
        System Services and The Redirect Dialog</br>
        <img src="https://github.com/user-attachments/assets/0a85f2ef-4cd0-4d90-8d8c-555f2a7ec1c0" width="450" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/>
    </td>
  </tr>
</table>

> [!NOTE]
> [`The iOS App`](https://github.com/perseusrealdeal/TheOneRing) scenes taken from the motion picture `The Lord of The Rings` based on the novel by J.R.R. Tolkien.</br>
> [`The macOS App`](https://github.com/perseusrealdeal/Arkenstone) scenes taken from the motion picture `The Hobbit` based on the novel by J.R.R. Tolkien.

## Build system requirements

- [macOS Monterey 12.7.6+](https://apps.apple.com/by/app/macos-monterey/id1576738294) / [Xcode 14.2+](https://developer.apple.com/services-account/download?path=/Developer_Tools/Xcode_14.2/Xcode_14.2.xip)

## First-party software

- [ConsolePerseusLogger](https://github.com/perseusrealdeal/ConsolePerseusLogger) / [1.3.0](https://github.com/perseusrealdeal/ConsolePerseusLogger/releases/tag/1.3.0)

## Third-party software

- Style [SwiftLint](https://github.com/realm/SwiftLint) / [Shell Script](/SucceedsPostAction.sh)
- Action [mxcl/xcodebuild@v3](https://github.com/mxcl/xcodebuild/releases/tag/v3.5.1)
- Action [cirruslabs/swiftlint-action@v1](https://github.com/cirruslabs/swiftlint-action/releases/tag/v1.0.0)

# Installation

`Step 1:` Import PGK either with SPM or standalone.

> Standalone: the single source code file [PGKStar.swift](/PGKStar.swift)

> Swift Package Manager: `https://github.com/perseusrealdeal/PerseusGeoKit`

`Step 2:` Change `Info.plist`, add the following items:

| iOS                                        | macOS                    |
|:-------------------------------------------|:-------------------------|
|NSLocationAlwaysAndWhenInUseUsageDescription|NSLocationUsageDescription|
|NSLocationWhenInUseUsageDescription         |                          |

`Step 3, macOS:` Tap `Location` in `App Sandbox` of your project target.

# Usage

## Get Location Services Status

Location Services Status is calculated as a unified value for both iOS and macOS.

```swift

let status = GeoAgent.currentStatus
let statusInDetail = GeoAgent.aboutLocationServices().inDetail

```

| Status        | Status in Detail        | Description                                            |
|:--------------|:-------------------------|:-------------------------------------------------------|
|.notDetermined |.notDetermined            |Not Authorized. Neither restricted nor the app denided. |
|.notAllowed    |.deniedForAllAndRestricted|Location Services turned off and the app restricted.    |
|.notAllowed    |.restricted               |Location Services turned on and the app restricted.     |
|.notAllowed    |.deniedForAllApps         |Location Services turned off but the app not restricted.|
|.notAllowed    |.deniedForTheApp          |Location Services turned on but the app not restricted. |
|.allowed       |.allowed                  |Authorized.                                             |

> [!IMPORTANT]
> To be awared of Location Services Status changes, register:

```swift

GeoAgent.register(self, #selector(locationStatusHandler(_:)), .locationStatus)

```

```swift

@objc private func locationStatusHandler(_ notification: Notification) { 
    // Location Status Change Handler. 
}

```

## Request Permission

Statement **GeoAgent.requestPermission()** can be combined with the action to be called if status has already determined. 

For instance, to open The Redirect Dialog.

```swift

GeoAgent.shared.requestPermission { status in 

    // Run if status not .notDetermined. 

    if status != .allowed {
        GeoAgent.showRedirectAlert() // The Redirect Dialog.
    }
}

```
> [!NOTE]
> Custom Text for The Redirect Dialog:

```swift

let REDIRECT_ALERT_TITLES = ActionAlertText(title: "The Redirect Dialog",
                                            message: "Custom Message",
                                            buttonCancel: "OK",
                                            buttonFunction: "System Services")

GeoAgent.showRedirectAlert(REDIRECT_ALERT_TITLES)

```

> [!NOTE]
> `iOS:` The Redirect Dialog by **GeoAgent.showRedirectAlert(vc)** requires the parent ViewController.

```swift

GeoAgent.shared.requestPermission { status in
    if status != .allowed, let vc = self.parentViewController() {
        GeoAgent.showRedirectAlert(vc)
    }
}

```

## Request Current Location

> [!WARNING]
> Statement **GeoAgent.shared.requestCurrentLocation()** causes stop updating location.

`Step 1:` Register for Geo events both error and current location.

```swift

GeoAgent.register(self, #selector(locationErrorHandler(_:)), .locationError)
GeoAgent.register(self, #selector(currentLocationHandler(_:)), .currentLocation)

```

`Step 2:` Set required accuracy up.

```swift

GeoAgent.currentAccuracy = .threeKilometers

```

`Step 3:` Use **GeoAgent.shared.requestCurrentLocation()**.

```swift

do {
    try GeoAgent.shared.requestCurrentLocation()
} catch LocationError.permissionRequired(let status) { // Permission required.

    if status == .notDetermined {
        GeoAgent.shared.requestPermission() // Request permission.
    } else {
        GeoAgent.showRedirectAlert() // Offer redirect.
    }

} catch {
    // Something went wrong.
}

```

## Request Updating Location

`Step 1:` Register for Geo events both error and updating location.

```swift

GeoAgent.register(self, #selector(locationErrorHandler(_:)), .locationError)
GeoAgent.register(self, #selector(locationUpdatesHandler(_:)), .locationUpdates)

```

`Step 2:` Set required accuracy up.

```swift

GeoAgent.currentAccuracy = .threeKilometers

```

`Step 3:` Use **GeoAgent.shared.requestUpdatingLocation()**.

```swift

do {
    try GeoAgent.shared.requestUpdatingLocation()
} catch LocationError.permissionRequired(let status) { // Permission required.

    if status == .notDetermined {
        GeoAgent.shared.requestPermission() // Request permission.
    } else {
        GeoAgent.showRedirectAlert() // Offer redirect.
    }

} catch {
    // Something went wrong.
}

```

> [!IMPORTANT]
> Statement **GeoAgent.shared.stopUpdatingLocation()** to stop updating location.

```swift

GeoAgent.shared.stopUpdatingLocation()

```

## Geo Events Processing

`Event: Location Error`

> Register first.

```swift

GeoAgent.register(self, #selector(locationErrorHandler(_:)), .locationError)

```

> Handle event.

```swift

@objc private func locationErrorHandler(_ notification: Notification) {

    log.message("[\(type(of: self))].\(#function) [EVENT]")
    var errtext = ""

    guard let error = notification.object as? LocationError else {
        errtext = "nothing is about error"
        log.message("[\(type(of: self))].\(#function) \(errtext)", .error)
        return
    }

    switch error {
    case .failedRequest(let desc, let domain, let code):
        let domaincode = "domain: \(domain), code: \(code)"
        if desc.contains("[NOTKNOWN]") {
            errtext = "\(desc), \(domaincode)"
        } else {
            switch code {
            case 0:
                errtext = "hardware issue: try to tap Wi-Fi in system tray, \(domaincode)"
            case 1:
                errtext = "permission required, \(domaincode)"
            default:
                break
            }
        }
    default:
        break
    }

    log.message("[\(type(of: self))].\(#function) \(errtext)", .error)

    // Any changes.
}

```

`Event: Location Status`

> Register first.

```swift

GeoAgent.register(self, #selector(locationStatusHandler(_:)), .locationStatus)

```

> Handle event.

```swift

@objc private func locationStatusHandler(_ notification: Notification) {

    let currentStatus = GeoAgent.currentStatus
    log.message("[\(type(of: self))].\(#function) status: \(status) [EVENT]")
    
    // Current Status is here, it's always actual value. Any changes.
}

```

`Event: Current Location`

> Register first.

```swift

GeoAgent.register(self, #selector(currentLocationHandler(_:)), .currentLocation)

```

> Handle event.

```swift

@objc private func currentLocationHandler(_ notification: Notification) {
    
    log.message("[\(type(of: self))].\(#function) [EVENT]")

    var errtext = ""
    var location: GeoPoint?

    guard let result = notification.object as? Result<GeoPoint, LocationError> else {
        errtext = "nothing is about location"
        log.message("[\(type(of: self))].\(#function) \(errtext)", .error)
        return
    }

    switch result {
    case .success(let point):
        location = point
    case .failure(let error):
        errtext = "\(error)"
    }

    if let current = location {

        // Current location is here! Any changes.

    } else if !errtext.isEmpty {
        log.message("[\(type(of: self))].\(#function) \(errtext)", .error)
    }
}

```

`Event: Location Updates`

> Register first.

```swift

GeoAgent.register(self, #selector(locationUpdatesHandler(_:)), .locationUpdates)

```

> Handle event.

```swift

@objc private func locationUpdatesHandler(_ notification: Notification) {
    
    log.message("[\(type(of: self))].\(#function) [EVENT]")

    var errtext = ""
    var updates: [GeoPoint]?

    guard let result = notification.object as? Result<[GeoPoint], LocationError> else {
        errtext = "nothing is about location updates"
        log.message("[\(type(of: self))].\(#function) \(errtext)", .error)
        return
    }

    switch result {
    case .success(let points):
        updates = points
    case .failure(let error):
        errtext = "\(error)"
    }

    if let locations = updates {

        // Location updates are here! Any changes.

    } else if !errtext.isEmpty {
        log.message("[\(type(of: self))].\(#function) \(errtext)", .error)
    }
}

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
