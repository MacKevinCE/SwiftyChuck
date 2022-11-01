//
//  InputLog.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

struct InputLog: InputProtocol, InputEquatable {
    let id: UUID
    let file: String
    let function: String
    let line: Int
    let type: ChuckLevel
    let level: LogLevel
    let colorText: String
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
        self.id = UUID()
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

    func output() -> OutputProtocol {
        return OutputLog(log: self)
    }
}

func getColor(_ type: LogLevel) -> String {
    switch type {
    case .print: return UIColor.black.toHexString()
    case .debug: return UIColor.green.toHexString()
    case .info: return UIColor.blue.toHexString()
    case .warning: return UIColor.orange.toHexString()
    case .error: return UIColor.red.toHexString()
    }
}
