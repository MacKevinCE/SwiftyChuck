//
//  OutputProtocol.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

protocol OutputEquatable: Hashable {
    var id: UUID { get }
}

extension OutputEquatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

public protocol OutputProtocol {
    var type: ChuckLevel { get }
    var colorText: String { get }
    var title: String { get }
    var previewAttributed: NSMutableAttributedString { get }
    var detailTabs: [DetailTabs] { get }
}

public struct DetailTabs: Hashable {
    let name: String
    let attributed: NSMutableAttributedString
}
