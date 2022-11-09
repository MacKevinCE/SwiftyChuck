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
