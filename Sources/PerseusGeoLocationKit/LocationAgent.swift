//
//  LocationAgent.swift
//  PerseusGeoLocationKit
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7533 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import CoreLocation

public class LocationAgent: NSObject {

    // MARK: - Difficult Dependencies

    #if DEBUG
    public var locationManager: LocationManagerProtocol!
    public var notificationCenter: NotificationCenterProtocol!

    internal func resetDefaults() { // Used for keeping test room cleaned only.
        order = .none
        locationManager?.desiredAccuracy = APPROPRIATE_ACCURACY.rawValue
    }
    #else
    public var locationManager: CLLocationManager
    public var notificationCenter: NotificationCenter
    #endif

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

        log.message("[\(LocationAgent.self)].\(#function)", .info)

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
        log.message("[\(type(of: self))].\(#function)")

        shared.notificationCenter.addObserver(observer,
                                              selector: aSelector,
                                              name: aName,
                                              object: nil)
    }

    public func requestPermission(_ authorization: LocationPermission = .always,
                                  _ actionIfAlreadyDetermined: ((_ permit: LocationPermit)
                                                         -> Void)? = nil) {
        log.message("[\(type(of: self))].\(#function)")

        let permit = locationPermitHidden
        guard permit == .notDetermined else {
            log.message("[\(type(of: self))].\(#function) — .\(permit)", .notice)
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
        log.message("[\(type(of: self))].\(#function)")

        let permit = locationPermitHidden

        guard permit == .allowed else {
            log.message("[\(type(of: self))].\(#function) — .\(permit)", .notice)

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
        log.message("[\(type(of: self))].\(#function)")

        let permit = locationPermitHidden

        guard permit == .allowed else {
            log.message("[\(type(of: self))].\(#function) — permit .\(permit)", .notice)

            locationManager.stopUpdatingLocation()
            order = .none

            throw LocationError.permissionRequired(permit)
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
