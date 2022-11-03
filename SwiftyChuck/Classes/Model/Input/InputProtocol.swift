//
//  InputProtocol.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

public protocol InputProtocol: Equatable {
    var id: UUID { get }
    var time: Date { get }
    var file: String { get }
    var function: String { get }
    var line: Int { get }
    var type: ChuckLevel { get }
    var colorText: UIColor { get }
    func output() -> any OutputProtocol
    func getTabPreview() -> NSMutableAttributedString
}

public extension InputProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
