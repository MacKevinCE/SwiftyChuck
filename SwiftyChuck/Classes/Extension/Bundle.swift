//
//  Bundle.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 7/11/22.
//

import Foundation

extension Bundle {
    static var myResourceBundle: Bundle? {
        let resourceURL = Bundle(for: SwiftyChuck.self).resourcePath ?? empty
        let path = "\(resourceURL)/SwiftyChuck.bundle"
        return Bundle(path: path)
    }
}
