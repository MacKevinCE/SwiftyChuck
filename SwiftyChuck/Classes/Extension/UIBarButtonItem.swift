//
//  UIBarButtonItem.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 4/11/22.
//

import Foundation

extension UIBarButtonItem {
    func setTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any]) {
        self.setTitleTextAttributes(attributes, for: .normal)
        self.setTitleTextAttributes(attributes, for: .highlighted)
    }
}
