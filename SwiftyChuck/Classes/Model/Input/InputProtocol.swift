//
//  InputProtocol.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

public protocol InputProtocol: Equatable {
    associatedtype Output: OutputClass

    var id: UUID { get }
    var type: ChuckLevel { get }
    func getPreview() -> PreviewInfo
    func output() -> Output
}

public extension InputProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

    var id: UUID {
        return UUID()
    }
}
