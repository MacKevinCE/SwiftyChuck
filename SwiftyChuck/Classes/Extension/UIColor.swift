//
//  UIColor.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 13/07/22.
//

import Foundation

public extension UIColor {
    convenience init(hexString: String) {
        let rgbaData = Self.getRGBAData(hexString: hexString)
        self.init(
            red: rgbaData.r,
            green: rgbaData.g,
            blue: rgbaData.b,
            alpha: rgbaData.a
        )
    }

    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(
            format: "#%02X%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff),
            Int(a * 0xff)
        )
    }

    static func getRGBAData(hexString: String) -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var rgbaData: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) = (r: 0, g: 0, b: 0, a: 0)

        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])

            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                rgbaData = {
                    switch hexColor.count {
                    case 8:
                        return (
                            r: CGFloat((hexNumber & 0xff000000) >> 24) / 255,
                            g: CGFloat((hexNumber & 0x00ff0000) >> 16) / 255,
                            b: CGFloat((hexNumber & 0x0000ff00) >> 8) / 255,
                            a: CGFloat(hexNumber & 0x000000ff) / 255
                        )
                    case 6:
                        return (
                            r: CGFloat((hexNumber & 0xff0000) >> 16) / 255,
                            g: CGFloat((hexNumber & 0x00ff00) >> 8) / 255,
                            b: CGFloat(hexNumber & 0x0000ff) / 255,
                            a: 1.0
                        )
                    default:
                        return (r: 0, g: 0, b: 0, a: 0)
                    }
                }()
            }
        }
        return rgbaData
    }
}
