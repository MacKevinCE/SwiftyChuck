//
//  OutputLog.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

class OutputLog: OutputClass {
    init(_ input: InputLog) {
        super.init(input)
        self.title = input.getTitle()
        self.colorText = input.colorText
        self.detailTabs = [
            DetailTabs(name: "ALL", attributed: input.getTabAll())
        ]
    }
}
