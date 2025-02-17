//
//  PerseusGeoStar.swift
//  Version: 1.0.0
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7533 PerseusRealDeal
//
//  All rights reserved.
//
//
//  MIT License
//
//  Copyright © 7531 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7533 PerseusRealDeal
//
//  The year starts from the creation of the world according to a Slavic calendar.
//  September, the 1st of Slavic year.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
// swiftlint:disable file_length
//

import CoreLocation

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

// MARK: - LocationAgent class

public class LocationAgent: NSObject {

    // MARK: - Difficult Dependencies

    public var locationManager: CLLocationManager
    public var notificationCenter: NotificationCenter

    public let alert: ActionAlert

    // MARK: - Calculated Properties

    public var locationPermit: LocationPermit { return locationPermitHidden }

    private var locationPermitHidden: LocationPermit {
        let enabled = type(of: locationManager).locationServicesEnabled()
        let status = type(of: locationManager).authorizationStatus()

        return getPermit(serviceEnabled: enabled, status: status)
    }

    // MARK: - Internal Flags

    internal var order: LocationCommand = .none

    // MARK: - Singleton constructor

    public static let shared: LocationAgent = { return LocationAgent() }()

    private override init() {
        locationManager = CLLocationManager()
        notificationCenter = NotificationCenter.default

        alert = ActionAlert(redirectToSettingsApp)

        super.init()

        locationManager.desiredAccuracy = APPROPRIATE_ACCURACY.rawValue
        locationManager.delegate = self
    }

    // MARK: - Contract

    public static func getNotified(with observer: Any,
                                   selector aSelector: Selector,
                                   name aName: NSNotification.Name?) {
        shared.notificationCenter.addObserver(observer,
                                              selector: aSelector,
                                              name: aName,
                                              object: nil)
    }

    public func requestPermission(_ authorization: LocationPermission = .always,
                                  _ actionIfAlreadyDetermined: ((_ permit: LocationPermit)
                                                         -> Void)? = nil) {
        let permit = locationPermitHidden
        guard permit == .notDetermined else {
            actionIfAlreadyDetermined?(permit)
            return
        }

#if os(iOS)
        switch authorization {
        case .whenInUse:
            locationManager.requestWhenInUseAuthorization()
        case .always:
            locationManager.requestAlwaysAuthorization()
        }
        order = .none
#elseif os(macOS)
        order = .permission
        locationManager.startUpdatingLocation()
#endif
    }

    public func requestCurrentLocation(with accuracy: LocationAccuracy = APPROPRIATE_ACCURACY)
    throws {
        let permit = locationPermitHidden

        guard permit == .allowed else {
            locationManager.stopUpdatingLocation()
            order = .none
            throw LocationError.permissionRequired(permit)
        }

        locationManager.stopUpdatingLocation()

        order = .currentLocation
        locationManager.desiredAccuracy = accuracy.rawValue

#if os(iOS)
        locationManager.requestLocation()
#elseif os(macOS)
        locationManager.startUpdatingLocation()
#endif
    }

    public func startUpdatingLocation(accuracy: LocationAccuracy = APPROPRIATE_ACCURACY)
    throws {
        let permit = locationPermitHidden

        guard permit == .allowed else {
            locationManager.stopUpdatingLocation()
            order = .none
            throw LocationError.permissionRequired(permit)
        }

        order = .locationUpdates

        locationManager.desiredAccuracy = accuracy.rawValue
        locationManager.startUpdatingLocation()
    }

    public func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
        order = .none
    }
}

// MARK: - LocationAgent delegate

extension LocationAgent: CLLocationManagerDelegate {

    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {
        notificationCenter.post(name: .locationDealerStatusChangedNotification, object: status)
    }

    public func locationManager(_ manager: CLLocationManager,
                                didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()

        // ISSUE: macOS (new releases) generates an error on startUpdatingLocation()
        // if a user makes no decision immediately, 2 or 3 sec, with Current Location Diolog.
        // FIXED: Restrict error notifiying in case when a user tries to give a permission
        // so that there is no difference in Current Location Diolog behavior in either early
        // or new macOS releases.

#if os(macOS)
        if order == .permission, locationPermit == .notDetermined { return }
#endif

        order = .none

        let nsError = error as NSError
        let result: LocationError = .failedRequest(error.localizedDescription,
                                                   nsError.domain,
                                                   nsError.code)

        notificationCenter.post(name: .locationDealerErrorNotification, object: result)
    }

