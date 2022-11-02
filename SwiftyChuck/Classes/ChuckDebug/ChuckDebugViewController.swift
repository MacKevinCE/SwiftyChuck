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
    @IBOutlet private var resultLabel: UILabel!
    @IBOutlet private var heightSegmentedControlConstraint: NSLayoutConstraint!
    @IBOutlet private var segmentedControl: UISegmentedControl! {
        willSet {
            newValue.addTarget(self, action: #selector(changedSegmentedControl(_:)), for: .valueChanged)
            newValue.removeAllSegments()
            enableType.enumerated().forEach {
                newValue.insertSegment(withTitle: $0.element.text, at: $0.offset, animated: false)
            }
            newValue.selectedSegmentIndex = min(SwiftyChuck.tabControl, newValue.numberOfSegments - 1)
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
        heightSegmentedControlConstraint.isActive = enableType.count < 2
        segmentedControl.isHidden = enableType.count < 2
        enverimomentState()

        title = "Swifty Chuck"
        leftBarButtonItem()
        rightBarButtonItem()
    }

    private func leftBarButtonItem() {
        let title = "Detecting: \(SwiftyChuck.isDetecting.description)"
        let color: UIColor = SwiftyChuck.isDetecting ? .green : .red
        let button = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(detectingButtonTapped))
        button.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont.semibold12
        ], for: .normal)
        button.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont.semibold12
        ], for: .highlighted)
        navigationItem.leftBarButtonItem = button
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func rightBarButtonItem() {
        let button = UIBarButtonItem(title: "DELETE ALL", style: .plain, target: self, action: #selector(deleteButtonTapped))
        button.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.font: UIFont.semibold12
        ], for: .normal)
        button.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.font: UIFont.semibold12
        ], for: .highlighted)
        navigationItem.rightBarButtonItem = button
    }

    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }

    private lazy var enableType: [ChuckLevel] = {
        var data = SwiftyChuck.dataChuck
        return SwiftyChuck.enableType.filter { type in
            !data.filter { $0.type == type }.isEmpty
        }
    }()

    private var data: [any OutputProtocol] = []

    func dataFinal(type: ChuckLevel) -> [any OutputProtocol] {
        var data = SwiftyChuck.dataChuck.filter { $0.type == type }
        let countInicial = data.count
        if let textFilter = searchBar.text?.null() {
            data = data.filter {
                $0.previewAttributed.string.lowercased().unaccent().contains(textFilter.lowercased().unaccent())
            }
            resultLabel.text = "\(data.count) of \(countInicial)"
        } else {
            resultLabel.text = empty
        }
        return data.reversed()
    }

    func enverimomentState() {
        enverimomentButton.isEnabled = false
        let enverimoment = SwiftyChuck.enverimoment.uppercased()
        enverimomentButton.setTitle(enverimoment, for: .normal)
    }

    @objc func changedSegmentedControl(_ sender: UISegmentedControl) {
        SwiftyChuck.tabControl = sender.selectedSegmentIndex
        tableView.reloadData()
    }

    @IBAction private func enverimomentButtonTapped(_ sender: UIButton) {
        // falta
    }

    @objc private func detectingButtonTapped() {
        SwiftyChuck.isDetecting.toggle()
        leftBarButtonItem()
    }

    @objc private func deleteButtonTapped() {
        SwiftyChuck.resetChuck()
        searchBar.text = empty
        searchBar.resignFirstResponder()
        tableView.reloadData()
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
        if let chuckType = enableType[safe: segmentedControl.selectedSegmentIndex] {
            data = dataFinal(type: chuckType)
            return data.count
        } else {
            return .zero
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChuckDebugCell", for: indexPath)
        cell.textLabel?.numberOfLines = 4
        cell.selectionStyle = .blue
        cell.textLabel?.font = .regular14
        let dato = data[indexPath.row]
        cell.textLabel?.attributedText = dato.previewAttributed
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
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

        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            SwiftyChuck.removeChuck(dato)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        rowActions.append(deleteAction)

        return rowActions
    }
}

extension ChuckDebugViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        let dato = data[indexPath.row]
        let viewController = ChuckDebugDetailAssembly.build(chuck: dato)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
