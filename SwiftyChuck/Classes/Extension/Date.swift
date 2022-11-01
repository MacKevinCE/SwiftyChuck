//
//  Date.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

extension Date {
    enum DateFormat: String {
        /// "HH:mm" example: 12:01
        case time = "HH:mm"
        /// "hh:mm:ss a" example: 12:01:10 a.m.
        case timeSecond12hours = "hh:mm:ss a"
        /// "HH:mm:ss" example: 12:01:01
        case timeSecond = "HH:mm:ss"
        /// "dd/MM/yyyy" example: 30/12/2019
        case date = "dd/MM/yyyy"
        /// "yyyy-MM-dd" example: 2019-12-30
        case dateUS = "yyyy-MM-dd"
        /// "EEEE dd MMMM yyyy" example: jueves 05 noviembre 2018
        case human = "EEEE dd MMMM yyyy"
        /// "EEEE dd/MM/yyyy" example: jueves 30/12/2019
        case humanDayDate = "EEEE dd/MM/yyyy"
        /// "EEEE dd" example: jueves 05
        case humanDay = "EEEE dd"
        /// "MMMM" example: noviembre
        case humanMonth = "MMMM"
        /// "EEEE dd MMMM" example: jueves 05 noviembre
        case humanDayMonth = "EEEE dd MMMM"
        /// "MMMM yyyy" example: noviembre 2018
        case humanMonthYear = "MMMM yyyy"
        /// yyyy-MM-dd'T'HH:mm:ss.SSSZ
        case iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        /// yyyyMMddHHmmss
        case numeric = "yyyyMMddHHmmss"
        /// "dd 'de' MMMM" example:  12 de Octubre
        case humanDayNumberMonth = "dd 'de' MMMM"
        /// "EEEE" example: jueves
        case fullDayName = "EEEE"
        /// "dd" example: 31
        case dayNumber = "dd"
        /// "MMM" example: sep
        case monthShort = "MMM"
        /// "yyyy" example: 2020
        case fourDigitYear = "yyyy"
    }

    func toString(with format: DateFormat = .timeSecond12hours) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}
