//
//  LocationPermission.swift
//  PerseusGeoKit
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 - 7535 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7533 - 7535 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

public enum LocationPermissionRequest: CustomStringConvertible {

    public var description: String {
        switch self {
        case .whenInUse:
            return "When-in-use"
        case .always:
            return "Always"
        }
    }

    case whenInUse
    case always
}
