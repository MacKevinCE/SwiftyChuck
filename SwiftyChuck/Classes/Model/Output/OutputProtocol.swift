//
//  OutputProtocol.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

public protocol OutputProtocol: Equatable {
    associatedtype Input : InputProtocol

    var id: UUID { get }
    var type: ChuckLevel { get }
    var colorText: UIColor { get }
    var title: String { get }
    var preview: PreviewInfo { get }
    var detailTabs: [DetailTabs] { get }
    var actions: [ExecuteActions] { get set }
    var showDeleteAction: Bool { get }
    var showSharedButton: Bool { get }
    func rightBarButtonItems(_ output: any OutputProtocol) -> [UIBarButtonItem]
    init(_ input: Input)
}

public extension OutputProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    var colorText: UIColor {
        .black
    }

    var detailTabs: [DetailTabs] {
        return []
    }

    var actions: [ExecuteActions] {
        get { return [] }
        set {}
    }

    var showDeleteAction: Bool {
        true
    }

    var showSharedButton: Bool {
        true
    }

    func rightBarButtonItems(_ output: any OutputProtocol) -> [UIBarButtonItem] {
        return []
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

public enum PreviewInfo {
    case attributed(NSMutableAttributedString)
    case cell(PreviewTableViewCell.Type, String)

    var getSearchText: String {
        switch self {
            case .attributed(let attributedString):
                return attributedString.string
            case .cell(_, let searchText):
                return searchText
        }
    }
}

public protocol PreviewTableViewCell: UITableViewCell {
    func seputView(output: any OutputProtocol)
}
