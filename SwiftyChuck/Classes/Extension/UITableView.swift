//
//  UITableView.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 3/11/22.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        let nibName = String(describing: T.self)
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: nibName)
    }

    func dequeueReusableCell<T: PreviewTableViewCell>(
        with _: T.Type,
        for indexPath: IndexPath,
        isRegistered: Bool = false
    ) -> T {
        if !isRegistered {
            register(T.self)
        }
        let nibName = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: nibName, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(nibName)")
        }
        return cell
    }

    func reloadRowsVisiblesCell(with animation: UITableView.RowAnimation = .automatic) {
        reloadRows(at: indexPathsForVisibleRows ?? [], with: animation)
    }
}
