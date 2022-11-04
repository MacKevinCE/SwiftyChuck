//
//  String.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

var empty = ""
var space = " "
var tab = "\t"
var enter = "\n"

extension String {
    func null() -> String? { isEmpty ? nil : self }

    func unaccent() -> String {
        let components = self.components(separatedBy: "ñ")
        let parts = components.map {
            $0.folding(options: .diacriticInsensitive, locale: .current)
        }
        return parts.joined(separator: "ñ")
    }

    func visible() -> String {
        return self
            .replacingOccurrences(of: "\r", with: "\\r")
            .replacingOccurrences(of: "\n", with: "\\n")
            .replacingOccurrences(of: "\t", with: "\\t")
    }

    func visibleUltra() -> String {
        return self
            .visible()
            .replacingOccurrences(of: " ", with: "(space)")
    }

    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [NSRange] {
        var result: [NSRange] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
              let range = self[startIndex...]
              .range(of: string, options: options)
        {
            result.append(NSRange(range, in: self))
            startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }

    func resumen() -> String {
        if count > 100 {
            let pre = prefix(50)
            let post = suffix(50)
            return "\(pre)...\(post)"
        } else {
            return self
        }
    }

    public func initAttributeText(color: UIColor? = nil, font: UIFont? = nil, isUnderline: Bool = false, backgroundColor: UIColor? = nil) -> NSMutableAttributedString {
        NSMutableAttributedString(string: self).addAttributeText(color: color, font: font, isUnderline: isUnderline, backgroundColor: backgroundColor)
    }

    public func initAttributeIndentation(indentation: CGFloat = 20) -> NSMutableAttributedString {
        NSMutableAttributedString(string: self).addAttributeIndentation(indentation: indentation)
    }
}
