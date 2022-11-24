//
//  SwiftyChuckDetailViewController.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation
import UIKit

class ChuckDebugDetailViewController: UIViewController {
    @IBOutlet private var resultLabel: UILabel! {
        willSet {
            newValue.text = empty
        }
    }

    @IBOutlet private var subtitleTextView: UITextView!
    @IBOutlet private var loaderView: UIView!
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private var heightSegmentedControlConstraint: NSLayoutConstraint!
    @IBOutlet private var segmentedControl: UISegmentedControl! {
        willSet {
            newValue.addTarget(self, action: #selector(changedSegmentedControl(_:)), for: .valueChanged)
            newValue.removeAllSegments()
            chuck?.detailTabs.enumerated().forEach {
                newValue.insertSegment(withTitle: $0.element.name, at: $0.offset, animated: false)
            }
            newValue.selectedSegmentIndex = min(SwiftyChuck.tabControlDetail, newValue.numberOfSegments - 1)
        }
    }

    @IBOutlet private var searchBar: UISearchBar! {
        willSet {
            newValue.delegate = self
            newValue.text = SwiftyChuck.searchTextDetail
        }
    }

    var chuck: OutputClass?

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        queue()
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let chuck = chuck else { return }
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: chuck.colorTitle,
            NSAttributedString.Key.font: UIFont.semibold16
        ]
    }

    private func configView() {
        guard let chuck = chuck else { return }
        heightSegmentedControlConstraint.isActive = chuck.detailTabs.count < 2
        segmentedControl.isHidden = chuck.detailTabs.count < 2
        title = chuck.title
        rightBarButtonItem()
        backBarButtonItem()
    }

    private func rightBarButtonItem() {
        guard let chuck = chuck else { return }
        var rightBarButtonItems: [UIBarButtonItem] = chuck.rightBarButtonItems(chuck)
        if chuck.showSharedButton {
            let button = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharedButtonTapped))
            button.tintColor = .systemBlue
            rightBarButtonItems.append(button)
        }
        navigationItem.rightBarButtonItems = rightBarButtonItems
    }

    private func backBarButtonItem() {
        let button = UIBarButtonItem(title: "BACK", style: .plain, target: nil, action: nil)
        button.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.semibold12
        ])
        navigationController?.navigationBar.topItem?.backBarButtonItem = button
    }

    private func loader(_ value: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.loaderView.isHidden = !value
            value ? self.activityIndicatorView.startAnimating() : self.activityIndicatorView.stopAnimating()
        }
    }

    private func queue() {
        let textFind = searchBar.text ?? empty
        let select = segmentedControl.selectedSegmentIndex
        DispatchQueue(label: "queue.Chuck").async { [weak self] in
            guard let self = self else { return }
            self.loader(true)
            let attributed = self.selectAttributed(select)
            let textFinal = attributed?.string ?? empty
            let textClear = textFinal.lowercased().unaccent()
            let nsRanges = textClear.ranges(of: textFind.lowercased().unaccent())
            self.printAttributed(nsRanges, attributed)
            self.loader(false)
        }
    }

    private func selectAttributed(_ select: Int) -> NSMutableAttributedString? {
        return chuck?.detailTabs[safe: select]?.attributed
    }

    private func printAttributed(_ ranges: [NSRange], _ attributed: NSMutableAttributedString?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let attributedFinal = attributed {
                let attributedText = NSMutableAttributedString(attributedString: attributedFinal)
                self.subtitleTextView.setContentOffset(.zero, animated: false)
                self.subtitleTextView.attributedText = attributedText.addAttributeText(ranges: ranges, backgroundColor: .yellow)

                if self.searchBar.text?.null() != nil {
                    let isSingle = ranges.count < 2
                    self.resultLabel.text = "\(ranges.count) \(isSingle ? "result" : "results")"
                } else {
                    self.resultLabel.text = empty
                }
            }
        }
    }

    @objc
    func changedSegmentedControl(_ sender: UISegmentedControl) {
        SwiftyChuck.tabControlDetail = sender.selectedSegmentIndex
        queue()
    }

    func getSharedItems() -> [Any] {
        var items: [Any] = []

        if let imgFinal = subtitleTextView.getImage() {
            items.append(imgFinal)
        }

        let textoFinal = subtitleTextView.attributedText.string
        items.append(textoFinal)

        return items
    }

    @objc private func sharedButtonTapped() {
        let activityController = UIActivityViewController(activityItems: getSharedItems(), applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
}

extension ChuckDebugDetailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SwiftyChuck.searchTextDetail = searchText
        queue()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
