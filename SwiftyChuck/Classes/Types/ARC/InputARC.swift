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
    let anyObject: AnyObject

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
    }

    func output() -> OutputARC {
        return OutputARC(self)
    }

    func getPreview() -> PreviewInfo {
        let attributed = "\(self.flow.text):"
            .initAttributeText(color: .black, font: .semibold16)
            .printSpacer()
            .addTextWithAttributeText(text: self.getNameClass())
            .printEnter().printTab().printTab().printSpacer()
            .addTextWithAttributeText(text: self.time.toString(), color: .gray, font: .regular12)
        return .attributed(attributed)
    }

    func getTabAll() -> NSMutableAttributedString {
        var pares: [ParString] = []
        pares.append(ParString(key: "ID", value: self.id.uuidString))
        pares.append(ParString(key: "Project's Name", value: self.getNameProject()))
        pares.append(ParString(key: "Class Name", value: self.getNameClass()))
        pares.append(ParString(key: "All Describing Class", value: self.describingClass()))
        pares.append(ParString(key: "Encodable Class", value: self.jsonClass()))
        pares.append(ParString(key: "NavigationController Description", value: self.navigationControllerDescription()))
        pares.append(ParString(key: "View Description", value: self.viewDescription()))
        pares.append(ParString(key: "File", value: SwiftyChuck.getPath(self.file)))
        pares.append(ParString(key: "Function", value: self.function))
        pares.append(ParString(key: "Line", value: String(self.line)))
        pares.append(ParString(key: "Time", value: self.time.toString(with: .iso8601)))
        return pares.reduce()
    }

    func jsonClass() -> String {
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

open class ARC {
    let idARC = UUID()
    public init() {
        SwiftyChuck.classInit(self.idARC, self)
    }

    deinit {
        SwiftyChuck.removeChuck(idARC)
    }
}

open class ARCViewController: UIViewController {
    let idARC = UUID()
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        SwiftyChuck.classInit(self.idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        SwiftyChuck.classInit(self.idARC, self)
    }

    deinit {
        SwiftyChuck.removeChuck(idARC)
    }
}

open class ARCTableViewCell: UITableViewCell {
    let idARC = UUID()
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        SwiftyChuck.classInit(self.idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        SwiftyChuck.classInit(self.idARC, self)
    }

    deinit {
        SwiftyChuck.removeChuck(idARC)
    }
}

open class ARCCollectionViewCell: UICollectionViewCell {
    let idARC = UUID()
    override public init(frame: CGRect) {
        super.init(frame: frame)
        SwiftyChuck.classInit(self.idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        SwiftyChuck.classInit(self.idARC, self)
    }

    deinit {
        SwiftyChuck.removeChuck(idARC)
    }
}

open class ARCNavigationController: UINavigationController {
    let idARC = UUID()
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        SwiftyChuck.classInit(self.idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        SwiftyChuck.classInit(self.idARC, self)
    }

    deinit {
        SwiftyChuck.removeChuck(idARC)
    }
}
