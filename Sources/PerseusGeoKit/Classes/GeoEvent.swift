//
//  GeoEvent.swift
//  PerseusGeoKit
//
//  Created by Mikhail Zhigulin in 7533 (05.05.2025).
//
//  Copyright © 7531 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7533 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import CoreLocation

public enum GeoEvent: CustomStringConvertible {

    public var description: String {
        switch self {
        case .locationErrorEvent:
            return "locationErrorEvent"
        case .locationStatusEvent:
            return "locationStatusEvent"
        case .currentLocationEvent:
            return "currentLocationEvent"
        case .locationUpdatesEvent:
            return "locationUpdatesEvent"
        }
    }

    public var name: Notification.Name {
        return Notification.Name("\(self)")
    }

    case locationErrorEvent
    case locationStatusEvent
    case currentLocationEvent
    case locationUpdatesEvent
}
