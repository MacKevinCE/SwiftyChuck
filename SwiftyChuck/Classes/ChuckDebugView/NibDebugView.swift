//
//  NibDebugView.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 7/11/22.
//

import UIKit

class NibDebugView: UIView {
    var view: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        viewDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        viewDidLoad()
    }

    func viewDidLoad() {}

    private func xibSetup() {
        backgroundColor = UIColor.clear
        view = loadNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.pinEdges(to: self)
    }
}
