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

    func getIcon(name: Character, weight: UIFont.Weight = .regular, textColor: UIColor = .black, backgroundColor: UIColor = UIColor.clear, borderWidth: CGFloat = 0, borderColor: UIColor = UIColor.clear) -> UIImage {
        let size = bounds.size

        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.center

        let fontSize = min(size.width, size.height)

        // stroke width expects a whole number percentage of the font size
        let strokeWidth: CGFloat = fontSize == 0 ? 0 : (-100 * borderWidth / fontSize)
        let attributedString = NSAttributedString(string: name.description, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: weight),
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.backgroundColor: backgroundColor,
            NSAttributedString.Key.paragraphStyle: paragraph,
            NSAttributedString.Key.strokeWidth: strokeWidth,
            NSAttributedString.Key.strokeColor: borderColor
        ])

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let rect = CGRect(x: -8, y: -8, width: 17, height: 17)
        attributedString.draw(in: CGRect(x: 0 + rect.origin.x, y: ((size.height - fontSize) / 2) + rect.origin.y, width: size.width + rect.size.width, height: fontSize + rect.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    @objc func getImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
