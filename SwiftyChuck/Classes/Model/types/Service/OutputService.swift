//
//  OutputService.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

class OutputService: OutputClass {
    init(_ input: InputService) {
        super.init(input)
        self.title = input.endPoint.resumen()
        self.colorText = input.colorText
        self.detailTabs = [
            DetailTabs(name: "RESUME", attributed: input.getTabResume()),
            DetailTabs(name: "REQUEST", attributed: input.getTabRequest()),
            DetailTabs(name: "RESPONSE", attributed: input.getTabResponse()),
            DetailTabs(name: "All", attributed: input.getTabAll())
        ]
    }
}
