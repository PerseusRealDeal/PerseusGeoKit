//
//  Protocols.swift
//  PerseusGeoLocationKit
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 - 7533 Mikhail A. Zhigulin of Novosibirsk
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import CoreLocation

// These protocols serve only isolation purpose for unit testing.

extension CLLocationManager: LocationManagerProtocol { }
extension NotificationCenter: NotificationCenterProtocol { }

public protocol LocationManagerProtocol {
    var delegate: CLLocationManagerDelegate? { get set }
    var desiredAccuracy: CLLocationAccuracy { get set }

    static func authorizationStatus() -> CLAuthorizationStatus
    static func locationServicesEnabled() -> Bool

    func startUpdatingLocation()
    func stopUpdatingLocation()

    #if os(iOS)
    func requestWhenInUseAuthorization()
    func requestAlwaysAuthorization()
    func requestLocation()
    #endif
}

public protocol NotificationCenterProtocol {
    func post(name aName: NSNotification.Name, object anObject: Any?)
    func addObserver(_ observer: Any,
                     selector aSelector: Selector,
                     name aName: NSNotification.Name?,
                     object anObject: Any?)
}