    public func locationManager(_ manager: CLLocationManager,
                                didUpdateLocations locations: [CLLocation]) {
        if order == .none {
            locationManager.stopUpdatingLocation()
            return
        }

        if order == .permission {
            locationManager.stopUpdatingLocation()
            order = .none
            return
        }

        if order == .currentLocation {

            locationManager.stopUpdatingLocation()
            order = .none

            let result: Result<PerseusLocation, LocationError> = locations.first == nil ?
                .failure(.receivedEmptyLocationData) :
                .success(locations.first!.perseus)

            notificationCenter.post(name: .locationDealerCurrentNotification, object: result)

        } else if order == .locationUpdates {

            if locations.isEmpty {
                locationManager.stopUpdatingLocation()
                order = .none
            }

            let result: Result<[PerseusLocation], LocationError> = locations.isEmpty ?
                .failure(.receivedEmptyLocationData) : .success(locations.map { $0.perseus })

            notificationCenter.post(name: .locationDealerUpdatesNotification, object: result)
        }
    }
}

// MARK: - ActionAlert class

public struct ActionAlertText {

    public var title: String
    public var message: String
    public var buttonCancel: String
    public var buttonFunction: String

    public init(title: String = "Title",
                message: String = "Message",
                buttonCancel: String = "Cancel",
                buttonFunction: String = "Action") {

        self.title = title
        self.message = message
        self.buttonCancel = buttonCancel
        self.buttonFunction = buttonFunction
    }
}

#if os(iOS)

public class ActionAlert {

    public var titles: ActionAlertText {
        didSet {
            self.alert = create()
        }
    }

    private let action: () -> Void

    private var alert: UIAlertController?

    private var actionFunction: UIAlertAction?
    private var actionCancel: UIAlertAction?

    // MARK: - Initializer

    init(_ function: @escaping () -> Void) {
        action = function
        titles = ActionAlertText()
        alert = create()
    }

    private func create() -> UIAlertController {
        let alert = UIAlertController(title: titles.title,
                                      message: titles.message,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: titles.buttonCancel, style: .cancel))
        alert.addAction(UIAlertAction(title: titles.buttonFunction,
                                      style: .default) { _ in
            self.action()
        })

        return alert
    }

    // MARK: - Contract

    public func show(using parent: UIViewController) {
        if let alert = alert {
            parent.present(alert, animated: true, completion: nil)
        }
    }
}

#elseif os(macOS)

public class ActionAlert {

    public var titles: ActionAlertText {
        didSet {
            self.alert = create()
        }
    }

    private let action: () -> Void

    private var alert: NSAlert?

    // MARK: - Initializer

    init(_ function: @escaping () -> Void) {
        action = function
        titles = ActionAlertText()
        alert = create()
    }

    private func create() -> NSAlert {
        let alert = NSAlert.init()

        alert.alertStyle = .informational

        alert.messageText = titles.title
        alert.informativeText = titles.message

        alert.addButton(withTitle: titles.buttonFunction)
        alert.addButton(withTitle: titles.buttonCancel)

        return alert
    }

    // MARK: - Contract

    public func show() {
        guard let alert = alert, alert.runModal() == .alertFirstButtonReturn else { return }

        action()
    }
}

#endif

// MARK: - PerseusLocation struct

extension CLLocation { public var perseus: PerseusLocation { return PerseusLocation(self) } }

extension Double {

    public enum DecimalPlaces: Double {
        case two  = 100.0
        case four = 10000.0
    }

    public func cut(_ off: DecimalPlaces) -> Double {
        return (self * off.rawValue).rounded(self > 0 ? .down : .up) / off.rawValue
    }
}

public struct PerseusLocation: CustomStringConvertible, Equatable {

    public var description: String {

        let locationTwo = "[\(latitude.cut(.two)), \(longitude.cut(.two))]"

        let latitudeFour = "latitude = \(latitude.cut(.four))"
        let longitudeFour = "longitude = \(longitude.cut(.four))"

        return locationTwo + ": " + latitudeFour + ", " + longitudeFour
    }

    // MARK: - Location Data, As Is

    public let location: CLLocation

    public var latitude: Double { return location.coordinate.latitude }
    public var longitude: Double { return location.coordinate.longitude }

    // MARK: - Initializer

    public init(_ location: CLLocation) {
        self.location = location
    }

    // MARK: - Equatable

    public static func == (lhs: PerseusLocation, rhs: PerseusLocation) -> Bool {
        return lhs.location == rhs.location
    }
}

// MARK: - LocationPermit enum

public enum LocationPermit: CustomStringConvertible {

    public var description: String {
        switch self {
        case .notDetermined:
            return "not determined"
        case .deniedForAllAndRestricted:
            return "denied for all and restricted"
        case .restricted:
            return "restricted"
        case .deniedForAllApps:
            return "denied for all apps"
        case .deniedForTheApp:
            return "denied for the app"
        case .allowed:
            return "allowed"
        }
    }

    // Location service is neither restricted nor the app denided.
    case notDetermined

    // Go to Settings > General > Restrictions.
    // In case if location services turned off and the app restricted.
    case deniedForAllAndRestricted
    // In case if location services turned on and the app restricted.
    case restricted

    // Go to Settings > Privacy.
    // In case if location services turned off but the app not restricted.
    case deniedForAllApps

