//
//  Array.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

extension Array {
    func first<T>(with type: T.Type) -> T? {
        first(where: { ($0 as? T) != nil }) as? T
    }
}

extension Array where Element: Hashable {
    mutating func uniqued() {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        self = buffer
    }
}

public extension Array where Element == ParString {
    func toString() -> String {
        reduce(empty) { ($1.value != empty) ? "\($0)\n(\($1.key)): \($1.value)" : empty }
    }

    func reduce() -> NSMutableAttributedString {
        reduce(empty.initAttributeText(font: .regular14)) {
            ($1.value != empty) ? $0.printParStringForChuck($1).printEnter() : $0
        }
    }
}
