//
//  OutputARC.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 30/10/22.
//

import Foundation

struct OutputARC: OutputProtocol {
    let id: UUID
    let type: ChuckLevel
    var colorText: UIColor
    var title: String
    var previewAttributed: NSMutableAttributedString
    let detailTabs: [DetailTabs]
    
    init(arc: InputARC) {
        self.id = arc.id
        self.type = arc.type
        self.colorText = arc.colorText
        self.title = arc.getNameClass()
        self.previewAttributed = arc.getTabPreview()
        self.detailTabs = [
            DetailTabs(name: "ALL", attributed: arc.getTabAll())
        ]
    }
}
