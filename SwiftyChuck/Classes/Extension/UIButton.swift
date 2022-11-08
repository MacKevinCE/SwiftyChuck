//
//  UIButton.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 7/11/22.
//

import Foundation

extension UIButton {
    func setBackgroundImage(_ image: UIImage?) {
        backgroundImage(for: .normal)
        setBackgroundImage(image, for: .normal)
    }
    
    func setImage(_ image: UIImage?, _ backgroundImage: UIImage?) {
        setImage(image, for: .normal)
        setBackgroundImage(backgroundImage)
    }
}
