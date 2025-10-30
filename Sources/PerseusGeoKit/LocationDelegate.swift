//
//  LocationDelegate.swift
//  PerseusGeoKit
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 - 7534 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7533 - 7534 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//
// swiftlint:disable file_length
//

import CoreLocation

// MARK: - CLLocationManagerDelegate

extension GeoAgent: CLLocationManagerDelegate {

    // MARK: - Location Services Error

#if targetEnvironment(simulator)

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

        let nsError = error as NSError

        // CASE -1- NOT REPORTED, Simulator

        let note = "[CASE - SIMULATOR]"
        let details = "\(nsError.domain), code: \(nsError.code)"

        log.message("[\(type(of: self))].\(#function) \(note) \(details)")

        return
    }

#else

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

        log.message("[\(type(of: self))].\(#function) [ERROR ENTERED]")

        // locationManager.stopUpdatingLocation()

        let nsError = error as NSError

        let statusLM = type(of: locationManager).authorizationStatus()
        var locationError: LocationError = .failedRequest(error.localizedDescription,
                                                          nsError.domain,
                                                          nsError.code)

        // ISSUE: macOS (new releases) generates an error on startUpdatingLocation() if
        // an end-user makes no decision about permission immediately, 2 or 3 sec.
        // FIXED: In case if an end-user tries to give a permission not immediately,
        // restrict error notifiying so that there is no difference
        // in Current Location Diolog behavior in either early or newer macOS releases.

        // List of macOS systems that generates error if start in .notDetermined (2 or 3 sec):
        // Starting from macOS BigSur than Monterey, Ventura, Sonoma, Sequoia, ...

#if os(macOS)

        var isErrorCased = false

        let details = "\(nsError.domain), code: \(nsError.code), statusLM: \(statusLM)"

        // CASE -2- NOT REPORTED, "The Current Location Dialog"

        if order == .permission, statusLM == .notDetermined {

            isErrorCased = true

            // HOTFIX: startUpdatingLocation() case with "the location dialog" invoked.
            // Ignore that end-user takes more than 2 or 3 sec to make decision.

            locationManager.stopUpdatingLocation()
            order = .none

            let note = "[CASE - THE CURRENT LOCATION DIALOG]"
            log.message("[\(type(of: self))].\(#function) \(note) \(details)", .error)

            return
        }

        // CASE -3- NOT REPORTED, OpenCore usage

        if nsError.domain == kCLErrorDomain, nsError.code == 1, statusLM == .notDetermined,
           isAuthorizedForLocationServices {

            isErrorCased = true

            // HOTFIX: Location Services Status in OpenCore usage case.
            // Reinit location manager.

            let note = "[CASE - OPENCORE]"
            log.message("[\(type(of: self))].\(#function) \(note) \(details)", .error)

            reInitLocationManager()

            return
        }

        // CASE -4- REPORTED, Hardware

        if nsError.domain == kCLErrorDomain, nsError.code == 0 {

            isErrorCased = true

            let note = "[CASE - HARDWARE]"
            log.message("[\(type(of: self))].\(#function) \(note) \(details)", .error)
        }

        // CASE -5- REPORTED, Authorization

        if nsError.domain == kCLErrorDomain, nsError.code == 1 {

            // The app permitted to off, denied or Location Services off

            isErrorCased = true

            let note = "[CASE - AUTHORIZATION]"
            log.message("[\(type(of: self))].\(#function) \(note) \(details)", .error)
        }

        if isErrorCased == false {
            let note = "[CASE - NOT KNOWN]"
            log.message("[\(type(of: self))].\(#function) \(note) \(details)", .error)

            let errorInfo = "[NOTKNOWN] " + error.localizedDescription
            locationError = .failedRequest(errorInfo, nsError.domain, nsError.code)
        }

#endif

        // order = .none
        notificationCenter.post(name: GeoEvent.locationError.name, object: locationError)
    }

#endif

    // MARK: - Location Services Location Data

    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {

        log.message("[\(type(of: self))].\(#function) [STATUS CHANGED ENTERED]")

#if os(iOS)
        if [.authorizedAlways, .authorizedWhenInUse].contains(status) {
            isAuthorizedForLocationServices = true
        }
#elseif os(macOS)
        if [.authorized, .authorizedAlways].contains(status) {
            isAuthorizedForLocationServices = true
        }
#endif

        let statusLM = type(of: locationManager).authorizationStatus()
        let details = "statusLM: \(statusLM)"

        if statusLM == .notDetermined, isAuthorizedForLocationServices {

            // HOTFIX: Location Services Status in OpenCore usage case.

            let note = "[CASE - OPENCORE]"
            log.message("[\(type(of: self))].\(#function) \(note) \(details)", .notice)

            return
        }

        log.message("[\(type(of: self))].\(#function) \(details)", .notice)

        notificationCenter.post(name: GeoEvent.locationStatus.name, object: status)
    }

    // MARK: - To catch current location and updates

    public func locationManager(_ manager: CLLocationManager,
                                didUpdateLocations locations: [CLLocation]) {

        if type(of: locationManager).authorizationStatus() == .notDetermined {

            // HOTFIX: Location Services Status in OpenCore usage case.

            let note = "[STATUS .notDetermined]"
            log.message("[\(type(of: self))].\(#function) \(note)", .notice)

            return
        }

        if order == .none {

            let note = "[ORDER .none]"
            log.message("[\(type(of: self))].\(#function) \(note)", .notice)

            locationManager.stopUpdatingLocation()
            return
        }

        if order == .permission {

            let note = "[ORDER .permission]"
            log.message("[\(type(of: self))].\(#function) \(note)", .notice)

            locationManager.stopUpdatingLocation()
            order = .none
            return
        }

        if order == .currentLocation {

            if locations.isEmpty {
                let note = "[NO LOCATIONS]" // Something went wrong.
                log.message("[\(type(of: self))].\(#function) \(note)", .notice)
            } else if locations.first != nil {
                let note = "[CATCHED]"
                log.message("[\(type(of: self))].\(#function) \(note)")
            }

            locationManager.stopUpdatingLocation()
            order = .none

            let result: Result<GeoPoint, LocationError> = locations.first == nil ?
                .failure(.receivedEmptyLocationData) :
                .success(locations.first!.point)

            notificationCenter.post(name: GeoEvent.currentLocation.name, object: result)

        } else if order == .locationUpdates {

            if locations.isEmpty {
                let note = "[NO LOCATIONS]" // Something went wrong.
                log.message("[\(type(of: self))].\(#function) \(note)", .notice)
            } else if locations.first != nil {
                let note = "[CATCHED]"
                log.message("[\(type(of: self))].\(#function) \(note)")
            }

            let result: Result<[GeoPoint], LocationError> = locations.isEmpty ?
                .failure(.receivedEmptyLocationData) :
                .success(locations.map { $0.point })

            notificationCenter.post(name: GeoEvent.locationUpdates.name, object: result)
        }
    }
}
