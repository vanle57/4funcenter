//
//  SearchViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var resultTableView: UITableView!

    var viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        configTableView()
        searchBar.delegate = self
    }

    // MARK: - Private functions
    private func configNavigationBar() {
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backButton
    }

    private func configTableView() {
        historyTableView.register(HistorySearchCell.self)
        resultTableView.register(BlogCell.self)
        resultTableView.register(CourseCell.self)
    }

    private func hiddenHistorySearchView(_ status: Bool = true) {
        historyTableView.isHidden = status
    }

    private func search(keyword: String) {
        viewModel.search(keyword: keyword) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.resultTableView.reloadData()
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }

    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func trashButtonTouchUpInside(_ sender: Any) {
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == historyTableView {
            return viewModel.numberOfHistoryItems(inSection: section)
        } else {
            return viewModel.numberOfResultItems(inSection: section)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == historyTableView {
            guard let viewModel = try? viewModel.viewModelForHistoryItem(at: indexPath) else {
                return TableCell()
            }

            let cell = tableView.dequeue(HistorySearchCell.self)
            cell.viewModel = viewModel
            return cell
        } else {
            guard let vm = try? viewModel.viewModelForResultItem(at: indexPath) else {
                return TableCell()
            }

            switch viewModel.type {
            case .course:
                if let vm = vm as? CourseCellViewModel {
                    let cell = tableView.dequeue(CourseCell.self)
                    cell.viewModel = vm
                    return cell
                } else {
                    return TableCell()
                }
            case .entry:
                if let vm = vm as? BlogCellViewModel {
                    let cell = tableView.dequeue(BlogCell.self)
                    cell.viewModel = vm
                    return cell
                } else {
                    return TableCell()
                }
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        viewModel.loadHistory()
        historyTableView.reloadData()
        hiddenHistorySearchView(false)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        hiddenHistorySearchView()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let keyword = searchBar.text else {
            return
        }
        search(keyword: keyword)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
}
