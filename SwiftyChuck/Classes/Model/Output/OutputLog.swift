//
//  OutputLog.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

struct OutputLog: OutputProtocol, OutputEquatable {
    let id: UUID
    let type: ChuckLevel
    let colorText: String
    let title: String
    let previewAttributed: NSMutableAttributedString
    let detailTabs: [DetailTabs]

    init(log: InputLog) {
        self.id = log.id
        self.type = log.type
        self.colorText = log.colorText
        self.title = log.items.joined(separator: log.separator) + log.terminator
        self.previewAttributed = OutputLog.getPreview(log)
        self.detailTabs = [
            DetailTabs(name: "ALL", attributed: OutputLog.getAll(log))
        ]
    }

    private static func getPreview(_ log: InputLog) -> NSMutableAttributedString {
        let colorText = UIColor(hexString: log.colorText)
        return (log.items.joined(separator: log.separator))
            .initAttributeText(color: colorText, font: .semibold16)
            .printEnter().printTab().printTab().printSpacer()
            .addTextWithAttributeText(text: log.time.toString(), color: .gray, font: .regular12)
    }

    private static func getAll(_ log: InputLog) -> NSMutableAttributedString {
        var pares: [ParString] = []
        pares.append(ParString(key: "ID", value: log.id.uuidString))
        pares.append(ParString(key: "Text", value: log.items.joined(separator: log.separator) + log.terminator))
        pares.append(ParString(key: "Items", value: "[" + log.items.map { $0.visible() }.joined(separator: ", ") + "]"))
        pares.append(ParString(key: "Separator", value: log.separator.visible()))
        pares.append(ParString(key: "Terminator", value: log.terminator.visible()))
        pares.append(ParString(key: "File", value: log.file))
        pares.append(ParString(key: "Function", value: log.function))
        pares.append(ParString(key: "Line", value: String(log.line)))
        pares.append(ParString(key: "Time", value: log.time.toString(with: .iso8601)))

        return pares.reduce()
    }
}
