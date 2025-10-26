//
//  GeoEvent.swift
//  PerseusGeoKit
//
//  Created by Mikhail Zhigulin in 7533 (05.05.2025).
//
//  Copyright © 7531 - 7534 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7533 - 7534 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import Foundation

public enum GeoEvent: CustomStringConvertible {

    public var description: String {
        switch self {
        case .locationError:
            return "locationErrorEvent"
        case .locationStatus:
            return "locationStatusEvent"
        case .currentLocation:
            return "currentLocationEvent"
        case .locationUpdates:
            return "locationUpdatesEvent"
        }
    }

    public var name: Notification.Name {
        return Notification.Name("\(self)")
    }

    case locationError
    case locationStatus
    case currentLocation
    case locationUpdates
}
