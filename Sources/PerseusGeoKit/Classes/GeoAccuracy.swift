//
//  GeoAccuracy.swift
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

public struct GeoAccuracy: RawRepresentable, Equatable {

    // MARK: - Values

    // The highest possible accuracy that uses additional sensor data.
    public static let bestForNavigation = setup(kCLLocationAccuracyBestForNavigation)

    // The best level of accuracy available.
    public static let best = setup(kCLLocationAccuracyBest)

    // Accurate to within ten meters of the desired target.
    public static let nearestTenMeters = setup(kCLLocationAccuracyNearestTenMeters)

    // Accurate to within one hundred meters.
    public static let hundredMeters = setup(kCLLocationAccuracyHundredMeters)

    // Accurate to the nearest kilometer.
    public static let kilometer = setup(kCLLocationAccuracyKilometer)

    // Accurate to the nearest three kilometers.
    public static let threeKilometers = setup(kCLLocationAccuracyThreeKilometers)

    // MARK: - RawRepresentable

    public var rawValue: CLLocationAccuracy

    // MARK: - Initializer

    public init(rawValue: CLLocationAccuracy) {
        self.rawValue = rawValue
    }

    public static func setup(_ rawValue: CLLocationAccuracy) -> GeoAccuracy {
        return GeoAccuracy(rawValue: rawValue)
    }
}
