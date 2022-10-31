//
//  ARC.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 30/10/22.
//

import Foundation

open class ARC {
    let idARC = UUID()
    public init() {
        SwiftyChuck.classInit(idARC, self)
    }

    deinit {
        SwiftyChuck.classDeinit(idARC)
    }
}

open class ARCViewController: UIViewController {
    let idARC = UUID()
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        SwiftyChuck.classInit(idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        SwiftyChuck.classInit(idARC, self)
    }

    deinit {
        SwiftyChuck.classDeinit(idARC)
    }
}

open class ARCTableViewCell: UITableViewCell {
    let idARC = UUID()
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        SwiftyChuck.classInit(idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        SwiftyChuck.classInit(idARC, self)
    }

    deinit {
        SwiftyChuck.classDeinit(idARC)
    }
}

open class ARCCollectionViewCell: UICollectionViewCell {
    let idARC = UUID()
    override public init(frame: CGRect) {
        super.init(frame: frame)
        SwiftyChuck.classInit(idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        SwiftyChuck.classInit(idARC, self)
    }

    deinit {
        SwiftyChuck.classDeinit(idARC)
    }
}

open class ARCNavigationController: UINavigationController {
    let idARC = UUID()
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        SwiftyChuck.classInit(idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        SwiftyChuck.classInit(idARC, self)
    }

    deinit {
        SwiftyChuck.classDeinit(idARC)
    }
}
