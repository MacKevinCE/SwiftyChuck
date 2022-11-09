//
//  ParString.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 8/11/22.
//

import Foundation

public struct ParString: Codable, Hashable {
    let key: String
    let value: String

    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
