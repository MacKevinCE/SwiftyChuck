//
//  UITextView.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 8/11/22.
//

import Foundation

extension UITextView  {
    override func getImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0.0)
        attributedText.draw(in: CGRect(origin: .zero, size: contentSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
