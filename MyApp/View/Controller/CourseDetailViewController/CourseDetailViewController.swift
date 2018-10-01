//
//  CourseDetailViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/27/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class CourseDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel = CourseDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    // MARK: - Private function
    private func configTableView() {
        tableView.register(TableCell.self)
        tableView.register(CourseDetailCell.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Config.rowHeight
        tableView.tableFooterView = UIView()
    }

    @IBAction func registerButtonTouchUpInside(_ sender: Any) {
    }
}

// MARK: - UITableViewDataSource
extension CourseDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRows = try? viewModel.numberOfItems(inSection: section) {
            return numberOfRows
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let sectionType = try? viewModel.getSectionType(at: indexPath) {
            switch sectionType {
            case .name:
                let cell = tableView.dequeue(TableCell.self)
                cell.textLabel?.text = viewModel.course.name
                return cell
            case .infor:
                if let vm = try? viewModel.viewModelForItem(at: indexPath) {
                    let cell = tableView.dequeue(CourseDetailCell.self)
                    cell.viewModel = vm
                    return cell
                }
            }
        }

        return TableCell()
    }
}

extension CourseDetailViewController {
    struct Config {
        static let rowHeight = 50 * ratio
    }
}
