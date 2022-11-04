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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func seputView(output: any OutputProtocol) {
        textButton.setTitle(output.type.text, for: .normal)
    }
}
