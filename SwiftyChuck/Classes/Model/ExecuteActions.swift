//
//  ExecuteActions.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 8/11/22.
//

import Foundation

public struct ExecuteActions: Equatable {
    private let id: UUID
    let name: String
    let color: UIColor
    let execute: (OutputClass?, IndexPath) -> Void

    public static func == (lhs: ExecuteActions, rhs: ExecuteActions) -> Bool {
        return lhs.id == rhs.id
    }

    public init(name: String, color: UIColor, execute: @escaping (OutputClass?, IndexPath) -> Void) {
        self.id = UUID()
        self.name = name
        self.color = color
        self.execute = execute
    }
}
