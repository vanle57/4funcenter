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
    }

    override func setupData() {

    }

    override func viewDidLayoutSubviews() {
        cameraButton.circle()
        image.circle()
    }
}

extension ProfileViewController: UITableViewDelegate {

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
        let profileRow = viewModel.profileRows[indexPath.row]
            cell.textField.placeholder = profileRow.rawValue
        return cell
    }
}
