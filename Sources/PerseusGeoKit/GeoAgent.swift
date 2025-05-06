//
//  GeoAgent.swift
//  PerseusGeoKit
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7533 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//
// swiftlint:disable file_length
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

import CoreLocation

// MARK: - Constants

public let APPROPRIATE_ACCURACY_DEFAULT = GeoAccuracy.threeKilometers

public let REDIRECT_TEXT_DEFAULT = ActionAlertText(title: "Geo Agent",
                                                   message: "Open Settings.app?",
                                                   buttonCancel: "Cancel",
                                                   buttonFunction: "Open")

// MARK: - Geo Agent

public class GeoAgent: NSObject {

    // MARK: - Specifics

    internal enum GeoAgentOrder: CustomStringConvertible {

        public var description: String {
            switch self {
            case .none: // There should be no location notifying activity.
                return "none"
            case .currentLocation:
                return "current location"
            case .locationUpdates:
                return "location updates"
            case .permission: // Used to invoke Current Location Diolog on macOS only.
                return "permission"
            }
        }

        case none
        case currentLocation
        case locationUpdates
        case permission
    }

    // MARK: - Properties

    public var permit: GeoPermit { return geoPermit }

    public var accuracy: GeoAccuracy {
        get {
            return GeoAccuracy(rawValue: locationManager.desiredAccuracy)
        }
        set {
            locationManager.desiredAccuracy = newValue.rawValue
        }
    }

    // MARK: - Internals

    internal let locationManager: CLLocationManager
    internal let notificationCenter: NotificationCenter

    internal var geoPermit: GeoPermit {

        let enabled = type(of: locationManager).locationServicesEnabled()
        let status = type(of: locationManager).authorizationStatus()

        return getPermit(serviceEnabled: enabled, status: status)
    }

    internal var order: GeoAgentOrder = .none

    // MARK: - Singletone

    public static let shared = GeoAgent()
    private override init() {

        log.message("[\(GeoAgent.self)].\(#function)", .info)

        locationManager = CLLocationManager()
        notificationCenter = NotificationCenter.default

        super.init()

        locationManager.desiredAccuracy = APPROPRIATE_ACCURACY_DEFAULT.rawValue
        locationManager.delegate = self
    }

    // MARK: - Contract

    public static func register(_ stakeholder: Any, _ selector: Selector, _ event: GeoEvent) {

        let detail = "for \(type(of: stakeholder)) > \(event)"
        log.message("[\(type(of: self))].\(#function) \(detail)")

        let nc = shared.notificationCenter
        nc.addObserver(stakeholder, selector: selector, name: event.name, object: nil)
    }

#if os(iOS)

    public static func showRedirectAlert(_ parentViewController: UIViewController,
                                         _ titles: ActionAlertText = REDIRECT_TEXT_DEFAULT) {

        log.message("[\(type(of: self))].\(#function)")

        ActionAlert(redirectToSettingsApp, titles).show(using: parentViewController)
    }

#elseif os(macOS)

    public static func showRedirectAlert(_ titles: ActionAlertText = REDIRECT_TEXT_DEFAULT) {

        log.message("[\(type(of: self))].\(#function)")

        ActionAlert(redirectToSettingsApp, titles).show()
    }

#endif

    public func requestPermission(_ authorization: LocationPermissionRequest = .always,
                                  _ actionIfAlreadyDetermined: ((_ permitUsed: GeoPermit)
                                                         -> Void)? = nil) {

        log.message("[\(type(of: self))].\(#function)")

        let currentPermit = geoPermit

        guard currentPermit == .notDetermined else {

            log.message("[\(type(of: self))].\(#function) permit: \(currentPermit)", .notice)

            actionIfAlreadyDetermined?(currentPermit)
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

    public func requestCurrentLocation() throws {

        log.message("[\(type(of: self))].\(#function)")

        let currentPermit = geoPermit

        guard currentPermit == .allowed else {

            log.message("[\(type(of: self))].\(#function) permit: \(currentPermit)", .notice)

            locationManager.stopUpdatingLocation()
            order = .none

            throw LocationError.permissionRequired(currentPermit)
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

    public func requestLocationUpdates() throws {

        log.message("[\(type(of: self))].\(#function)")

        let currentPermit = geoPermit

        guard currentPermit == .allowed else {

            log.message("[\(type(of: self))].\(#function) permit: \(currentPermit)", .notice)

            locationManager.stopUpdatingLocation()
            order = .none

            throw LocationError.permissionRequired(currentPermit)
        }

        order = .locationUpdates

        locationManager.desiredAccuracy = accuracy.rawValue
        locationManager.startUpdatingLocation()
    }

    public func stopUpdatingLocation() {

        log.message("[\(type(of: self))].\(#function)")

        locationManager.stopUpdatingLocation()
        order = .none
    }
}

// MARK: - Helpers

public enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
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
            log.message("Unknown CLAuthorizationStatus \(self)", .error)
            // fatalError("Unknown CLAuthorizationStatus \(self)")
            return "unknown"
        }
    }
}
