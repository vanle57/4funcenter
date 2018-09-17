//
//  SideMenuViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/14/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var viewModel = SideMenuViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        usernameButton.underline()
    }

    override func viewDidLayoutSubviews() {
        avatarImageView.circle()
    }

    // MARK: - Private function
    private func configTableView() {
        tableView.register(SideMenuCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
}

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let viewModel = try? viewModel.viewModelForItem(at: indexPath) {
            let cell = tableView.dequeue(SideMenuCell.self)
            cell.viewModel = viewModel
            return cell
        }
        return TableCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = App.Color.lightYellowColor
    }
}
