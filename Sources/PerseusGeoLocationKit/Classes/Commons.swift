//
//  Commons.swift
//  PerseusGeoLocationKit
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 - 7533 Mikhail A. Zhigulin of Novosibirsk
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

import CoreLocation

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
            log.message("Unknown CLAuthorizationStatus \(self)", .error)
            // fatalError("Unknown CLAuthorizationStatus \(self)")
            return "unknown"
        }
    }
}

// MARK: - Open Settings App function

#if os(iOS)

public func redirectToSettingsApp() {

    log.message("\(#function)", .info)

    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
        log.message("\(#function) : URL no good", .error)
        return
    }

    guard UIApplication.shared.canOpenURL(settingsURL) else {
        log.message("\(#function) : URL cann't be opened", .error)
        return
    }

    UIApplication.shared.open(settingsURL) { (opened) in
        let result = opened == true ? "opened" : "not opened"
        log.message("\(#function) : \(result)", .info)
    }
}

#elseif os(macOS)

public let systemApp = "x-apple.systempreferences:"

public func redirectToSettingsApp() {

    log.message("\(#function)", .info)

    guard let pathURL = URL(string: systemApp)
    else {
        log.message("\(#function)", .error)
        return
    }

    NSWorkspace.shared.open(pathURL)
}

#endif
