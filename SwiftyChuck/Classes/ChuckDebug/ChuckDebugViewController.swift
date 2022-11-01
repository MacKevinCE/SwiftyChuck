//
//  SwiftyChuckViewController.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation
import UIKit

class ChuckDebugViewController: UIViewController {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var enverimomentButton: UIButton!
    @IBOutlet private var settingButton: UIButton!
    @IBOutlet private var deleteButton: UIButton!
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
            newValue.searchTextField.delegate = self
            newValue.text = SwiftyChuck.searchText
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView() {
        titleLabel.font = .semibold16
        heightSegmentedControlConstraint.isActive = enableType.count < 2
        segmentedControl.isHidden = enableType.count < 2
        enverimomentState()
        settingSate()
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

    private var data: [OutputProtocol] = []

    func dataFinal(type: ChuckLevel) -> [OutputProtocol] {
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

    func settingSate() {
        let title = "Detecting: \(SwiftyChuck.isDetecting.description)"
        settingButton.setTitle(title, for: .normal)
        let color: UIColor = SwiftyChuck.isDetecting ? .green : .red
        settingButton.setTitleColor(color, for: .normal)
    }

    @objc
    func changedSegmentedControl(_ sender: UISegmentedControl) {
        SwiftyChuck.tabControl = sender.selectedSegmentIndex
        tableView.reloadData()
    }

    @IBAction private func enverimomentButtonTapped(_ sender: UIButton) {
        // falta
    }

    @IBAction private func settingButtonTapped(_ sender: UIButton) {
        SwiftyChuck.isDetecting.toggle()
        settingSate()
    }

    @IBAction private func deleteButtonTapped(_ sender: UIButton) {
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
}

extension ChuckDebugViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ChuckDebugCell")
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

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dato = data[indexPath.row]
            SwiftyChuck.removeChuck(dato as? (any OutputEquatable))
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
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
