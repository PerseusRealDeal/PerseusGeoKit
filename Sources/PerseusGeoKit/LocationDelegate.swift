//
//  LocationDelegate.swift
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

import CoreLocation

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

// MARK: - Location Delegate

extension GeoAgent: CLLocationManagerDelegate {

    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {

        log.message("[\(type(of: self))].\(#function)")

        notificationCenter.post(name: .locationDealerStatusChangedNotification, object: status)
    }

    public func locationManager(_ manager: CLLocationManager,
                                didFailWithError error: Error) {

        log.message("[\(type(of: self))].\(#function)")

        locationManager.stopUpdatingLocation()

        // ISSUE: macOS (new releases) generates an error on startUpdatingLocation()
        // if a user makes no decision immediately, 2 or 3 sec, with Current Location Diolog.
        // FIXED: Restrict error notifiying in case when a user tries to give a permission
        // so that there is no difference in Current Location Diolog behavior in either early
        // or new macOS releases.

#if os(macOS)
        if order == .permission, geoPermit == .notDetermined {
            let details = "order: \(order), permit: \(geoPermit)"
            log.message("[\(type(of: self))].\(#function) \(details)", .notice)
            return
        }
#endif

        order = .none

        let nsError = error as NSError
        let result: LocationError = .failedRequest(error.localizedDescription,
                                                   nsError.domain,
                                                   nsError.code)

        notificationCenter.post(name: .locationDealerErrorNotification, object: result)
    }

    public func locationManager(_ manager: CLLocationManager,
                                didUpdateLocations locations: [CLLocation]) {

        log.message("[\(type(of: self))].\(#function)")

        if order == .none {
            let notice = "There's no order for locations!"
            log.message("[\(type(of: self))].\(#function) \(notice)", .notice)
            locationManager.stopUpdatingLocation()
            return
        }

        if order == .permission {
            let notice = "The order only for permission!"
            log.message("[\(type(of: self))].\(#function) \(notice)", .notice)
            locationManager.stopUpdatingLocation()
            order = .none
            return
        }

        if order == .currentLocation {

            locationManager.stopUpdatingLocation()
            order = .none

            let result: Result<GeoPoint, LocationError> = locations.first == nil ?
                .failure(.receivedEmptyLocationData) :
                .success(locations.first!.point)

            notificationCenter.post(name: .locationDealerCurrentNotification, object: result)

        } else if order == .locationUpdates {

            if locations.isEmpty {
                log.message("[\(type(of: self))].\(#function) empty locations!", .notice)
                locationManager.stopUpdatingLocation()
                order = .none
            }

            let result: Result<[GeoPoint], LocationError> = locations.isEmpty ?
                .failure(.receivedEmptyLocationData) :
                .success(locations.map { $0.point })

            notificationCenter.post(name: .locationDealerUpdatesNotification, object: result)
        }
    }
}
