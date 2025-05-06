//
//  GeoStatus.swift
//  PerseusGeoKit
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 - 7533 Mikhail A. Zhigulin of Novosibirsk
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import Foundation
import CoreLocation

public enum GeoStatus: CustomStringConvertible {

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

    // Not authorized. Neither restricted nor the app denided.
    case notDetermined

    // Go to Settings > General > Restrictions.
    // Location Services turned off and the app restricted.
    case deniedForAllAndRestricted
    // Location Services turned on and the app restricted.
    case restricted

    // Go to Settings > Privacy.
    // Location Services turned off but the app not restricted.
    case deniedForAllApps

    // Go to Settings > The App.
    // Location Services turned on but the app not restricted.
    case deniedForTheApp

    // Authorized. Either authorizedAlways or authorizedWhenInUse.
    case allowed
}

public func getGeoStatus(serviceEnabled: Bool, status: CLAuthorizationStatus) -> GeoStatus {

    // There is no status .notDetermined with serviceEnabled false.
    if status == .notDetermined { // So, it means that serviceEnabled is true for now.
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
