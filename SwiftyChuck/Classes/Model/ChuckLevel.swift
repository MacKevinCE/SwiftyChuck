//
//  ChuckType.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

public enum ChuckLevel: CaseIterable {
    case custom
    case log
    case service
    case arc

    var text: String {
        switch self {
        case .custom: return "CUSTOM"
        case .log: return "LOG"
        case .service: return "SERVICE"
        case .arc: return "ARC"
        }
    }
}

enum LogLevel: CaseIterable {
    case print
    case debug
    case info
    case warning
    case error
}

enum ARCFlow: CaseIterable {
    case inital
    case deinital
    var text: String {
        switch self {
        case .inital: return "init:"
        case .deinital: return "deinit:"
        }
    }
}
