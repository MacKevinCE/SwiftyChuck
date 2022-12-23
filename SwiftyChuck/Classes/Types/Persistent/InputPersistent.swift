//
//  InputPersistent.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/11/22.
//

import Foundation

struct InputPersistent: InputProtocol {
    let file: String
    let function: String
    let line: Int
    let type: ChuckLevel
    let namespace: String
    let key: String
    let value: Any?

    init(
        _ namespace: String,
        _ key: String,
        _ value: Any?,
        _ file: String,
        _ function: String,
        _ line: Int
    ) {
        self.file = file
        self.function = function
        self.line = line
        self.type = .persistent
        self.namespace = namespace
        self.key = key
        self.value = value
    }

    func output() -> OutputPersistent {
        return OutputPersistent(self)
    }

    func getPreview() -> PreviewInfo {
        let attributed = "\(self.key):"
            .initAttributeText(color: .systemBlue, font: .semibold16)
            .printSpacer()
            .addTextWithAttributeText(text: self.getValueOneLine())
        return .attributed(attributed, numberOfLines: 2)
    }

    func getTabResume() -> NSMutableAttributedString {
        var attributeText = empty.initAttributeText(font: .regular14)

        if let namespace = self.namespace.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("NAMESPACE")
                .printEnter()
                .printJSONForChuck(namespace)
                .printEnter()
        }

        if let key = self.key.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("KEY")
                .printEnter()
                .printJSONForChuck(key)
                .printEnter()
        }

        if let type = self.getType().null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("TYPE")
                .printEnter()
                .printJSONForChuck(type)
                .printEnter()
        }

        if let value = self.getValue().null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("VALUE")
                .printEnter()
                .printJSONForChuck(value)
                .printEnter()
        }

        return attributeText
    }

    func getTabAll() -> NSMutableAttributedString {
        var pares: [ParString] = []
        pares.append(ParString(key: "ID", value: self.id.uuidString))
        pares.append(ParString(key: "Namespace", value: self.namespace))
        pares.append(ParString(key: "Key", value: self.key))
        pares.append(ParString(key: "Value", value: self.getValue()))
        pares.append(ParString(key: "Type As", value: self.getType()))
        pares.append(ParString(key: "JSON value", value: Self.jsonValue(of: self.value)))
        pares.append(ParString(key: "File", value: SwiftyChuck.getPath(self.file)))
        pares.append(ParString(key: "Function", value: self.function))
        pares.append(ParString(key: "Line", value: String(self.line)))
        pares.append(ParString(key: "Time", value: self.time.toString(with: .iso8601)))

        return pares.reduce()
    }

    func getType() -> String {
        return [
            self.type(with: [Any].self),
            self.type(with: [String].self),
            self.type(with: [Int].self),
            self.type(with: Bool.self),
            self.type(with: Character.self),
            self.type(with: [String: Any].self),
            self.type(with: Date.self),
            self.type(with: Data.self),
            self.type(with: Double.self),
            self.type(with: DispatchTime.self),
            self.type(with: Float.self),
            self.type(with: Int.self),
            self.type(with: IndexPath.self),
            self.type(with: Locale.self),
            self.type(with: Notification.self),
            self.type(with: String.self),
            self.type(with: Timer.self),
            self.type(with: URL.self),  
            self.type(with: URLRequest.self),
            self.type(with: URLSession.self),
        ].compactMap { $0 }.joined(separator: ", ")
    }

    func type<T>(with type: T.Type) -> String? {
        if let value = self.value, value is T {
            return String(describing: T.self)
        } else {
            return nil
        }
    }

    func getValueOneLine() -> String {
        let value = self.getValue()
        return value.split(separator: "\n").map { $0.trimmingCharacters(in: .whitespaces) }.joined(separator: "")
    }

    func getValue() -> String {
        guard let value = value else { return "nil" }
        if let value = value as? CustomStringConvertible {
            return value.description
        } else if let value = value as? CustomDebugStringConvertible {
            return value.debugDescription
        }
        return String(describing: value)
    }

    static func jsonValue(of value: Any?) -> String {
        guard let value = (value as? Encodable) else { return empty }
        let data = try? JSONEncoder().encode(value)
        return data?.prettyPrintedJSONString?.null() ?? empty
    }
}
