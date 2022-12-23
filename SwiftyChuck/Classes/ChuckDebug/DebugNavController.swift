//
//  DebugNavController.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 7/11/22.
//

import UIKit

class DebugNavController: UINavigationController {
    func getChuckDebugViewController() -> ChuckDebugViewController? {
        return viewControllers.first(with: ChuckDebugViewController.self)
    }

    func getChuckDebugDetailViewController() -> ChuckDebugDetailViewController? {
        return viewControllers.first(with: ChuckDebugDetailViewController.self)
    }
}
