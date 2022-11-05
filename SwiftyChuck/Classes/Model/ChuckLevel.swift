//
//  ChuckType.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

public enum ChuckLevel: CaseIterable, Hashable, Equatable {
    public static var allCases: [ChuckLevel] = [.log, .service, .arc]

    case custom(String)
    case log
    case service
    case arc

    public var text: String {
        switch self {
        case .custom(let name): return name.uppercased()
        case .log: return "LOG"
        case .service: return "SERVICE"
        case .arc: return "ARC"
        }
    }
}

public struct ParString: Codable, Hashable {
    let key: String
    let value: String

    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
