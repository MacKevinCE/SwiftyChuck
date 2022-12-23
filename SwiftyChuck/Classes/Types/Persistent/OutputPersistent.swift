//
//  OutputPersistent.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/11/22.
//

import Foundation

class OutputPersistent: OutputClass {
    init(_ input: InputPersistent) {
        super.init(input)
        self.title = input.key
        self.colorTitle = .systemTeal
        self.detailTabs = [
            DetailTabs(name: "RESUME", attributed: input.getTabResume()),
            DetailTabs(name: "ALL", attributed: input.getTabAll())
        ]
    }
}

extension UIAlertController {}
