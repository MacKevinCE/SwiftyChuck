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
        log.setEnableType([])
        log.service(nil, nil, nil)
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
        log.print("something", "to", "print")
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
        log.classDeinit(idARC)
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
