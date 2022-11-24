//
//  ConfigLevel.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 24/11/22.
//

import Foundation

public struct ConfigLevel: Hashable {
    let name: String
    let isEdit: Bool
    let showDeleteAll: Bool

    public init(name: String, isEdit: Bool = true, showDeleteAll: Bool = true) {
        self.name = name
        self.isEdit = isEdit
        self.showDeleteAll = showDeleteAll
    }
}
