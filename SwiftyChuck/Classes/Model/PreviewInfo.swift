//
//  PreviewInfo.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 8/11/22.
//

import Foundation

public enum PreviewInfo {
    case attributed(NSMutableAttributedString)
    case cell(PreviewTableViewCell.Type, String)

    var getSearchText: String {
        switch self {
            case .attributed(let attributedString):
                return attributedString.string
            case .cell(_, let searchText):
                return searchText
        }
    }
}
