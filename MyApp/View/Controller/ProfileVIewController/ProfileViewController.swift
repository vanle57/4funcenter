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
    tableView.tableFooterView = UIView()
    tableView.rowHeight = 75
  }

  override func setupData() {
    super.setupData()
    do {
      try viewModel.loadUserFromRealm()
      image.setImage(path: viewModel.user.avatarUrl)
      nameLabel.text = viewModel.user.fullName
      tableView.reloadData()
    } catch {
      alert(error: App.Error.realm)
    }
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    cameraButton.circle()
  }

  private func configNavigationBar() {
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(showAlertUpdateProfile))
    navigationItem.rightBarButtonItem = saveButton
  }

  @objc func updateProfile() {
    viewModel.updateProfile { [weak self] (result) in
      guard let this = self else { return }
      switch result {
      case .success:
        this.alert(msg: Define.successMessage, buttons: [App.String.ok], handler: nil)
        this.setupData()
      case .failure(let error):
        this.alert(error: error)
      }
    }
  }

  @objc private func showAlertUpdateProfile() {
    let agreeAction: (UIAlertAction) -> Void = { (_) in
      self.updateProfile()
    }
    alertManyActions(msg: Define.alertMessage, buttons: [Define.agree, Define.cancel], handler: [agreeAction, nil])
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

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfItemInSection(inSection: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(ProfileCell.self)
    cell.viewModel = viewModel.viewModelOfItem(at: indexPath)
    cell.delegate = self
    return cell
  }
}

// MARK: - TableViewCellDelegate
extension ProfileViewController: ProfileCellDelegate {
  func profileCell(_ profileCell: ProfileCell, needPerform action: ProfileCell.Action) {
    guard var indexPath = tableView.indexPath(for: profileCell) else { return }
    switch action {
    case .shouldReturnValue(let value):
      do {
        try viewModel.saveInformationForIndex(index: indexPath.row, value: value)
        indexPath.row += 1
        if indexPath.row == viewModel.profileRows.count {
          showAlertUpdateProfile()
        } else {
          guard let cell = tableView.cellForRow(at: indexPath) as? ProfileCell else { return }
          cell.textField.becomeFirstResponder()
          tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
      } catch let error {
        alert(error: error)
      }
    }
  }
}

// MARK: - Define
extension ProfileViewController {
  struct Define {
    static let successMessage = "Update profile successfully!"
    static let alertMessage = "Do you want to update your profile?"
    static let agree = "Agree"
    static let cancel = " Cancel"
  }
}
