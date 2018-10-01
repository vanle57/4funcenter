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
    func changePassword() {

    }
}

// MARK: - Extension: UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont(name: "Heebo-Bold", size: 18)
        header.textLabel?.frame = header.frame
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeue(TableViewCell.self)
        let typeOfPassword = viewModel.passwordRows[indexPath.row]
        switch typeOfPassword {
        case .newPassword:
            guard let newPass = cell.textField.text else { return }
        case .confirmPassword:
            guard let confirmPass = cell.textField.text else { return }
            cell.textField.returnKeyType = .done
        case .oldPassword:
            break
        }

        if indexPath.row == viewModel.passwordRows.count - 1 {
            if viewModel.confirmPassword(newPassword: newPass, confirmPassword: confirmPass) {
                alert(msg: Define.successMessage, buttons: ["OK"], handler: nil)
            } else {
                alert(error: NSError(domain: nil, code: 10, message: Define.errorMessage))
            }
        } else {
            print(indexPath.row)
            //                print(viewModel.passwordRows.count - 1)
        }
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
        return viewModel.numberOfItemInSection(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TableViewCell.self)
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

extension ProfileViewController: TableViewCellDelegate {
    func profileCell(_ profileCell: TableViewCell, neddPerform action: TableViewCell.Action) {
        switch action {
        case .shouldBecomeFirstResponder:
            guard var indexPath = tableView.indexPath(for: profileCell) else { return }
            indexPath.row += 1
            let cell = tableView.cellForRow(at: indexPath) as? TableViewCell
            if indexPath.row != viewModel.numberOfItemInSection(inSection: indexPath.section) {
                cell?.textField.becomeFirstResponder()
                tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
            } else {
//                cell?.textField.returnKeyType = .done
            }
        }
    }
}

extension ProfileViewController {
    struct Define {
        static let successMessage = "Bạn đã đổi mật khẩu thành công"
        static let errorMessage = "Mật khẩu không thể xác thực. Mời bạn nhập lại"
    }
}
