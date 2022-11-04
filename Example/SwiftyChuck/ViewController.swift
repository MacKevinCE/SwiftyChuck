//
//  ViewController.swift
//  SwiftyChuck
//
//  Created by Hermes Mac Kevin Cabanillas Encarnación on 07/09/2022.
//  Copyright (c) 2022 Hermes Mac Kevin Cabanillas Encarnación. All rights reserved.
//

import SwiftyChuck
import UIKit

class ViewController: ARCViewController {
    let animal = Animal(name: "cangrejo")
    override func viewDidLoad() {
        super.viewDidLoad()
        log.setEnverimoment("DEBUG")
        log.addEnableType(.custom("Nuevooo"))
        log.service(nil, nil, nil)
        log.custom(Inputtt("Entroooo1", actions: [
            ExecuteActions(name: "BUILD", color: .blue, execute: { _, _ in
                print("holaaaaaa2")
            }),
            ExecuteActions(name: "INDEX", color: .gray, execute: { _, indexPath in
                print("holaaaaaa", indexPath)
            }),
            ExecuteActions(name: "ID", color: .brown, execute: { output, indexPath in
                print("holaaaaaa", indexPath, output?.id.uuidString ?? "--")
            })
        ]))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class MyViewController: BaseViewController {
    let animal = Animal(name: "Mascota")
    let gato = Gato(name: "GATOOO")
    let gato2 = Gato(name: "GATOOO")
    let gato3 = Gato(name: "GATOOO")

    override func viewDidLoad() {
        // let amo = Persona(name: "Pedro", animal: animal)
        // animal.amo = amo

        super.viewDidLoad()
        log.print("something", "to", "print", separator: "\n")
        log.info("something", "to", "print")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class BaseViewController: UIViewController {
    let idARC = UUID()
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        log.classInit(idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        log.classInit(idARC, self)
    }

    deinit {
        log.remove(idARC)
    }
}

class Animal: ARC, Encodable {
    let name: String
    var amo: Persona?
    init(name: String) {
        self.name = name
        super.init()
    }
}

class Gato: Animal {
    override init(name: String) {
        super.init(name: name)
    }
}

class Persona: ARC, Encodable {
    let name: String
    let animal: Animal
    init(name: String, animal: Animal) {
        self.name = name
        self.animal = animal
        super.init()
    }
}

struct Inputtt: InputProtocol {
    var id: UUID
    var file: String
    var title: String
    var function: String
    var line: Int
    var type: ChuckLevel
    var colorText: UIColor
    var actions: [ExecuteActions]

    init(
        _ title: String,
        _ file: String = #file,
        _ function: String = #function,
        _ line: Int = #line,
        actions: [ExecuteActions]
    ) {
        self.id = UUID()
        self.file = file
        self.title = title
        self.function = function
        self.line = line
        self.type = .custom("Nuevooo")
        self.colorText = .black
        self.actions = actions
    }

    func output() -> Outputtt {
        Outputtt(self)
    }
}

struct Outputtt: OutputProtocol {
    var id: UUID
    var type: ChuckLevel
    var colorText: UIColor
    var title: String
    var preview: PreviewInfo
    var actions: [ExecuteActions]
    var showDeleteAction: Bool
    func rightBarButtonItem(_ output: any OutputProtocol) -> [UIBarButtonItem] {
        return []
    }

    init(_ input: Inputtt) {
        self.id = input.id
        self.type = input.type
        self.colorText = input.colorText
        self.title = input.title
        self.preview = .cell(NuevoTableViewCell.self, type.text)
        self.actions = input.actions
        self.showDeleteAction = false
    }
}
