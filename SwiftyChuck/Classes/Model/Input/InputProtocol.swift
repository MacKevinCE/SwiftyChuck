//
//  InputProtocol.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

protocol InputEquatable: Equatable {
    var id: UUID { get }
}

extension InputEquatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

public protocol InputProtocol {
    var time: Date { get }
    var file: String { get }
    var function: String { get }
    var line: Int { get }
    var type: ChuckLevel { get }
    var colorText: String { get }
    func output() -> OutputProtocol
}
