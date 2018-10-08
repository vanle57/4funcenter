//
//  ProfileViewController.swift
//  MyApp
//
//  Created by PCM0023 on 7/30/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class ProfileViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var cameraButton: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var image: UIImageView!

    // MARK: - Property
    let viewModel = ProfileViewModel()

    // MARK: - Override functions
    override func setupUI() {
        super.setupUI()
        title = "Profile"
        configNavigationBar()
        tableView.register(ProfileCell.self)
        tableView.rowHeight = 60
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cameraButton.circle()
        image.circle()
    }

    private func configNavigationBar() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(changePassword))
        navigationItem.rightBarButtonItem = saveButton
    }

    @objc func changePassword() {
        viewModel.changePassword { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.alert(msg: Define.successMessage, buttons: [App.String.ok], handler: nil)
            case .failure(let error):
                guard let error = error as? ProfileViewModel.ChangePasswordError else {
                    this.alert(error: App.Error.unknownError)
                    return
                }
                this.alert(title: "ERROR",
                           msg: error.localizedDescription, buttons: [App.String.ok],
                           handler: nil)
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.backgroundView?.backgroundColor = .white
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont(name: "Heebo-Medium", size: 18)
        header.textLabel?.frame = header.frame
    }
}

// MARK: - UITableViewDataSource
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
        return viewModel.numberOfItemInSection(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ProfileCell.self)
        let typeOfSection = viewModel.typeOfSections[indexPath.section]
        cell.viewModel = viewModel.viewModelOfItem(at: indexPath)
        switch typeOfSection {
        case .profile:
            cell.isUserInteractionEnabled = false
        case .changePassword:
            cell.delegate = self
            cell.textField.isSecureTextEntry = true
        }
        return cell
    }
}

// MARK: - TableViewCellDelegate
extension ProfileViewController: ProfileCellDelegate {
    func profileCell(_ profileCell: ProfileCell, neddPerform action: ProfileCell.Action) {
        switch action {
        case .shouldBecomeFirstResponder:
            guard var indexPath = tableView.indexPath(for: profileCell) else { return }
            if indexPath.row < viewModel.passwordRows.count {
                guard let cell = tableView.cellForRow(at: indexPath) as? ProfileCell else { return }
                let rowType = viewModel.getTypeOfPasswordRows(at: indexPath.row)
                    switch rowType {
                    case .oldPassword:
                        guard let text = cell.textField.text else { return }
                        viewModel.oldPassword = text
                        indexPath.row += 1
                        guard let cell = tableView.cellForRow(at: indexPath) as? ProfileCell else { return }
                        cell.textField.becomeFirstResponder()
                        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
                    case .newPassword:
                        guard let text = cell.textField.text else { return }
                        viewModel.newPassword = text
                        indexPath.row += 1
                        guard let cell = tableView.cellForRow(at: indexPath) as? ProfileCell else { return }
                        cell.textField.returnKeyType = .done
                        cell.textField.becomeFirstResponder()
                        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
                    case .confirmPassword:
                        guard let text = cell.textField.text else { return }
                        viewModel.confirmPassword = text
                        changePassword()
                    }
            }
        }
    }
}

// MARK: - Define
extension ProfileViewController {
    struct Define {
        static let successMessage = "Change password successfully!"
    }
}
