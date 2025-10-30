//
//  RedirectActionAlert.swift
//  PerseusGeoKit
//
//  Created by Mikhail Zhigulin in 7533 (27.01.2025).
//
//  Copyright © 7531 - 7534 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7533 - 7534 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//
// swiftlint:disable file_length
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

#if os(iOS)
public let OPENSETTINGS_URL = UIApplication.openSettingsURLString
#elseif os(macOS)
public let OPENSETTINGS_URL = "x-apple.systempreferences:"
#endif

// MARK: - Alert Titles

public struct ActionAlertText {

    public var title: String
    public var message: String
    public var buttonCancel: String
    public var buttonFunction: String

    public init(title: String = "Title",
                message: String = "Message",
                buttonCancel: String = "Cancel",
                buttonFunction: String = "Action") {

        self.title = title
        self.message = message
        self.buttonCancel = buttonCancel
        self.buttonFunction = buttonFunction
    }
}

// MARK: - Alert for iOS

#if os(iOS)

public class ActionAlert {

    public var titles: ActionAlertText? {
        didSet {

            log.message("[\(type(of: self))].\(#function)")

            self.alertText = titles ?? ActionAlertText()
            self.alert = create()
        }
    }

    private var alertText: ActionAlertText
    private let action: () -> Void

    private var alert: UIAlertController?

    private var actionFunction: UIAlertAction?
    private var actionCancel: UIAlertAction?

    // MARK: - Initializer

    init(_ function: @escaping () -> Void, _ titles: ActionAlertText? = nil) {

        log.message("[\(type(of: self))].\(#function)", .info)

        self.action = function
        self.alertText = titles ?? ActionAlertText()

        self.alert = create()
    }

    private func create() -> UIAlertController {

        log.message("[\(type(of: self))].\(#function)")

        let alert = UIAlertController(title: alertText.title,
                                      message: alertText.message,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: alertText.buttonCancel, style: .cancel))
        alert.addAction(UIAlertAction(title: alertText.buttonFunction,
                                      style: .default) { _ in
            self.action()
        })

        return alert
    }

    // MARK: - Contract

    public func show(using parent: UIViewController) {

        log.message("[\(type(of: self))].\(#function)")

        if let alert = alert {
            parent.present(alert, animated: true, completion: nil)
        }
    }
}

#elseif os(macOS)

// MARK: - Alert for macOS

public class ActionAlert {

    public var titles: ActionAlertText? {
        didSet {

            log.message("[\(type(of: self))].\(#function)")

            self.alertText = titles ?? ActionAlertText()
            self.alert = create()
        }
    }

    private var alertText: ActionAlertText
    private let action: () -> Void

    private var alert: NSAlert?

    // MARK: - Initializer

    init(_ function: @escaping () -> Void, _ titles: ActionAlertText? = nil) {

        log.message("[\(type(of: self))].\(#function)", .info)

        self.action = function
        self.alertText = titles ?? ActionAlertText()

        self.alert = create()
    }

    private func create() -> NSAlert {

        log.message("[\(type(of: self))].\(#function)")

        let alert = NSAlert.init()

        alert.alertStyle = .informational

        alert.messageText = alertText.title
        alert.informativeText = alertText.message

        alert.addButton(withTitle: alertText.buttonFunction)
        alert.addButton(withTitle: alertText.buttonCancel)

        return alert
    }

    // MARK: - Contract

    public func show() {

        log.message("[\(type(of: self))].\(#function)")

        guard let alert = alert, alert.runModal() == .alertFirstButtonReturn
        else {
            log.message("[\(type(of: self))].\(#function) tapped cancel.")
            return
        }

        action()
    }
}

#endif

#if os(iOS)

// MARK: - Redirect Function for iOS

public func redirectToSettingsApp() {

    guard let settingsURL = URL(string: OPENSETTINGS_URL) else {
        log.message("\(#function) URL not corrent", .error)
        return
    }

    guard UIApplication.shared.canOpenURL(settingsURL) else {
        log.message("\(#function) right URL, but cann't be opened", .error)
        return
    }

    UIApplication.shared.open(settingsURL) { (opened) in
        if opened {
            log.message("\(#function) opened")
        } else {
            log.message("\(#function) not opened", .error)
        }
    }
}

#elseif os(macOS)

// MARK: - Redirect Function for macOS

public func redirectToSettingsApp() {

    guard let pathURL = URL(string: OPENSETTINGS_URL)
    else {
        log.message("\(#function) URL not corrent", .error)
        return
    }

    if NSWorkspace.shared.open(pathURL) {
        log.message("\(#function) opened")
    } else {
        log.message("\(#function) not opened", .error)
    }
}

#endif
