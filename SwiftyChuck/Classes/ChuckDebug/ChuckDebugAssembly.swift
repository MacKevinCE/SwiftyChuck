//
//  SwiftyChuckAssembly.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation
import UIKit

class ChuckDebugAssembly {
    static func build() -> ChuckDebugViewController {
        let bundle = Bundle(for: ChuckDebugViewController.self)
        let storyboard = UIStoryboard(name: "ChuckDebug", bundle: bundle)
        let view = storyboard.instantiateInitialViewController() as! ChuckDebugViewController
        return view
    }
}

class ChuckDebugDetailAssembly {
    static func build(chuck: OutputProtocol) -> ChuckDebugDetailViewController {
        let bundle = Bundle(for: ChuckDebugDetailViewController.self)
        let storyboard = UIStoryboard(name: "ChuckDebug", bundle: bundle)
        let view = storyboard.instantiateViewController(withIdentifier: "ChuckDebugDetailViewController") as! ChuckDebugDetailViewController
        view.chuck = chuck
        return view
    }
}

extension UIViewController {
    private func openViewChuckDebug() {
        guard let owner = UIApplication.rootViewController else { return }
        let final = owner.presentedViewController ?? owner
        let navigation = UINavigationController(rootViewController: ChuckDebugAssembly.build())
        navigation.isNavigationBarHidden = true
        final.present(navigation, animated: true, completion: nil)
    }

    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            openViewChuckDebug()
        }
    }
}
