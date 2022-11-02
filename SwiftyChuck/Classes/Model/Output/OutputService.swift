//
//  OutputService.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

struct OutputService: OutputProtocol {
    let id: UUID
    let type: ChuckLevel
    let colorText: UIColor
    let title: String
    let previewAttributed: NSMutableAttributedString
    let detailTabs: [DetailTabs]
    
    init(service: InputService) {
        self.id = service.id
        self.type = service.type
        self.colorText = service.colorText
        self.title = service.endPoint.resumen()
        self.previewAttributed = service.getTabPreview()
        self.detailTabs = [
            DetailTabs(name: "RESUME", attributed: service.getTabResume()),
            DetailTabs(name: "REQUEST", attributed: service.getTabRequest()),
            DetailTabs(name: "RESPONSE", attributed: service.getTabResponse()),
            DetailTabs(name: "All", attributed: service.getTabAll())
        ]
    }
}
