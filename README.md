<div align="center">

Perseus Geo Kit
==

HAVE A DEAL WITH WHERE YOU ARE

[![Actions Status](https://github.com/perseusrealdeal/PerseusGeoKit/actions/workflows/main.yml/badge.svg)](https://github.com/perseusrealdeal/PerseusGeoKit/actions/workflows/main.yml)
[![Style](https://github.com/perseusrealdeal/PerseusGeoKit/actions/workflows/swiftlint.yml/badge.svg)](https://github.com/perseusrealdeal/PerseusGeoKit/actions/workflows/swiftlint.yml)
[![Version](https://img.shields.io/badge/Version-1.2.0-green.svg)](/CHANGELOG.md)
[![Platforms](https://img.shields.io/badge/Platforms-macOS%2010.13+_|_iOS%2011.0+-orange.svg)](https://en.wikipedia.org/wiki/List_of_Apple_products)
[![Xcode 14.2](https://img.shields.io/badge/Xcode-14.2+-red.svg)](https://en.wikipedia.org/wiki/Xcode)
[![Swift 5.7](https://img.shields.io/badge/Swift-5.7-red.svg)](https://www.swift.org)

[`A3 Environment`](/APPROBATION.md) • [`CHANGELOG`](/CHANGELOG.md) • [`MIT License`](/LICENSE)

</div>

---

Usages
==

> `1:` Be awared of Location Services Status.<br/>
> `2:` Request permission for Location Services.<br/>
> `3:` Redirect to System Settings (Preferences).<br/>
> `4:` Get Current Location.<br/>
> `5:` Request Location Updates.

Integration
==

[![Standalone](https://img.shields.io/badge/Standalone%20-available-informational.svg)](/TheGeoStar.swift)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-4BC51D.svg)](/Package.swift)

Dependencies
==

[![ConsolePerseusLogger](http://img.shields.io/:ConsolePerseusLogger-1.7.1-green.svg)](https://github.com/perseusrealdeal/ConsolePerseusLogger.git)

Support Code
==

[![Standalone](https://img.shields.io/badge/Standalone-available-informational.svg)](/Sources/PerseusGeoKit/TheGeoSupport.swift)
[![License](http://img.shields.io/:License-Unlicense-green.svg)](http://unlicense.org/)

> [`TheGeoSupport.swift`](/Sources/PerseusGeoKit/TheGeoSupport.swift) is a peace of code a widly helpful in accord with `PGK`.

PGK in Use
==

> `Approbation:` 

- [`Swift macOS app`](https://github.com/perseusrealdeal/Arkenstone) 
- [`Swift iOS app`](https://github.com/perseusrealdeal/TheOneRing)

> `Business:` 

- Swift macOS app [`The Dark Moon`](https://github.com/perseusrealdeal/TheDarkMoon)

Contents
==

* [In brief](#In-brief)
* [Requirements](#Requirements)
* [First-party software](#First-party-software)
* [Third-party software](#Third-party-software)
* [Installation](#Installation)
* [Usage](#Usage)
    * [Get location services status](#Get-location-services-status)
    * [Request permission](#Request-permission)
    * [Request current location](#Request-current-location)
    * [Request updating location](#Request-updating-location)
    * [Geo events processing](#Geo-events-processing)
        * [Location error](#Location-error)
        * [Location status](#Location-status)
        * [Current location](#Current-location)
        * [Location updates](#Location-updates)
* [Account points](#Account-points)
* [License](#License)
    * [Other required licenses details](#Other-required-licenses-details)
* [Credits](#Credits)
* [Contributing](#Contributing)
* [Author](#Author)
    * [Contact](#Contact)

Our Terms
--

| Acronym | Stands for                                                                                                |
| :-----: | --------------------------------------------------------------------------------------------------------- |
| CPL     | [Console_Perseus_Logger](https://github.com/perseusrealdeal/ConsolePerseusLogger.git)                     |
| PDM     | [Perseus_Dark_Mode](https://github.com/perseusrealdeal/PerseusDarkMode.git)                               |
| PGK     | [Perseus_Geo_Kit](https://github.com/perseusrealdeal/PerseusGeoKit.git)                                   |
| A3      | [Apple_Apps_Approbation](https://docs.google.com/document/d/1K2jOeIknKRRpTEEIPKhxO2H_1eBTof5uTXxyOm5g6nQ) |
| T3      | [The_Technological_Tree](https://github.com/perseusrealdeal/TheTechnologicalTree)                         |
| P2P     | Person_to_Person                                                                                          |

In brief
==

The great home-made product for easily managed `Location Services API`. `PGK` is a single author and personale solution developed in `P2P` relationship paradigm.

<table>
  <tr>
    <th>macOS app</th>
    <th>iOS app</th>
  </tr>
  <tr>
    <td>
        <img src="https://github.com/user-attachments/assets/80834192-5d26-4d04-8aeb-f2fb3438232b" width="450" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/></br>
        The Current Location Dialog</br>
        <img src="https://github.com/user-attachments/assets/707bc81c-7f15-4e85-870b-0ada69785585" width="450" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/></br>
        System Services and The Redirect Dialog</br>
        <img src="https://github.com/user-attachments/assets/0a85f2ef-4cd0-4d90-8d8c-555f2a7ec1c0" width="450" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/>
    </td>
    <td>
        <img src="https://github.com/user-attachments/assets/1df511f6-40af-4679-a9e0-5d203f7ad740" width="350" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/></br>
        The Current Location Dialog</br>
        <img src="https://github.com/user-attachments/assets/42d00202-1626-44c5-9e3d-a6ffcd10ecf3" width="350" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/></br>
        The Redirect Dialog</br>
        <img src="https://github.com/user-attachments/assets/20afa708-7158-47e2-887e-af322b3592c8" width="350" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/></br>
        System Services</br>
        <img src="https://github.com/user-attachments/assets/9f344e74-8d47-4986-b2a8-700456c7937c" width="350" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/>
    </td>
  </tr>
</table>

> [!IMPORTANT]
> [`The macOS App`](https://github.com/perseusrealdeal/Arkenstone) scenes taken from the motion picture `The Hobbit` based on the novel by J.R.R. Tolkien.</br>
> [`The iOS App`](https://github.com/perseusrealdeal/TheOneRing) scenes taken from the motion picture `The Lord of The Rings` based on the novel by J.R.R. Tolkien.

Requirements
==

`To build:`

- [macOS Monterey 12.7.6+](https://apps.apple.com/by/app/macos-monterey/id1576738294)
- [Xcode 14.2+](https://developer.apple.com/services-account/download?path=/Developer_Tools/Xcode_14.2/Xcode_14.2.xip)

First-party software
==

MIT
--

| Type   | Name                                                                                                                                                                  |
| ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Star   | [ConsolePerseusLogger](https://github.com/perseusrealdeal/ConsolePerseusLogger) / [1.7.1](https://github.com/perseusrealdeal/ConsolePerseusLogger/releases/tag/1.7.1) |

Third-party software
==

MIT
--

| Type   | Name                                                                                                                              |
| ------ | --------------------------------------------------------------------------------------------------------------------------------- |
| Style  | [SwiftLint](https://github.com/realm/SwiftLint) / [v0.57.0 for Monterey+](https://github.com/realm/SwiftLint/releases/tag/0.57.0) |
| Script | [SwiftLint Shell Script](/SucceedsPostAction.sh) to run SwiftLint                                                                 |
| Action | [cirruslabs/swiftlint-action@v1](https://github.com/cirruslabs/swiftlint-action/)                                                 |

[Unlicense](https://unlicense.org)
--

| Type   | Name                                                                                                                              |
| ------ | --------------------------------------------------------------------------------------------------------------------------------- |
| Action | [mxcl/xcodebuild@v3](https://github.com/mxcl/xcodebuild)                                                                          |

Installation
==

`Step 1:` Import PGK either with SPM or standalone.

> Standalone: the single source code file [TheGeoStar.swift](/TheGeoStar.swift)

> Swift Package Manager: `https://github.com/perseusrealdeal/PerseusGeoKit`

`Step 2:` Change `Info.plist`, add the following items:

| iOS                                        | macOS                    |
|:-------------------------------------------|:-------------------------|
|NSLocationAlwaysAndWhenInUseUsageDescription|NSLocationUsageDescription|
|NSLocationWhenInUseUsageDescription         |                          |

`Step 3, macOS:` Tap `Location` in `App Sandbox` of your project target.

Usage
==

Get location services status
--

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

> [!NOTE]
> To be awared of Location Services Status changes, register:

```swift

GeoAgent.register(self, #selector(locationStatusHandler(_:)), .locationStatus)

```

```swift

@objc private func locationStatusHandler(_ notification: Notification) { 
    // Location Status Change Handler. 
}

```

Request permission
--

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

> [!IMPORTANT]
> `iOS:` The Redirect Dialog by **GeoAgent.showRedirectAlert(vc)** requires the parent ViewController.

```swift

GeoAgent.shared.requestPermission { status in
    if status != .allowed, let vc = self.parentViewController() {
        GeoAgent.showRedirectAlert(vc)
    }
}

```

Request current location
--

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

Request updating location
--

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

Geo events processing
--

### Location error

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

### Location status

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

### Current location

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

### Location updates

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

Account points
==

- Preconfigured Swift Package manifest [Package.swift](/Package.swift)
- Preconfigured SwiftLint config [.swiftlint.yml](/.swiftlint.yml)
- Preconfigured SwiftLint CI [swiftlint.yml](/.github/workflows/swiftlint.yml)
- Preconfigured GitHub config [.gitignore](/.gitignore)
- Preconfigured GitHub CI [main.yml](/.github/workflows/main.yml)
- [Changelog](/CHANGELOG.md)
- [A3 environment specification](/APPROBATION.md)
- [SwiftLint shell script](/SucceedsPostAction.sh)

License
==

`MIT License`, see [LICENSE](/LICENSE) for details.

Copyright © 7531 - 7534 Mikhail A. Zhigulin of Novosibirsk<br/>
Copyright © 7533 - 7534 PerseusRealDeal

- The year starts from the creation of the world according to a Slavic calendar.
- September, the 1st of Slavic year. For instance, "Sep 01, 2025" is the beginning of 7534.

Other required licenses details
--

`© 2025 The SwiftLint Contributors` **for** SwiftLint</br>
`© GitHub` **for** GitHub Action cirruslabs/swiftlint-action@v1</br>
`© 2021 Alexandre Colucci, geteimy.com` **for** Shell Script SucceedsPostAction.sh</br>

Credits
==

<table>
  <tr>
      <td>Balance and Control</td>
      <td>Mikhail Zhigulin</td>
  </tr>
  <tr>
      <td>Source Code</td>
      <td>Mikhail Zhigulin</td>
  </tr>
  <tr>
      <td>Documentation</td>
      <td>Mikhail Zhigulin</td>
  </tr>
  <tr>
      <td>Approbation</td>
      <td>Mikhail Zhigulin</td>
  </tr>
  <tr>
      <td>English</td>
      <td>Mikhail Zhigulin</td>
  </tr>
</table>

- Language support: [Reverso](https://www.reverso.net/)
- Git clients: [SmartGit](https://syntevo.com/) and [GitHub Desktop](https://github.com/apps/desktop)

Contributing
==

> [!NOTE]
> The product is constructed in `P2P` relationship paradigm that means the only one single and the same face in the product team during all development process stages.

`Bug reports are welcome`, create an issue and give details.

Author
==

<div align="center">

`© Mikhail A. Zhigulin of Novosibirsk`

</div>

Contact
--

<div align="center">

[E-mail](mailto:mzhigulin@gmail.com) • [Telegram](https://t.me/velociraptor1985) • [GitHub](https://github.com/perseusrealdeal)

</div>
