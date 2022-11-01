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
    var colorText: String { get }
    var title: String { get }
    var previewAttributed: NSMutableAttributedString { get }
    var detailTabs: [DetailTabs] { get }
}

extension OutputProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

public struct DetailTabs: Hashable {
    let name: String
    let attributed: NSMutableAttributedString
}
