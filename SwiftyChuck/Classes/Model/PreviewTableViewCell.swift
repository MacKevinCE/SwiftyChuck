//
//  PreviewTableViewCell.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 8/11/22.
//

import Foundation

public protocol PreviewTableViewCell: UITableViewCell {
    func seputCell(output: OutputClass)
    func select(is select: Bool)
}
