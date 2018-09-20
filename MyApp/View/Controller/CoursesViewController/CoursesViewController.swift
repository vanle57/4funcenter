//
//  CoursesViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/11/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class CoursesViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    var viewModel = CoursesViewModel()

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
        tableView.register(CourseCell.self)
        tableView.register(CoverCell.self)
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.estimatedRowHeight = Config.estimateRowHeight * ratio
    }
}

// MARK: - UITableViewDataSource
extension CoursesViewController: UITableViewDataSource {

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

        switch sectionType {
        case .course:
            guard let vm = try? viewModel.viewModelForItem(at: indexPath) else { return TableCell() }
            let cell = tableView.dequeue(CourseCell.self)
            cell.viewModel = vm
            return cell
        case .cover:
            let cell = tableView.dequeue(CoverCell.self)
            return cell
        }
    }
}

// MARK: - Define, Config
extension CoursesViewController {
    struct Define {
        static let title = "Courses"
    }

    struct Config {
        static let estimateRowHeight: CGFloat = 500
    }
}
