//
//  OutputClass.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

open class OutputClass: Equatable {
    public var id: UUID
    public var type: ChuckLevel
    public var colorText: UIColor
    public var title: String
    public var preview: PreviewInfo
    public var detailTabs: [DetailTabs]
    public var actions: [ExecuteActions]
    public var showDeleteAction: Bool
    public var showSharedButton: Bool

    public init(_ input: any InputProtocol) {
        self.id = input.id
        self.type = input.type
        self.colorText = .black
        self.title = empty
        self.preview = input.getPreview()
        self.detailTabs = []
        self.actions = []
        self.showDeleteAction = true
        self.showSharedButton = true
    }

    func rightBarButtonItems(_ output: OutputClass) -> [UIBarButtonItem] {
        return []
    }
}

public extension OutputClass {
    static func == (lhs: OutputClass, rhs: OutputClass) -> Bool {
        return lhs.id == rhs.id
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
    func seputView(output: OutputClass)
}
