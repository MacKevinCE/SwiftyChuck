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
    let detailTabs: [DetailTabs]
    
    init(arc: InputARC) {
        self.id = arc.id
        self.type = arc.type
        self.colorText = arc.colorText
        self.title = OutputARC.getNameClass(arc.anyObject)
        self.previewAttributed = OutputARC.getPreview(arc)
        self.detailTabs = [
            DetailTabs(name: "ALL", attributed: OutputARC.getAll(arc))
        ]
    }
    
    private static func getPreview(_ arc: InputARC) -> NSMutableAttributedString {
        let colorText = UIColor(hexString: arc.colorText)
        return (arc.flow.text)
            .initAttributeText(color: colorText, font: .semibold16)
            .printSpacer()
            .addTextWithAttributeText(text: getNameClass(arc.anyObject))
            .printEnter().printTab().printTab().printSpacer()
            .addTextWithAttributeText(text: arc.time.toString(), color: .gray, font: .regular12)
    }
    
    private static func getAll(_ arc: InputARC) -> NSMutableAttributedString {
        var pares: [ParString] = []
        pares.append(ParString(key: "ID", value: arc.id.uuidString))
        pares.append(ParString(key: "Project's Name", value: getNameProject(arc.anyObject)))
        pares.append(ParString(key: "Class Name", value: getNameClass(arc.anyObject)))
        pares.append(ParString(key: "Pointer", value: getPointer(arc.anyObject)))
        pares.append(ParString(key: "All Describing Class", value: describingClass(arc.anyObject)))
        pares.append(ParString(key: "Encodable Class", value: encodableClass(arc.anyObject)))
        pares.append(ParString(key: "NavigationController Description", value: navigationControllerDescription(arc.anyObject)))
        pares.append(ParString(key: "View Description", value: viewDescription(arc.anyObject)))
        pares.append(ParString(key: "File", value: arc.file))
        pares.append(ParString(key: "Function", value: arc.function))
        pares.append(ParString(key: "Line", value: String(arc.line)))
        pares.append(ParString(key: "Time", value: arc.time.toString(with: .iso8601)))
        
        return pares.reduce()
    }
    
    private static func encodableClass(_ anyObject: AnyObject) -> String {
        guard let value = (anyObject as? Encodable) else { return empty }
        let data = try? JSONEncoder().encode(value)
        return data?.prettyPrintedJSONString?.null() ?? empty
    }
    
    private static func navigationControllerDescription(_ anyObject: AnyObject) -> String {
        guard let value = (anyObject as? UIViewController) else { return empty }
        return value.navigationController?.description ?? empty
    }
    
    private static func viewDescription(_ anyObject: AnyObject) -> String {
        guard let value = (anyObject as? UIViewController) else { return empty }
        return value.view.description
    }

    private static func describingClass(_ anyObject: AnyObject) -> String {
        return String(describing: anyObject)
    }

    private static func getNameComplete(_ anyObject: AnyObject) -> String {
        let describing = describingClass(anyObject)
        return String(describing.split(separator: ":").first ?? "").replacingOccurrences(of: "<", with: "")
    }
    
    private static func getPointer(_ anyObject: AnyObject) -> String {
        let describing = describingClass(anyObject)
        return String(describing.split(separator: ":").last ?? "").replacingOccurrences(of: ">", with: "")
    }
    
    private static func getNameProject(_ anyObject: AnyObject) -> String {
        return String(getNameComplete(anyObject).split(separator: ".").first ?? "")
    }
    
    private static func getNameClass(_ anyObject: AnyObject) -> String {
        return String(getNameComplete(anyObject).split(separator: ".").last ?? "")
    }
}
