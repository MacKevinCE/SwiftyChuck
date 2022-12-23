//
//  OutputARC.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 30/10/22.
//

import Foundation

class OutputARC: OutputClass {
    init(_ input: InputARC) {
        super.init(input)
        self.title = input.getNameClass()
        self.colorTitle = .systemTeal
        DispatchQueue.main.async {
            self.detailTabs = [
                DetailTabs(name: "RESUME", attributed: input.getTabResume()),
                DetailTabs(name: "ALL", attributed: input.getTabAll())
            ]
        }
    }
}