    // Go to Settings > The App.
    // In case if location services turned on but the app not restricted.
    case deniedForTheApp

    // Either authorizedAlways or authorizedWhenInUse.
    case allowed
}

public func getPermit(serviceEnabled: Bool,
                      status: CLAuthorizationStatus) -> LocationPermit {

    // There is no status .notDetermined with serviceEnabled false.
    if status == .notDetermined { // So, serviceEnabled takes true.
        return .notDetermined
    }

    if status == .denied {
        return serviceEnabled ? .deniedForTheApp : .deniedForAllApps
    }

    if status == .restricted {
        return serviceEnabled ? .restricted : .deniedForAllAndRestricted
    }

    return .allowed
}

// MARK: - LocationPermission enum

public enum LocationPermission: CustomStringConvertible {

    public var description: String {
        switch self {
        case .whenInUse:
            return "When-in-use"
        case .always:
            return "Always"
        }
    }

    case whenInUse
    case always
}

// MARK: - LocationError enum

public enum LocationError: Error, Equatable {

    case permissionRequired(LocationPermit) // Permission status used to make decision.
    case receivedEmptyLocationData
    case failedRequest(String, String, Int) // localizedDescription, domain, code.

    public var failedRequestDetails: (domain: String, code: Int)? {
        switch self {
        case .permissionRequired:
            return nil
        case .receivedEmptyLocationData:
            return nil
        case .failedRequest(_, let domain, let code):
            return (domain: domain, code: code)
        }
    }
}

// MARK: - LocationCommand enum

public enum LocationCommand: CustomStringConvertible {

    public var description: String {
        switch self {
        case .none: // There should be no location notifying activity.
            return "None"
        case .currentLocation:
            return "Current Location"
        case .locationUpdates:
            return "Location Updates"
        case .permission: // Used only to invoke Current Location Diolog on macOS.
            return "Permission"
        }
    }

    case none
    case currentLocation
    case locationUpdates
    case permission
}

// MARK: - LocationAccuracy struct

public struct LocationAccuracy: RawRepresentable, Equatable {

    // MARK: - RawRepresentable

    public var rawValue: CLLocationAccuracy

    // MARK: - Values

    // The highest possible accuracy that uses additional sensor data.
    public static let bestForNavigation = LocationAccuracy(
        rawValue: kCLLocationAccuracyBestForNavigation)

    // The best level of accuracy available.
    public static let best = LocationAccuracy(
        rawValue: kCLLocationAccuracyBest)

    // Accurate to within ten meters of the desired target.
    public static let nearestTenMeters = LocationAccuracy(
        rawValue: kCLLocationAccuracyNearestTenMeters)

    // Accurate to within one hundred meters.
    public static let hundredMeters = LocationAccuracy(
        rawValue: kCLLocationAccuracyHundredMeters)

    // Accurate to the nearest kilometer.
    public static let kilometer = LocationAccuracy(
        rawValue: kCLLocationAccuracyKilometer)

    // Accurate to the nearest three kilometers.
    public static let threeKilometers = LocationAccuracy(
        rawValue: kCLLocationAccuracyThreeKilometers)

    // MARK: - Initializer

    public init(rawValue: CLLocationAccuracy) {
        self.rawValue = rawValue
    }
}

// MARK: - Constants

public let APPROPRIATE_ACCURACY = LocationAccuracy.threeKilometers

// MARK: - Result

public enum Result<Value, Error: Swift.Error> {

    case success(Value)
    case failure(Error)
}

// MARK: - Notifications

extension Notification.Name {

    // Current Location
    public static let locationDealerCurrentNotification =
    Notification.Name("locationDealerCurrentNotification")

    // Location Changing Updates
    public static let locationDealerUpdatesNotification =
    Notification.Name("locationDealerUpdatesNotification")

    // Error
    public static let locationDealerErrorNotification =
    Notification.Name("locationDealerErrorNotification")

    // Location Service Status
    public static let locationDealerStatusChangedNotification =
    Notification.Name("locationDealerStatusChangedNotification")
}

extension CLAuthorizationStatus: CustomStringConvertible {

    public var description: String {
        switch self {
        case .notDetermined:
            return "notDetermined"
        case .restricted:
            return "restricted"
        case .denied:
            return "denied"
        case .authorizedAlways:
            return "authorizedAlways"
        case .authorizedWhenInUse: // iOS only.
            return "authorizedWhenInUse"
        @unknown default:
            return "unknown"
        }
    }
}

// MARK: - Open Settings App function (redirect)

#if os(iOS)

public func redirectToSettingsApp() {

    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
    guard UIApplication.shared.canOpenURL(settingsURL) else { return }

    UIApplication.shared.open(settingsURL)
}

#elseif os(macOS)

public func redirectToSettingsApp() {

    guard let pathURL = URL(string: "x-apple.systempreferences:") else { return }

    NSWorkspace.shared.open(pathURL)
}

#endif
