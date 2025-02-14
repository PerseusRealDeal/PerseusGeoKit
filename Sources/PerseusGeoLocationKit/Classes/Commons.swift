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

    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
        log.message("\(#function) - URL not good", .error)
        return
    }

    guard UIApplication.shared.canOpenURL(settingsURL) else {
        log.message("\(#function) - Right URL, but cann't be opened", .error)
        return
    }

    UIApplication.shared.open(settingsURL) { (opened) in
        if opened {
            log.message("\(#function) - opened")
        } else {
            log.message("\(#function) - not opened", .error)
        }
    }
}

#elseif os(macOS)

public func redirectToSettingsApp() {

    guard let pathURL = URL(string: "x-apple.systempreferences:")
    else {
        log.message("\(#function) - URL not good", .error)
        return
    }

    if NSWorkspace.shared.open(pathURL) {
        log.message("\(#function) - opened")
    } else {
        log.message("\(#function) - not opened", .error)
    }
}

#endif
