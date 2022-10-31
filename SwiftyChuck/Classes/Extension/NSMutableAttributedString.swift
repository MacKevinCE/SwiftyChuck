//
//  NSMutableAttributedString.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

extension NSMutableAttributedString {
    func addAttributeText(color: UIColor? = nil, font: UIFont? = nil, isUnderline: Bool = false, backgroundColor: UIColor? = nil) -> NSMutableAttributedString {
        let range = mutableString.range(of: string)
        return addAttributeText(range: range, color: color, font: font, isUnderline: isUnderline, backgroundColor: backgroundColor)
    }

    func addTextWithAttributeText(text: String?, color: UIColor? = nil, font: UIFont? = nil, isUnderline: Bool = false, backgroundColor: UIColor? = nil) -> NSMutableAttributedString {
        if let stringTexto = text, stringTexto != empty {
            let attributedString = stringTexto.initAttributeText(color: color, font: font, isUnderline: isUnderline, backgroundColor: backgroundColor)
            append(attributedString)
        }
        return self
    }

    func addAttributeIndentation(indentation: CGFloat = 20) -> NSMutableAttributedString {
        let range = mutableString.range(of: string)
        addAttributeIndentation(range: range, indentation: indentation)
        return self
    }

    func addAttributeText(textFind: String, color: UIColor? = nil, font: UIFont? = nil, isUnderline: Bool = false, backgroundColor: UIColor? = nil, all: Bool = true) -> NSMutableAttributedString {
        if textFind != empty {
            if all {
                mutableString.rangeAll(of: textFind).forEach {
                    self.addAttributeText(range: $0, color: color, font: font, isUnderline: isUnderline, backgroundColor: backgroundColor)
                }
            } else {
                let rangeTexto = mutableString.range(of: textFind)
                return addAttributeText(range: rangeTexto, color: color, font: font, isUnderline: isUnderline, backgroundColor: backgroundColor)
            }
        }
        return self
    }

    @discardableResult
    func addAttributeText(ranges: [NSRange], color: UIColor? = nil, font: UIFont? = nil, isUnderline: Bool = false, backgroundColor: UIColor? = nil) -> NSMutableAttributedString {
        ranges.forEach {
            self.addAttributeText(range: $0, color: color, font: font, isUnderline: isUnderline, backgroundColor: backgroundColor)
        }
        return self
    }

    @discardableResult
    func addAttributeText(range: NSRange, color: UIColor? = nil, font: UIFont? = nil, isUnderline: Bool = false, backgroundColor: UIColor? = nil) -> NSMutableAttributedString {
        let rangeLocation = max(0, min(length, range.location))
        let rangeLength = max(0, min(length - rangeLocation, range.length))
        let ranteFinal = NSRange(location: rangeLocation, length: rangeLength)
        if let color = color {
            addAttribute(.foregroundColor, value: color, range: ranteFinal)
        }
        if let font = font {
            addAttribute(.font, value: font, range: ranteFinal)
        }
        if isUnderline {
            addAttribute(.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: ranteFinal)
        }
        if let backgroundColor = backgroundColor {
            addAttribute(.backgroundColor, value: backgroundColor, range: ranteFinal)
        }
        return self
    }

    func addAttributeIndentation(range: NSRange, indentation: CGFloat = 20) {
        let paragraphStyle = NSMutableParagraphStyle()

        let nonOptions = [NSTextTab.OptionKey: Any]()
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
        paragraphStyle.defaultTabInterval = indentation
        paragraphStyle.headIndent = indentation

        addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
    }

    func printParStringForChuck(_ par: ParString) -> NSMutableAttributedString {
        addTextWithAttributeText(text: "[\(par.key)]: ", font: .semibold14)
            .addTextWithAttributeText(text: "\(par.value)", font: .regular14)
    }

    func printEnter() -> NSMutableAttributedString {
        addTextWithAttributeText(text: enter)
    }
    
    func printSpacer() -> NSMutableAttributedString {
        addTextWithAttributeText(text: space)
    }
    
    func printTab() -> NSMutableAttributedString {
        addTextWithAttributeText(text: tab)
    }

    func printJSONForChuck(_ json: String) -> NSMutableAttributedString {
        let attributedString = json.initAttributeText(font: .regular14)
            .addAttributeText(textFind: "=", font: .semibold14)
            .addAttributeText(textFind: ":", font: .semibold14)
            .addAttributeText(textFind: ",", font: .semibold14)
            .addAttributeText(textFind: "{", font: .semibold14)
            .addAttributeText(textFind: "}", font: .semibold14)
            .addAttributeText(textFind: "[", font: .semibold14)
            .addAttributeText(textFind: "]", font: .semibold14)
            .addAttributeText(textFind: "\"", font: .semibold14)
        append(attributedString)
        return self
    }

    func printTitleChuck(_ text: String, color: UIColor = .blue) -> NSMutableAttributedString {
        addTextWithAttributeText(text: text, color: color, font: .semibold14, isUnderline: true)
    }
}
