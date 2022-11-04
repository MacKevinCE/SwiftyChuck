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
    let colorText: UIColor
    let title: String
    let preview: PreviewInfo
    let detailTabs: [DetailTabs]
    
    init(_ input: InputARC) {
        self.id = input.id
        self.type = input.type
        self.colorText = input.colorText
        self.title = input.getNameClass()
        self.preview = .attributed(input.getTabPreview())
        self.detailTabs = [
            DetailTabs(name: "ALL", attributed: input.getTabAll())
        ]
    }
}
