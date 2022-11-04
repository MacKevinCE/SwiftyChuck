//
//  InputARC.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 30/10/22.
//

import Foundation

struct InputARC: InputProtocol {
    let id: UUID
    let file: String
    let function: String
    let line: Int
    let type: ChuckLevel
    let flow: ARCFlow
    let colorText: UIColor
    let anyObject: AnyObject
    let time: Date

    init(
        _ id: UUID,
        _ anyObject: AnyObject,
        _ flow: ARCFlow,
        _ file: String,
        _ function: String,
        _ line: Int
    ) {
        self.id = id
        self.anyObject = anyObject
        self.flow = flow
        self.file = file
        self.function = function
        self.line = line
        self.type = .arc
        self.colorText = .black
        self.time = Date()
    }

    func output() -> OutputARC {
        return OutputARC(self)
    }

    func getTabPreview() -> NSMutableAttributedString {
        return "\(self.flow.text):"
            .initAttributeText(color: self.colorText, font: .semibold16)
            .printSpacer()
            .addTextWithAttributeText(text: self.getNameClass())
            .printEnter().printTab().printTab().printSpacer()
            .addTextWithAttributeText(text: self.time.toString(), color: .gray, font: .regular12)
    }

    func getTabAll() -> NSMutableAttributedString {
        var pares: [ParString] = []
        pares.append(ParString(key: "ID", value: self.id.uuidString))
        pares.append(ParString(key: "Project's Name", value: self.getNameProject()))
        pares.append(ParString(key: "Class Name", value: self.getNameClass()))
        pares.append(ParString(key: "All Describing Class", value: self.describingClass()))
        pares.append(ParString(key: "Encodable Class", value: self.encodableClass()))
        pares.append(ParString(key: "NavigationController Description", value: self.navigationControllerDescription()))
        pares.append(ParString(key: "View Description", value: self.viewDescription()))
        pares.append(ParString(key: "File", value: self.file))
        pares.append(ParString(key: "Function", value: self.function))
        pares.append(ParString(key: "Line", value: String(self.line)))
        pares.append(ParString(key: "Time", value: self.time.toString(with: .iso8601)))
        return pares.reduce()
    }

    func encodableClass() -> String {
        guard let value = (anyObject as? Encodable) else { return empty }
        let data = try? JSONEncoder().encode(value)
        return data?.prettyPrintedJSONString?.null() ?? empty
    }

    func navigationControllerDescription() -> String {
        guard let value = (anyObject as? UIViewController) else { return empty }
        return value.navigationController?.description ?? empty
    }

    func viewDescription() -> String {
        guard let value = (anyObject as? UIViewController) else { return empty }
        return value.view.description
    }

    func describingClass() -> String {
        return String(describing: self.anyObject)
    }

    func getNameComplete() -> String {
        let describing = self.describingClass()
        return String(describing.split(separator: ":").first ?? "").replacingOccurrences(of: "<", with: "")
    }

    func getNameProject() -> String {
        return String(self.getNameComplete().split(separator: ".").first ?? "")
    }

    func getNameClass() -> String {
        return String(self.getNameComplete().split(separator: ".").last ?? "")
    }
}

enum ARCFlow: CaseIterable {
    case inital
    case deinital
    var text: String {
        switch self {
        case .inital: return "Init"
        case .deinital: return "Deinit"
        }
    }
}
