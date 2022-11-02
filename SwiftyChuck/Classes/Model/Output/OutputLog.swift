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
    let previewAttributed: NSMutableAttributedString
    let detailTabs: [DetailTabs]

    init(log: InputLog) {
        self.id = log.id
        self.type = log.type
        self.colorText = log.colorText
        self.title = log.getTitle()
        self.previewAttributed = log.getTabPreview()
        self.detailTabs = [
            DetailTabs(name: "ALL", attributed: log.getTabAll())
        ]
    }
}
