//
//  ChuckType.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

public enum ChuckLevel: CaseIterable, Hashable, Equatable {
    public static var allCases: [ChuckLevel] = [.log, .service, .arc, .persistent]

    case custom(config: ConfigLevel)
    case log
    case service
    case persistent
    case arc

    public var text: String {
        switch self {
        case .custom(let config): return config.name.uppercased()
        case .log: return "LOG"
        case .service: return "SERVICE"
        case .persistent: return "PERSISTENT"
        case .arc: return "ARC"
        }
    }

    public var isEditing: Bool {
        switch self {
        case .custom(let config): return config.isEdit
        case .log: return true
        case .service: return true
        case .persistent: return true
        case .arc: return true
        }
    }

    public var showDeleteAll: Bool {
        switch self {
        case .custom(let config): return config.showDeleteAll
        case .log: return true
        case .service: return true
        case .persistent: return true
        case .arc: return true
        }
    }
}
