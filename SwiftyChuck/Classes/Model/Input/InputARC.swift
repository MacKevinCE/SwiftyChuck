//
//  InputARC.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 30/10/22.
//

import Foundation

struct InputARC: InputProtocol, InputEquatable {
    let id: UUID
    let file: String
    let function: String
    let line: Int
    let type: ChuckLevel
    let flow: ARCFlow
    let colorText: String
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
        self.colorText = UIColor.black.toHexString()
        self.time = Date()
    }

    func output() -> OutputProtocol {
        return OutputARC(arc: self)
    }
}
