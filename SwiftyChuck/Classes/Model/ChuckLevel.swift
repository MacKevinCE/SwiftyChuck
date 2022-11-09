//
//  ChuckType.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

public enum ChuckLevel: CaseIterable, Hashable, Equatable {
    public static var allCases: [ChuckLevel] = [.log, .service, .arc]

    case custom(String, Bool)
    case log
    case service
    case arc

    public var text: String {
        switch self {
        case .custom(let name, _): return name.uppercased()
        case .log: return "LOG"
        case .service: return "SERVICE"
        case .arc: return "ARC"
        }
    }

    public var isEditing: Bool {
        switch self {
        case .custom(_, let isEdit): return isEdit
        case .log: return true
        case .service: return true
        case .arc: return true
        }
    }
}
