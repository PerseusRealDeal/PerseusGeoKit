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

// MARK: - Location Delegate

extension GeoAgent: CLLocationManagerDelegate {

    // MARK: - To catch location service error

    public func locationManager(_ manager: CLLocationManager,
                                didFailWithError error: Error) {

        log.message("[\(type(of: self))].\(#function)")

        locationManager.stopUpdatingLocation()

        // ISSUE: macOS (new releases) generates an error on startUpdatingLocation() if
        // an end-user makes no decision immediately, 2 or 3 sec, with Current Location Diolog.
        // FIXED: In case if an end-user tries to give a permission not immediately,
        // restrict error notifiying so that there is no difference
        // in Current Location Diolog behavior in either early or newer macOS releases.

#if os(macOS)

        if order == .permission, geoPermit == .notDetermined {

            // It means that an end-user took more than 2 or 3 sec to make decision.
            // Does nothing, just a note.

            // TODO: - [ISSUE] What macOS systems generate a such error? List of macOS systems.

            let details = "order: .permission, permit: .notDetermined"
            log.message("[\(type(of: self))].\(#function) \(details)", .notice)

            return
        }

#endif

        order = .none

        let nsError = error as NSError
        let result: LocationError = .failedRequest(error.localizedDescription,
                                                   nsError.domain,
                                                   nsError.code)

        notificationCenter.post(name: GeoEvent.locationError.name, object: result)
    }

    // MARK: - To catch location status change

    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {

        log.message("[\(type(of: self))].\(#function)")

        notificationCenter.post(name: GeoEvent.locationStatus.name, object: status)
    }

    // MARK: - To catch current location and updates

    public func locationManager(_ manager: CLLocationManager,
                                didUpdateLocations locations: [CLLocation]) {

        log.message("[\(type(of: self))].\(#function)")

        if order == .none {

            let notice = "there's no order for locations!"
            log.message("[\(type(of: self))].\(#function) \(notice)", .error)

            locationManager.stopUpdatingLocation()
            return
        }

        if order == .permission {

            let notice = "the order for permission only!"
            log.message("[\(type(of: self))].\(#function) \(notice)", .error)

            locationManager.stopUpdatingLocation()
            order = .none
            return
        }

        if order == .currentLocation {

            if locations.isEmpty {
                let notice = "locations is empty!" // Something went wrong.
                log.message("[\(type(of: self))].\(#function) \(notice)", .error)
            } else if locations.first != nil {
                let debug = "location is catched!"
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

                let notice = "locations is empty!" // Something went wrong.
                log.message("[\(type(of: self))].\(#function) \(notice)", .error)

                // TODO: - [ISSUE] Should stop updating if locations is empty? Till do nothing.

                // locationManager.stopUpdatingLocation()
                // order = .none

                // return
            } else if locations.first != nil {
                let debug = "locations is catched!"
                log.message("[\(type(of: self))].\(#function) \(debug)")
            }

            let result: Result<[GeoPoint], LocationError> = locations.isEmpty ?
                .failure(.receivedEmptyLocationData) :
                .success(locations.map { $0.point })

            notificationCenter.post(name: GeoEvent.locationUpdates.name, object: result)
        }
    }
}
