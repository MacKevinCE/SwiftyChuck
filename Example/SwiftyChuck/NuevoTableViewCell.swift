//
//  NuevoTableViewCell.swift
//  SwiftyChuck_Example
//
//  Created by Mc Kevin on 3/11/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftyChuck
import UIKit

class NuevoTableViewCell: UITableViewCell, PreviewTableViewCell {
    @IBOutlet var textButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func select(is select: Bool) {
        backgroundColor = .clear
    }

    func seputCell(output: OutputClass) {
        textButton.setTitle(output.title, for: .normal)
        selectionStyle = .none
    }

    @IBAction func openButtonTapped(_ sender: Any) {
        print("entro")
    }
}
