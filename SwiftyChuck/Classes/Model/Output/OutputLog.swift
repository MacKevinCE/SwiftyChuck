//
//  OutputLog.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

struct OutputLog: OutputProtocol {
    let id: UUID
    let type: ChuckLevel
    let colorText: UIColor
    let title: String
    let preview: PreviewInfo
    let detailTabs: [DetailTabs]

    init(_ input: InputLog) {
        self.id = input.id
        self.type = input.type
        self.colorText = input.colorText
        self.title = input.getTitle()
        self.preview = .attributed(input.getTabPreview())
        self.detailTabs = [
            DetailTabs(name: "ALL", attributed: input.getTabAll())
        ]
    }
}
