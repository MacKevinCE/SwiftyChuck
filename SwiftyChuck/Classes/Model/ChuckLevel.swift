//
//  ChuckType.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

public struct ParString: Codable, Hashable {
    let key: String
    let value: String

    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

public enum ChuckLevel: CaseIterable {
    case custom
    case log
    case service
    case arc

    public var text: String {
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

    var text: String {
        switch self {
        case .print: return "Print"
        case .debug: return "Debug"
        case .info: return "Info"
        case .warning: return "Warning"
        case .error: return "Error"
        }
    }
}

enum ARCFlow: CaseIterable {
    case inital
    case deinital
    var text: String {
        switch self {
        case .inital: return "Init"
        case .deinital: return "Deinit"
        }
    }
}
