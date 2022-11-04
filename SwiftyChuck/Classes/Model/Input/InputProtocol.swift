//
//  InputProtocol.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

public protocol InputProtocol: Equatable {
    associatedtype Output: OutputProtocol

    var id: UUID { get }
    var type: ChuckLevel { get }
    func output() -> Output
}

public extension InputProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    var id: UUID {
        UUID()
    }
    
}
