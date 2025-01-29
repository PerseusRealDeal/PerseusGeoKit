//
//  OneFunctionAlert.swift
//  PerseusGeoLocationKit
//
//  Created by Mikhail Zhigulin in 7533 (27.01.2025).
//
//  Copyright © 7531 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7533 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

public struct AlertText {

    public var title = "Title"

    public var message = "Message"

    public var buttonCancel = "Cancel"

    public var buttonFunction = "Function"
}

#if os(iOS)

public class OneFunctionAlert {

    public var titles: AlertText {
        didSet {
            log.message("[\(type(of: self))].\(#function)", .info)

            configure()
        }
    }

    private var alert: UIAlertController?

    private var actionFunction: UIAlertAction?
    private var actionCancel: UIAlertAction?

    // MARK: - Initializer

    init() {
        log.message("[\(type(of: self))].\(#function)", .info)

        titles = AlertText()
        configure()
    }

    private func configure() {
        alert = UIAlertController(title: titles.title,
                                  message: titles.message,
                                  preferredStyle: .alert)

        alert?.addAction(UIAlertAction(title: titles.buttonCancel, style: .cancel))
        alert?.addAction(UIAlertAction(title: titles.buttonFunction,
                                       style: .default) { _ in
            redirectToSettingsApp()
        })
    }

    // MARK: - Contract

    public func show(parent controller: UIViewController) {
        log.message("[\(type(of: self))].\(#function)", .info)

        if let alert = alert {
            controller.present(alert, animated: true, completion: nil)
        }
    }
}

#elseif os(macOS)

public class OneFunctionAlert {

    // MARK: - Initializer

    init() {
        log.message("[\(type(of: self))].\(#function)", .info)

    }
}

#endif
