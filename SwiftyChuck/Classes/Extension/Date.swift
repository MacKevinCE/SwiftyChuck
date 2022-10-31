//
//  Date.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

extension Date {
    enum DateStyles {
        /// Example: wednesday
        static let fullNameDay = "EEEE"

        /// Example: december
        static let fullNameMonth = "MMMM"

        /// Example: dec
        static let shortNameMonth = "MMM"

        /// Example: noviembre 2020
        static let monthWordAndYear = "MMMM yyyy"

        /// Example: 2018
        static let fourDigitYear = "yyyy"

        /// Example: 18
        static let twoDigitYear = "yy"

        /// Exampke: 12
        static let monthWithPadding = "MM"
        
        /// Example: 01
        static let twentyHourWithPadding = "HH"

        /// Example: 1
        static let minute = "m"

        /// Example: 01
        static let minuteWithPadding = "mm"

        /// Example: 01
        static let secondWithPadding = "ss"

        /// Example: 1
        static let day = "d"

        /// Example: 01
        static let dayWithPadding = "dd"

        /// Example: lorem
        static let zone = "SSSZ"
    }

    enum DateFormat {
        /// "HH:mm" example: 12:01
        case time
        
        /// "hh:mm:ss a" example: 12:01:10 a.m.
        case timeSecond12hours

        /// "HH:mm:ss" example: 12:01:01
        case timeSecond
        
        /// "dd/MM/yyyy" example: 30/12/2019
        case dateCL

        /// "yyyy-MM-dd" example: 2019-12-30
        case dateUS

        /// "EEEE dd MMMM yyyy" example: jueves 05 noviembre 2018
        case human

        /// "EEEE dd/MM/yyyy" example: jueves 30/12/2019
        case humanDayDateCl

        /// "EEEE dd" example: jueves 05
        case humanDay

        /// "MMMM" example: noviembre
        case humanMonth

        /// "EEEE dd MMMM " example: jueves 05 noviembre
        case humanDayMonth

        /// "MMMM yyyy" example: noviembre 2018
        case humanMonthYear

        /// yyyy-MM-dd'T'HH:mm:ss.SSSZ
        case iso8601

        /// yyyyMMddHHmmss
        case numeric

        /// "dd 'de' MMMM" example:  12 de Octubre
        case humanDayNumberMonth

        /// "EEEE" example: jueves
        case fullDayName

        /// "dd" example: 31
        case dayNumber

        /// "MMM example: sep
        case monthShort

        /// "MMMM yyyy" example: noviembre 2020
        case monthWordAndYear

        /// "yyyy" example: 2020
        case fourDigitYear

        func style() -> String {
            switch self {
            case .time:
                /// "HH:mm"
                return """
                \(DateStyles.twentyHourWithPadding):\(DateStyles.minuteWithPadding)
                """
            case .timeSecond12hours:
                /// "hh:mm:ss a"
                return "hh:mm:ss a"
            case .timeSecond:
                /// "HH:mm:ss"
                return """
                \(DateStyles.twentyHourWithPadding):\(DateStyles.minuteWithPadding):\(DateStyles.secondWithPadding)
                """
            case .dateCL:
                /// "dd/MM/yyyy"
                return """
                \(DateStyles.dayWithPadding)/\(DateStyles.monthWithPadding)/\(DateStyles.fourDigitYear)
                """
            case .dateUS:
                /// "yyyy-MM-dd"
                return """
                \(DateStyles.fourDigitYear)-\(DateStyles.monthWithPadding)-\(DateStyles.dayWithPadding)
                """
            case .human:
                /// "EEEE dd MMMM yyyy"
                return """
                \(DateStyles.fullNameDay) \(DateStyles.dayWithPadding) \(DateStyles.fullNameMonth) \(DateStyles.fourDigitYear)
                """
            case .humanDayDateCl:
                /// "EEEE dd MMMM yyyy"
                return """
                \(DateStyles.fullNameDay) \(DateStyles.dayWithPadding)/\(DateStyles.monthWithPadding)/\(DateStyles.fourDigitYear)
                """
            case .humanDay:
                /// "EEEE dd"
                return """
                \(DateStyles.fullNameDay) \(DateStyles.dayWithPadding)
                """
            case .humanMonth:
                /// "MMMM
                return """
                \(DateStyles.fullNameMonth)
                """
            case .humanDayMonth:
                /// "EEEE dd MMMM"
                return """
                \(DateStyles.fullNameDay) \(DateStyles.dayWithPadding) \(DateStyles.fullNameMonth)
                """
            case .humanMonthYear:
                /// "MMMM yyyy"
                return """
                \(DateStyles.fullNameMonth) \(DateStyles.fourDigitYear)
                """
            case .iso8601:
                /// " yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                let date = "\(DateStyles.fourDigitYear)-\(DateStyles.monthWithPadding)-\(DateStyles.dayWithPadding)"
                let time = "\(DateStyles.twentyHourWithPadding):\(DateStyles.minuteWithPadding):\(DateStyles.secondWithPadding)"

                return """
                \(date)'T'\(time).\(DateStyles.zone)
                """
            case .numeric:
                /// " yyyy-MM-dd'T'HH:mm:ss"
                let date = "\(DateStyles.fourDigitYear)\(DateStyles.monthWithPadding)\(DateStyles.dayWithPadding)"
                let time = "\(DateStyles.twentyHourWithPadding)\(DateStyles.minuteWithPadding)\(DateStyles.secondWithPadding)"

                return "\(date)\(time)"
            case .humanDayNumberMonth:
                /// "dd de MMMM"
                return """
                \(DateStyles.dayWithPadding) 'de' \(DateStyles.fullNameMonth)
                """
            case .fullDayName:
                /// "EEEE"
                return """
                \(DateStyles.fullNameDay)
                """
            case .dayNumber:
                /// "dd"
                return """
                \(DateStyles.dayWithPadding)
                """
            case .monthShort:
                /// "MMM"
                return """
                \(DateStyles.shortNameMonth)
                """
            case .monthWordAndYear:
                /// "MMMM yyyy"
                return """
                \(DateStyles.monthWordAndYear)
                """
            case .fourDigitYear:
                /// "yyyy"
                return """
                \(DateStyles.fourDigitYear)
                """
            }
        }
    }

    func toString(with format: DateFormat = .timeSecond12hours) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.style()
        return dateFormatter.string(from: self)
    }
}
