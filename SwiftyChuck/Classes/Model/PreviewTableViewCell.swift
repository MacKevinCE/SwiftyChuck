//
//  PreviewTableViewCell.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 8/11/22.
//

import Foundation

public protocol PreviewTableViewCell: UITableViewCell {
    func seputView(output: OutputClass)
    func select(is select: Bool)
}
