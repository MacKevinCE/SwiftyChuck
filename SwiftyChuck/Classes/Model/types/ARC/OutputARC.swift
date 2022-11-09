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
        DispatchQueue.main.async {
            self.detailTabs = [
                DetailTabs(name: "ALL", attributed: input.getTabAll())
            ]
        }
    }
}
