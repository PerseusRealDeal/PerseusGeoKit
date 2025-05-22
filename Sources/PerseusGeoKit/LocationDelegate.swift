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

// MARK: - CLLocationManagerDelegate

extension GeoAgent: CLLocationManagerDelegate {

    // MARK: - To catch location service error

    public func locationManager(_ manager: CLLocationManager,
                                didFailWithError error: Error) {

        log.message("[\(type(of: self))].\(#function)")

#if targetEnvironment(simulator)

        let notice = "order: \(order), status: \(geoStatus)"
        log.message("[\(type(of: self))].\(#function) \(notice)", .error)

        return

#else

        // locationManager.stopUpdatingLocation()

#endif

        // ISSUE: macOS (new releases) generates an error on startUpdatingLocation() if
        // an end-user makes no decision about permission immediately, 2 or 3 sec.
        // FIXED: In case if an end-user tries to give a permission not immediately,
        // restrict error notifiying so that there is no difference
        // in Current Location Diolog behavior in either early or newer macOS releases.

#if os(macOS)

        if order == .permission, geoStatus == .notDetermined {

            locationManager.stopUpdatingLocation()
            order = .none

            // It means that an end-user took more than 2 or 3 sec to make decision.
            // Does nothing, just a note.

            // List of macOS systems:
            // Starting from macOS Ventura than Sonoma, Sequoia systems.

            let notice = "order: .permission, status: .notDetermined"
            log.message("[\(type(of: self))].\(#function) \(notice)", .notice)

            return
        }

#endif

        // order = .none

        let nsError = error as NSError
        let result: LocationError = .failedRequest(error.localizedDescription,
                                                   nsError.domain,
                                                   nsError.code)

        notificationCenter.post(name: GeoEvent.locationError.name, object: result)
    }

    // MARK: - To catch location status change

    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {

        log.message("[\(type(of: self))].\(#function) status: \(status)")

        var auth = status

        if #available(macOS 13.7, *) {
            if status == .notDetermined {
                reInitLocationManager()
                auth = type(of: locationManager).authorizationStatus()
            }
        }

        notificationCenter.post(name: GeoEvent.locationStatus.name, object: auth)
    }

    // MARK: - To catch current location and updates

    public func locationManager(_ manager: CLLocationManager,
                                didUpdateLocations locations: [CLLocation]) {

        log.message("[\(type(of: self))].\(#function)")

        if order == .none {

            let error = "there's no order for locations"
            log.message("[\(type(of: self))].\(#function) \(error)", .error)

            locationManager.stopUpdatingLocation()
            return
        }

        if order == .permission {

            let error = "the order for permission only"
            log.message("[\(type(of: self))].\(#function) \(error)", .error)

            locationManager.stopUpdatingLocation()
            order = .none
            return
        }

        if #available(macOS 13.7, *) {
            if type(of: locationManager).authorizationStatus() == .notDetermined {
                reInitLocationManager()
            }
        }

        if order == .currentLocation {

            if locations.isEmpty {
                let error = "location is empty" // Something went wrong.
                log.message("[\(type(of: self))].\(#function) \(error)", .error)
            } else if locations.first != nil {
                let debug = "location is catched"
                log.message("[\(type(of: self))].\(#function) \(debug)")
            }

            locationManager.stopUpdatingLocation()
            order = .none

            let result: Result<GeoPoint, LocationError> = locations.first == nil ?
                .failure(.receivedEmptyLocationData) :
                .success(locations.first!.point)

            notificationCenter.post(name: GeoEvent.currentLocation.name, object: result)

        } else if order == .locationUpdates {

            if locations.isEmpty {
                let error = "locations is empty" // Something went wrong.
                log.message("[\(type(of: self))].\(#function) \(error)", .error)
            } else if locations.first != nil {
                let debug = "location updates are catched"
                log.message("[\(type(of: self))].\(#function) \(debug)")
            }

            let result: Result<[GeoPoint], LocationError> = locations.isEmpty ?
                .failure(.receivedEmptyLocationData) :
                .success(locations.map { $0.point })

            notificationCenter.post(name: GeoEvent.locationUpdates.name, object: result)
        }
    }
}
