//
//  BlogViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/11/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class BlogViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
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
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_search"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = searchButton
    }

    private func configTableView() {
        tableView.register(BlogCell.self)
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension BlogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let viewModel = try? viewModel.viewModelForItem(at: indexPath) {
            let cell = tableView.dequeue(BlogCell.self)
            cell.viewModel = viewModel
            return cell
        }
        return TableCell()
    }
}

// MARK: - Define
extension BlogViewController {
    struct Define {
        static let title = "Blog"
    }
}
