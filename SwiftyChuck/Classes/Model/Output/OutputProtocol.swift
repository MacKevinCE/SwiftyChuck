//
//  OutputProtocol.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

public protocol OutputProtocol: Equatable {
    var id: UUID { get }
    var type: ChuckLevel { get }
    var colorText: UIColor { get }
    var title: String { get }
    var previewAttributed: NSMutableAttributedString { get }
    var detailTabs: [DetailTabs] { get }
    var actions: [ExecuteActions] { get set }
}

public extension OutputProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    var actions: [ExecuteActions] {
        get { return [] }
        set {}
    }
}

public struct DetailTabs: Equatable {
    let name: String
    let attributed: NSMutableAttributedString

    public init(name: String, attributed: NSMutableAttributedString) {
        self.name = name
        self.attributed = attributed
    }
}

public struct ExecuteActions: Equatable {
    let name: String
    let color: UIColor
    let execute: ((any OutputProtocol)?, IndexPath) -> Void

    public static func == (lhs: ExecuteActions, rhs: ExecuteActions) -> Bool {
        lhs.name == rhs.name
    }

    public init(name: String, color: UIColor, execute: @escaping ((any OutputProtocol)?, IndexPath) -> Void) {
        self.name = name
        self.color = color
        self.execute = execute
    }
}
