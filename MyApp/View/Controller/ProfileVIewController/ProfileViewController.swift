//
//  ProfileViewController.swift
//  MyApp
//
//  Created by PCM0023 on 7/30/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class ProfileViewController: BaseViewController {
    @IBOutlet private weak var cameraButton: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var image: UIImageView!

    let viewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        title = "Profile"
        tableView.register(TableViewCell.self)
        tableView.rowHeight = 60
    }

    override func setupData() {
    }

    override func viewDidLayoutSubviews() {
        cameraButton.circle()
        image.circle()
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont(name: "Heebo-Bold", size: 18)
        header.textLabel?.frame = header.frame
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let typeOfSection = viewModel.typeOfSections[section]
        switch typeOfSection {
        case .profile:
            return "PROFILE"
        case .changePassword:
            return "CHANGE PASSWORD"
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemInSectin(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TableViewCell.self)
        cell.viewModel = viewModel.viewModelOfItem(at: indexPath)
        return cell
    }
}
