//
//  PerseusLoggerStar.swift
//  Version: 1.1.0
//
//  For iOS and macOS only. Use Stars to adopt for the platform specifics you need.
//
//  DESC: USE LOGGER LIKE A VARIABLE ANYWHERE YOU WANT.
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7531 - 7533 PerseusRealDeal
//
//  All rights reserved.
//
//
//  MIT License
//
//  Copyright © 7531 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7531 - 7533 PerseusRealDeal
//
//  The year starts from the creation of the world according to a Slavic calendar.
//  September, the 1st of Slavic year.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
// swiftlint:disable file_length
//

import Foundation
import os

// swiftlint:disable type_name
typealias log = PerseusLogger
// swiftlint:enable type_name

public typealias ConsoleObject = (subsystem: String, category: String)

public let CONSOLE_APP_SUBSYSTEM_DEFAULT = "Perseus"
public let CONSOLE_APP_CATEGORY_DEFAULT = "Logger"

public class PerseusLogger {

    // MARK: - Specifics

    public enum Status {
        case on
        case off
    }

    public enum Output {
        case xcodedebug
        case consoleapp
        // case outputfile
    }

    public enum Level: Int, CustomStringConvertible {

        public var description: String {
            switch self {
            case .debug:
                return "DEBUG"
            case .info:
                return "INFO"
            case .notice:
                return "NOTE"
            case .error:
                return "ERROR"
            case .fault:
                return "FAULT"
            }
        }

        public var tag: String {
            switch self {
            case .debug:
                return "[DEBUG]"
            case .info:
                return "[INFO ]"
            case .notice:
                return "[NOTE ]"
            case .error:
                return "[ERROR]"
            case .fault:
                return "[FAULT]"
            }
        }

        case debug  = 5
        case info   = 4
        case notice = 3
        case error  = 2
        case fault  = 1
    }

    public enum TimeMultiply {
        // case millisecond // -3.
        // case microsecond // -6.
        case nanosecond  // -9.
    }

    public enum MessageFormat {

        case short
        // marks true, time false, directives false
        // [DEBUG] message

        // marks true, time true, directives false
        // [2025:04:17] [20:31:53:630594968] [DEBUG] message

        // marks true, time false, directives true
        // [DEBUG] message, file: File.swift, line: 29

        // marks true, time true, directives true
        // [2025:04:17] [20:31:53:630918979] [DEBUG] message, file: File.swift, line: 29

        // marks false, directives true
        // message, file: File.swift, line: 29

        // marks false, directives false
        // message

        case full
        // [2025:04:17] [20:31:53:630918979] [DEBUG] message, file: File.swift, line: 29

        case textonly
        // message
    }

    // MARK: - Properties

#if DEBUG
    public static var turned = Status.on
    public static var level = Level.debug
    public static var output = Output.xcodedebug
#else
    public static var turned = Status.off
    public static var level = Level.notice
    public static var output = Output.consoleapp
#endif

    public static var subsecond = TimeMultiply.nanosecond
    public static var format = MessageFormat.short

    public static var marks = true // [DEBUG] tag in message.
    public static var time = false // If also and marks true adds time tags to message.

    public static var directives = false // File# and Line# in message.

#if targetEnvironment(simulator)
    public static var debugIsInfo = true // Shows DEBUG message as INFO in Console on Mac.
#endif

