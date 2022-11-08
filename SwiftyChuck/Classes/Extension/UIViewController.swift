//
//  UIViewController.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 31/10/22.
//

import UIKit

extension UIViewController {
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake, SwiftyChuck.typeOpen == .shake || SwiftyChuck.typeOpen == .all {
            SwiftyChuck.openChuckDebug()
        }
    }
}
