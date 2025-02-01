//
//  ActionAlert.swift
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

#if os(iOS)

public class ActionAlert {

    public var titles: ActionAlertText {
        didSet {
            log.message("[\(type(of: self))].\(#function)", .info)

            alert = createAlert()
        }
    }

    private let action: () -> Void

    private var alert: UIAlertController?

    private var actionFunction: UIAlertAction?
    private var actionCancel: UIAlertAction?

    // MARK: - Initializer

    init(using function: @escaping () -> Void) {

        log.message("[\(type(of: self))].\(#function)", .info)

        action = function
        titles = ActionAlertText()

        alert = createAlert()
    }

    private func createAlert() -> UIAlertController {
        let alert = UIAlertController(title: titles.title,
                                      message: titles.message,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: titles.buttonCancel, style: .cancel))
        alert.addAction(UIAlertAction(title: titles.buttonFunction,
                                      style: .default) { _ in
            self.action()
        })

        return alert
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

public class ActionAlert {

    public var titles: ActionAlertText {
        didSet {
            log.message("[\(type(of: self))].\(#function)", .info)

            alert = createAlert()
        }
    }

    private let action: () -> Void

    private var alert: NSAlert?

    // MARK: - Initializer

    init(using function: @escaping () -> Void) {

        log.message("[\(type(of: self))].\(#function)", .info)

        action = function
        titles = ActionAlertText()

        alert = createAlert()
    }

    private func createAlert() -> NSAlert {
        let alert = NSAlert.init()

        alert.alertStyle = .informational

        alert.messageText = titles.title
        alert.informativeText = titles.message

        alert.addButton(withTitle: titles.buttonFunction)
        alert.addButton(withTitle: titles.buttonCancel)

        return alert
    }

    // MARK: - Contract

    public func show() {
        log.message("[\(type(of: self))].\(#function)", .info)

        guard let alert = alert, alert.runModal() == .alertFirstButtonReturn else { return }

        action()
    }
}

#endif
