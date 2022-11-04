//
//  OutputService.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

struct OutputService: OutputProtocol {
    var id: UUID
    let type: ChuckLevel
    let colorText: UIColor
    let title: String
    let preview: PreviewInfo
    let detailTabs: [DetailTabs]
    
    init(_ input: InputService) {
        self.id = input.id
        self.type = input.type
        self.colorText = input.colorText
        self.title = input.endPoint.resumen()
        self.preview = .attributed(input.getTabPreview())
        self.detailTabs = [
            DetailTabs(name: "RESUME", attributed: input.getTabResume()),
            DetailTabs(name: "REQUEST", attributed: input.getTabRequest()),
            DetailTabs(name: "RESPONSE", attributed: input.getTabResponse()),
            DetailTabs(name: "All", attributed: input.getTabAll())
        ]
    }
}
