//
//  BlogViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/11/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SwiftUtils

final class BlogViewController: BaseViewController {

    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!

    var viewModel = BlogViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        configTableView()
    }

    override func setupUI() {
        super.setupUI()
        title = Define.title
    }

    // MARK: - Private functions
    private func configNavigationBar() {
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_search"), style: .plain, target: self, action: #selector(showSearchView))
        navigationItem.rightBarButtonItem = searchButton
    }

    @objc func showSearchView() {
        let viewModel = SearchViewModel(type: .entry)
        let vc = SearchViewController()
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }

    private func configTableView() {
        tableView.register(BlogCell.self)
        tableView.register(SlideCell.self)
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Config.estimateRowHeight * ratio
    }
}

// MARK: - UITableViewDataSource
extension BlogViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRow = try? viewModel.numberOfItems(inSection: section) {
            return numberOfRow
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = viewModel.sections[indexPath.section]

        guard let viewModel = try? viewModel.viewModelForItem(at: indexPath) else {
            return TableCell()
        }

        switch sectionType {
        case .entry:
            guard let vm = viewModel as? BlogCellViewModel else { return TableCell() }
            let cell = tableView.dequeue(BlogCell.self)
            cell.viewModel = vm
            return cell
        case .slide:
            guard let vm = viewModel as? SlideCellViewModel else { return TableCell() }
            let cell = tableView.dequeue(SlideCell.self)
            cell.viewModel = vm
            return cell
        }
    }
}

// MARK: - Define, Config
extension BlogViewController {
    struct Define {
        static let title = "Blog"
    }

    struct Config {
        static let estimateRowHeight: CGFloat = 303
    }
}
