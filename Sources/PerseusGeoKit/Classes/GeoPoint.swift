//
//  GeoPoint.swift
//  PerseusGeoKit
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 - 7534 Mikhail A. Zhigulin of Novosibirsk
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

import CoreLocation

extension CLLocation {
    public var point: GeoPoint {
        return GeoPoint(self)
    }
}

public struct GeoPoint: CustomStringConvertible, Equatable {

    public var description: String {
        /*
        let locationTwo = "[\(latitude.cut(.two)), \(longitude.cut(.two))]"

        let latitudeFour = "latitude = \(latitude.cut(.four))"
        let longitudeFour = "longitude = \(longitude.cut(.four))"

        return locationTwo + ": \(latitudeFour), \(longitudeFour)"
        */
        return "\(latitude.cut(.four)), \(longitude.cut(.four))"
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

    public static func == (lhs: GeoPoint, rhs: GeoPoint) -> Bool {
        return lhs.location == rhs.location
    }
}

extension Double {

    public enum DecimalPlaces: Double { // Mathematical precision.
        case two  = 100.0
        case four = 10000.0
    }

    public func cut(_ off: DecimalPlaces) -> Double {
        return (self * off.rawValue).rounded(self > 0 ? .down : .up) / off.rawValue
    }
}
