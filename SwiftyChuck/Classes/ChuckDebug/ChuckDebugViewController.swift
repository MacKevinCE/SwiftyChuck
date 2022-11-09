//
//  SwiftyChuckViewController.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation
import UIKit

class ChuckDebugViewController: UIViewController {
    @IBOutlet private var enverimomentButton: UIButton!
    @IBOutlet private var resultLabel: UILabel! {
        willSet {
            newValue.text = empty
        }
    }

    @IBOutlet private var heightSegmentedControlConstraint: NSLayoutConstraint!
    @IBOutlet private var segmentedControl: UISegmentedControl! {
        willSet {
            newValue.addTarget(self, action: #selector(changedSegmentedControl(_:)), for: .valueChanged)
        }
    }

    @IBOutlet private var tableView: UITableView! {
        willSet {
            newValue.dataSource = self
            newValue.delegate = self
        }
    }

    @IBOutlet private var searchBar: UISearchBar! {
        willSet {
            newValue.delegate = self
            newValue.text = SwiftyChuck.searchText
        }
    }

    var isEdit: Bool = false {
        willSet {
            let type = getCurrentLevels[safe: segmentedControl.selectedSegmentIndex]
            tableView.isEditing = newValue && (type?.isEditing ?? true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.semibold16
        ]
    }

    private func configView() {
        title = "Swifty Chuck"
        enverimomentState()
        leftBarButtonItem()
        rightBarButtonItem()
    }

    private func leftBarButtonItem() {
        var leftBarButtonItems: [UIBarButtonItem] = []

        if #available(iOS 13.0, *) {
            let close = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
            leftBarButtonItems.append(close)
        } else {
            let close = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonTapped))
            close.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont.semibold12
            ])
            leftBarButtonItems.append(close)
        }

        if SwiftyChuck.showDetectingButton {
            let title = SwiftyChuck.isDetecting ? "Yes\nDetecting" : "No\nDetecting"
            let color: UIColor = SwiftyChuck.isDetecting ? .systemGreen : .systemRed

            let detectingBtn = UIButton(type: .system)
            detectingBtn.setTitle(title, for: .normal)
            detectingBtn.tintColor = color
            detectingBtn.titleLabel?.font = .semibold12
            detectingBtn.titleLabel?.textAlignment = .center
            detectingBtn.titleLabel?.numberOfLines = 2
            detectingBtn.addTarget(self, action: #selector(detectingButtonTapped), for: .touchUpInside)

            let detectingItem = UIBarButtonItem(customView: detectingBtn)
            leftBarButtonItems.append(detectingItem)
        }

        leftBarButtonItems.append(contentsOf: SwiftyChuck.leftBarButtonItems)

        navigationItem.leftBarButtonItems = leftBarButtonItems
    }

    private func rightBarButtonItem() {
        var rightBarButtonItems: [UIBarButtonItem] = []

        if let type = getCurrentLevels[safe: segmentedControl.selectedSegmentIndex], type.isEditing {
            let edit = UIBarButtonItem(barButtonSystemItem: tableView.isEditing ? .done : .edit, target: self, action: #selector(editButtonTapped))
            edit.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont.semibold12
            ])
            rightBarButtonItems.append(edit)
        }

        if SwiftyChuck.showDeleteAllButton || tableView.isEditing {
            let title = tableView.isEditing ? "Delete\nSelection" : "Delete\nAll"

            let deleteBtn = UIButton(type: .system)
            deleteBtn.setTitle(title, for: .normal)
            deleteBtn.tintColor = .systemRed
            deleteBtn.titleLabel?.font = .semibold12
            deleteBtn.titleLabel?.textAlignment = .center
            deleteBtn.titleLabel?.numberOfLines = 2
            deleteBtn.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)

            let deleteItem = UIBarButtonItem(customView: deleteBtn)
            rightBarButtonItems.append(deleteItem)
        }

        rightBarButtonItems.append(contentsOf: SwiftyChuck.rightBarButtonItems)

        navigationItem.rightBarButtonItems = rightBarButtonItems
    }

    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.getNewLevels()
            self.tableView.reloadData()
        }
    }

    private var levels: [ChuckLevel]? {
        willSet {
            let levels = newValue ?? []
            segmentedControl.removeAllSegments()
            levels.enumerated().forEach {
                segmentedControl.insertSegment(withTitle: $0.element.text, at: $0.offset, animated: false)
            }
            segmentedControl.selectedSegmentIndex = min(SwiftyChuck.tabControl, segmentedControl.numberOfSegments - 1)

            heightSegmentedControlConstraint.isActive = levels.count < 2
            segmentedControl.isHidden = levels.count < 2
        }
    }

    @discardableResult
    private func getNewLevels() -> [ChuckLevel] {
        let data = SwiftyChuck.dataChuck
        levels = SwiftyChuck.enableType.filter { type in
            !data.filter { $0.type == type }.isEmpty
        }
        return levels ?? []
    }

    private var getCurrentLevels: [ChuckLevel] {
        if let levels = levels {
            return levels
        } else {
            return getNewLevels()
        }
    }

    private var data: [OutputClass] = []

    private func dataFinal(type: ChuckLevel) -> [OutputClass] {
        var data = SwiftyChuck.dataChuck.filter { $0.type == type }
        let countInicial = data.count
        if let textFilter = searchBar.text?.null() {
            data = data.filter {
                $0.preview.getSearchText.lowercased().unaccent().contains(textFilter.lowercased().unaccent())
            }
            resultLabel.text = "\(data.count) of \(countInicial)"
        } else {
            resultLabel.text = empty
        }
        return data.reversed()
    }

    private func enverimomentState() {
        enverimomentButton.isEnabled = false
        let enverimoment = SwiftyChuck.enverimoment
        enverimomentButton.setTitle(enverimoment, for: .normal)
    }

    @objc private func changedSegmentedControl(_ sender: UISegmentedControl) {
        SwiftyChuck.tabControl = sender.selectedSegmentIndex
        let type = getCurrentLevels[safe: segmentedControl.selectedSegmentIndex]
        tableView.isEditing = isEdit && (type?.isEditing ?? true)
        rightBarButtonItem()
        tableView.reloadData()
    }

    @IBAction private func enverimomentButtonTapped(_ sender: UIButton) {
        // falta
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }

    @objc private func detectingButtonTapped() {
        SwiftyChuck.isDetecting.toggle()
        leftBarButtonItem()
    }

    @objc private func deleteButtonTapped() {
        searchBar.resignFirstResponder()
        if tableView.isEditing {
            let indexPaths = tableView.indexPathsForSelectedRows ?? []
            let ids = indexPaths.compactMap { data[safe: $0.row]?.id }
            SwiftyChuck.remove(ids)
            tableView.deleteRows(at: indexPaths, with: .automatic)
        } else {
            SwiftyChuck.resetChuck()
            searchBar.text = empty
            tableView.reloadData()
        }
    }

    @objc private func editButtonTapped() {
        isEdit.toggle()
        if let type = getCurrentLevels[safe: segmentedControl.selectedSegmentIndex],
           let selec = SwiftyChuck.selectChuck.first(where: { $0.type == type }),
           let index = data.firstIndex(of: selec)
        {
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        } else {
            tableView.reloadData()
        }
        rightBarButtonItem()
    }
}

