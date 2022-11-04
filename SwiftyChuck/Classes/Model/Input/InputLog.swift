//
//  InputLog.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

struct InputLog: InputProtocol {
    let file: String
    let function: String
    let line: Int
    let type: ChuckLevel
    let level: LogLevel
    let colorText: UIColor
    let items: [String]
    let separator: String
    let terminator: String
    let time: Date

    init(
        _ items: Any...,
        separator: String = " ",
        terminator: String = "\n",
        _ level: LogLevel,
        _ file: String,
        _ function: String,
        _ line: Int
    ) {
        self.file = file
        self.function = function
        self.line = line
        self.type = .log
        self.level = level
        self.colorText = getColor(level)
        self.items = items.map { "\($0)" }
        self.separator = separator
        self.terminator = terminator
        self.time = Date()
    }

    func output() -> OutputLog {
        return OutputLog(self)
    }

    func getTabPreview() -> NSMutableAttributedString {
        return "\(self.level.text):"
            .initAttributeText(color: self.colorText, font: .semibold16)
            .printSpacer()
            .addTextWithAttributeText(text: self.getTitle())
            .printEnter().printTab().printTab().printSpacer()
            .addTextWithAttributeText(text: self.time.toString(), color: .gray, font: .regular12)
    }

    func getTabAll() -> NSMutableAttributedString {
        var pares: [ParString] = []
        pares.append(ParString(key: "ID", value: self.id.uuidString))
        pares.append(ParString(key: "Text", value: self.items.joined(separator: self.separator) + self.terminator))
        pares.append(ParString(key: "Items", value: "[" + self.items.map { $0.visibleUltra() }.joined(separator: ", ") + "]"))
        pares.append(ParString(key: "Separator", value: self.separator.visibleUltra()))
        pares.append(ParString(key: "Terminator", value: self.terminator.visibleUltra()))
        pares.append(ParString(key: "File", value: self.file))
        pares.append(ParString(key: "Function", value: self.function))
        pares.append(ParString(key: "Line", value: String(self.line)))
        pares.append(ParString(key: "Time", value: self.time.toString(with: .iso8601)))

        return pares.reduce()
    }

    func getTitle() -> String {
        return "\(self.items.joined(separator: self.separator.visible()))\(self.terminator.visibleUltra())"
    }
}

func getColor(_ type: LogLevel) -> UIColor {
    switch type {
    case .print: return .black
    case .debug: return .green
    case .info: return .blue
    case .warning: return .orange
    case .error: return .red
    }
}

enum LogLevel: CaseIterable {
    case print
    case debug
    case info
    case warning
    case error

    var text: String {
        switch self {
        case .print: return "Print"
        case .debug: return "Debug"
        case .info: return "Info"
        case .warning: return "Warning"
        case .error: return "Error"
        }
    }
}
