//
//  UIApplication.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

extension UIApplication {
    static var rootViewController: UIViewController? {
        UIApplication.shared.delegate?.window??.rootViewController
    }
}