    public static var logObject: ConsoleObject? {
        didSet {

            guard let obj = logObject else {

                if #available(iOS 14.0, macOS 11.0, *) {
                    consoleLogger = nil
                }

                consoleOSLog = nil

                return
            }

            if #available(iOS 14.0, macOS 11.0, *) {
                consoleLogger = Logger(subsystem: obj.subsystem, category: obj.category)
            } else {
                consoleOSLog = OSLog(subsystem: obj.subsystem, category: obj.category)
            }
        }
    }

    public static var localTime: String {
        return getLocalTime()
    }

    // MARK: - Internals

    @available(iOS 14.0, macOS 11.0, *)
    private(set) static var consoleLogger: Logger?
    private(set) static var consoleOSLog: OSLog?

    // MARK: - Contract

    // swiftlint:disable:next cyclomatic_complexity
    public static func message(_ text: @autoclosure () -> String,
                               _ type: Level = .debug,
                               _ file: StaticString = #file,
                               _ line: UInt = #line) {

        guard turned == .on, type.rawValue <= level.rawValue else { return }

        var message = ""

        // Path.

        let withDirectives = (format == .full) ? true : (directives && (format != .textonly))

        if withDirectives {
            let fileName = (file.description as NSString).lastPathComponent
            message = "\(text()), file: \(fileName), line: \(line)"
        } else {
            message = "\(text())"
        }

        // Level.

        let isTyped = (format == .full) ? true : marks && (format != .textonly)
        message = isTyped ? "\(type.tag) \(message)" : message

        // Time.

        let isTimed = (format == .full) ? true : marks && time && (format != .textonly)
        message = isTimed ? "\(getLocalTime()) \(message)" : message

        // Print.

        print(message, type)
    }

    // MARK: - Implementation

    private static func print(_ text: String, _ type: Level) {

        let message = text

        if output == .xcodedebug {

            Swift.print(message) // DispatchQueue.main.async { print(message) }

        } else if output == .consoleapp {

            if #available(iOS 14.0, macOS 11.0, *) {

                let logger = consoleLogger ?? Logger(subsystem: CONSOLE_APP_SUBSYSTEM_DEFAULT,
                                                     category: CONSOLE_APP_CATEGORY_DEFAULT)

                switch type {
                case .debug:
#if targetEnvironment(simulator)
                    if debugIsInfo {
                        logger.info("\(message, privacy: .public)")
                    } else {
                        logger.debug("\(message, privacy: .public)")
                    }
#else
                    logger.debug("\(message, privacy: .public)")
#endif
                case .info:
                    logger.info("\(message, privacy: .public)")
                case .notice:
                    logger.notice("\(message, privacy: .public)")
                case .error:
                    logger.error("\(message, privacy: .public)")
                case .fault:
                    logger.fault("\(message, privacy: .public)")
                }

                return
            }

            let consoleLog = consoleOSLog ?? OSLog(subsystem: CONSOLE_APP_SUBSYSTEM_DEFAULT,
                                                   category: CONSOLE_APP_CATEGORY_DEFAULT)

            switch type {
            case .debug:
#if targetEnvironment(simulator)
                if debugIsInfo {
                    os_log("%{public}@", log: consoleLog, type: .info, message)
                } else {
                    os_log("%{public}@", log: consoleLog, type: .debug, message)
                }
#else
                os_log("%{public}@", log: consoleLog, type: .debug, message)
#endif
            case .info:
                os_log("%{public}@", log: consoleLog, type: .info, message)
            case .notice:
                os_log("%{public}@", log: consoleLog, type: .default, message)
            case .error:
                os_log("%{public}@", log: consoleLog, type: .error, message)
            case .fault:
                os_log("%{public}@", log: consoleLog, type: .fault, message)
            }
        }
    }

    private static func getLocalTime() -> String {

        guard let timezone = TimeZone(secondsFromGMT: 0) else { return "TIME" }

        var calendar = Calendar.current

        calendar.timeZone = timezone
        calendar.locale = Locale(identifier: "en_US_POSIX") // Supports nanoseconds. For sure.

        let current = Date(timeIntervalSince1970:(Date().timeIntervalSince1970 +
                                                  Double(TimeZone.current.secondsFromGMT())))

        // Parse date.

        var details: Set<Calendar.Component> = [.year, .month, .day]
        var components = calendar.dateComponents(details, from: current)

        guard
            let year = components.year,
            let month = components.month?.inTime,
            let day = components.day?.inTime else { return "TIME" }

        let date = "[\(year):\(month):\(day)]"

        // Parse time.

        details = [.hour, .minute, .second, .nanosecond]
        components = calendar.dateComponents(details, from: current)

        guard
            let hour = components.hour?.inTime, // Always in 24-hour.
            let minute = components.minute?.inTime,
            let second = components.second?.inTime,
            let subsecond = components.nanosecond?.multiply else { return "TIME" }

        let time = "[\(hour):\(minute):\(second):\(subsecond)]"

        return "\(date) \(time)"
    }
}

// MARK: - Helpers

private extension Int {

    var inTime: String {
        guard self >= 0, self <= 9 else { return String(self) }
        return "0\(self)"
    }

    var multiply: String {
        return String(self)
    }
}
