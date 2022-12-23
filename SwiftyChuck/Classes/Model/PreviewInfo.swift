//
//  PreviewInfo.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 8/11/22.
//

import Foundation

public enum PreviewInfo {
    case attributed(NSMutableAttributedString, numberOfLines: Int = 4)
    case cell(PreviewTableViewCell.Type, searchText: String)

    var getSearchText: String {
        switch self {
        case .attributed(let attributedString, _):
            return attributedString.string
        case .cell(_, let searchText):
            return searchText
        }
    }
}
