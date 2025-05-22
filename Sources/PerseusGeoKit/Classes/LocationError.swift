//
//  LocationError.swift
//  PerseusGeoKit
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 - 7533 Mikhail A. Zhigulin of Novosibirsk
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

public enum LocationError: Error, Equatable, CustomStringConvertible {

    public var description: String {
        switch self {
        case .permissionRequired(let status):
            return "permission required if status: \(status)"
        case .receivedEmptyLocationData:
            return "recieved empty location data"
        case .failedRequest(_, let domain, let code):
            return "domain: \(domain), code: \(code)"
        }
    }

    case permissionRequired(GeoStatus)
    case receivedEmptyLocationData
    case failedRequest(String, String, Int) // localizedDescription, domain, code.

    public var failedRequestDetails: (domain: String, code: Int)? {
        switch self {
        case .permissionRequired:
            return nil
        case .receivedEmptyLocationData:
            return nil
        case .failedRequest(_, let domain, let code):
            return (domain: domain, code: code)
        }
    }
}
