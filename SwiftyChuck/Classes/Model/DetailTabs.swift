//
//  DetailTabs.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 8/11/22.
//

import Foundation

public struct DetailTabs: Equatable {
    let name: String
    let attributed: NSMutableAttributedString

    public init(name: String, attributed: NSMutableAttributedString) {
        self.name = name
        self.attributed = attributed
    }
}
