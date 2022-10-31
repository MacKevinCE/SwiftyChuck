//
//  OutputARC.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 30/10/22.
//

import Foundation

struct OutputARC: OutputProtocol, OutputEquatable {
    let id: UUID
    let type: ChuckLevel
    var colorText: String
    var title: String
    var previewAttributed: NSMutableAttributedString
    var allAttributed: NSMutableAttributedString

    init(arc: InputARC) {
        self.id = arc.id
        self.type = arc.type
        self.colorText = arc.colorText
        self.title = getNameClass(arc.anyObject)
        self.previewAttributed = getPreview(arc: arc)
        self.allAttributed = getAll(arc: arc)
    }
}

func getPreview(arc: InputARC) -> NSMutableAttributedString {
    let colorText = UIColor(hexString: arc.colorText)
    return (arc.flow.text)
        .initAttributeText(color: colorText, font: .semibold16)
        .printSpacer()
        .addTextWithAttributeText(text: getNameClass(arc.anyObject))
        .printEnter().printTab().printTab().printSpacer()
        .addTextWithAttributeText(text: arc.time.toString(), color: .gray, font: .regular12)
}

func getAll(arc: InputARC) -> NSMutableAttributedString {
    var pares: [ParString] = []
    pares.append(ParString(key: "ID", value: arc.id.uuidString))
    pares.append(ParString(key: "Project's Name", value: getNameProject(arc.anyObject)))
    pares.append(ParString(key: "Class Name", value: getNameClass(arc.anyObject)))
    pares.append(ParString(key: "Pointer", value: getPointer(arc.anyObject)))
    pares.append(ParString(key: "All Describing Class", value: describingClass(arc.anyObject)))
    pares.append(ParString(key: "File", value: arc.file))
    pares.append(ParString(key: "Function", value: arc.function))
    pares.append(ParString(key: "Line", value: String(arc.line)))
    pares.append(ParString(key: "Time", value: arc.time.toString(with:.iso8601)))

    var attributeText = empty.initAttributeText(font: .regular14)
    pares.forEach {
        attributeText = attributeText.printParStringForChuck($0).printEnter()
    }
    return attributeText
}

func describingClass(_ anyObject: AnyObject) -> String {
    return String(describing: anyObject)
}

func getNameComplete(_ anyObject: AnyObject) -> String {
    let describing = describingClass(anyObject)
    return String(describing.split(separator: ":").first ?? "").replacingOccurrences(of: "<", with: "")
}

func getPointer(_ anyObject: AnyObject) -> String {
    let describing = describingClass(anyObject)
    return String(describing.split(separator: ":").last ?? "").replacingOccurrences(of: ">", with: "")
}

func getNameProject(_ anyObject: AnyObject) -> String {
    return String(getNameComplete(anyObject).split(separator: ".").first ?? "")
}

func getNameClass(_ anyObject: AnyObject) -> String {
    return String(getNameComplete(anyObject).split(separator: ".").last ?? "")
}
