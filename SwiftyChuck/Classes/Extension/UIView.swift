//
//  UIView.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }

    func pinEdges(to other: UIView, edgeInsets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate(
            [
                topAnchor.constraint(
                    equalTo: other.topAnchor,
                    constant: edgeInsets.top
                ),
                bottomAnchor.constraint(
                    equalTo: other.bottomAnchor,
                    constant: edgeInsets.bottom
                ),
                trailingAnchor.constraint(
                    equalTo: other.trailingAnchor,
                    constant: edgeInsets.left
                ),
                leadingAnchor.constraint(
                    equalTo: other.leadingAnchor,
                    constant: edgeInsets.right
                )
            ]
        )
    }
}