extension ChuckDebugViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SwiftyChuck.searchText = searchText
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension ChuckDebugViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let chuckType = getCurrentLevels[safe: segmentedControl.selectedSegmentIndex] {
            data = dataFinal(type: chuckType)
            return data.count
        } else {
            return .zero
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dato = data[indexPath.row]
        let isSelect = SwiftyChuck.selectChuck.contains(dato)
        switch dato.preview {
        case .attributed(let attributedString):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChuckDebugCell", for: indexPath)
            cell.textLabel?.numberOfLines = 4
            cell.textLabel?.font = .regular14
            cell.backgroundColor = (isSelect && !tableView.isEditing) ? .systemGray.setAlpha(0.25) : .clear
            cell.selectionStyle = tableView.isEditing ? .default : .none
            cell.textLabel?.attributedText = attributedString
            return cell

        case .cell(let typeCell, _):
            let cell = tableView.dequeueReusableCell(with: typeCell, for: indexPath)
            cell.seputView(output: dato)
            cell.select(is: isSelect)
            if let type = getCurrentLevels[safe: segmentedControl.selectedSegmentIndex], type.isEditing, tableView.isEditing {
                cell.selectionStyle = .default
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var rowActions: [UITableViewRowAction] = []

        let dato = data[indexPath.row]

        dato.actions.forEach { action in
            let executeAction = UITableViewRowAction(style: .normal, title: action.name) { [weak self] _, indexPath in
                let dato = self?.data[indexPath.row]
                action.execute(dato, indexPath)
            }
            executeAction.backgroundColor = action.color
            rowActions.append(executeAction)
        }

        if dato.showDeleteAction {
            let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
                SwiftyChuck.removeChuck(dato)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            rowActions.append(deleteAction)
        }

        return rowActions
    }
}

extension ChuckDebugViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !tableView.isEditing {
            tableView.deselectRow(at: indexPath, animated: false)
            searchBar.resignFirstResponder()
            let dato = data[indexPath.row]
            SwiftyChuck.getSelectChuck(dato)
            tableView.reloadRowsVisiblesCell()
            if dato.detailTabs.count != .zero {
                let viewController = ChuckDebugDetailAssembly.build(chuck: dato)
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}
