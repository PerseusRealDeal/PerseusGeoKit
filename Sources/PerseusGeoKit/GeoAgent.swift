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

public let REDIRECT_TEXT_DEFAULT = ActionAlertText(title: "Geo Agent for the App",
                                                   message: "Open System Settings App?",
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

    public static var currentStatus: GeoStatus { return sharedInstance.geoStatus }

    public static var currentAccuracy: GeoAccuracy {
        get {
            return GeoAccuracy(rawValue: sharedInstance.locationManager.desiredAccuracy)
        }
        set {
            accuracy = newValue.rawValue
        }
    }

    // MARK: - Internals

    internal let locationManager: CLLocationManager
    internal let notificationCenter: NotificationCenter

    internal var geoStatus: GeoStatus {

        let enabled = type(of: locationManager).locationServicesEnabled()
        let status = type(of: locationManager).authorizationStatus()

        return getGeoStatus(serviceEnabled: enabled, status: status)
    }

    internal static var accuracy: CLLocationAccuracy {
        get {
            return sharedInstance.locationManager.desiredAccuracy
        }
        set {
            sharedInstance.locationManager.desiredAccuracy = newValue
        }
    }

    internal var order: GeoAgentOrder = .none

    // MARK: - Singletone

    public static var shared: GeoAgent { return sharedInstance }

    private static let sharedInstance = GeoAgent()
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

        let nc = sharedInstance.notificationCenter
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
                                  _ actionIfAlreadyDetermined: ((_ statusUsed: GeoStatus)
                                                         -> Void)? = nil) {

        log.message("[\(type(of: self))].\(#function)")

        let status = geoStatus

        guard status == .notDetermined else {

            log.message("[\(type(of: self))].\(#function) status: \(status)", .notice)

            actionIfAlreadyDetermined?(status)
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

        let status = geoStatus

        guard status == .allowed else {

            log.message("[\(type(of: self))].\(#function) status: \(status)", .notice)

            locationManager.stopUpdatingLocation()
            order = .none

            throw LocationError.permissionRequired(status)
        }

        locationManager.stopUpdatingLocation()

        order = .currentLocation
        locationManager.desiredAccuracy = GeoAgent.accuracy

#if os(iOS)

        locationManager.requestLocation()

#elseif os(macOS)

        locationManager.startUpdatingLocation()

#endif

    }

    public func requestUpdatingLocation() throws {

        log.message("[\(type(of: self))].\(#function)")

        let status = geoStatus

        guard status == .allowed else {

            log.message("[\(type(of: self))].\(#function) status: \(status)", .notice)

            locationManager.stopUpdatingLocation()
            order = .none

            throw LocationError.permissionRequired(status)
        }

        order = .locationUpdates

        locationManager.desiredAccuracy = GeoAgent.accuracy
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
