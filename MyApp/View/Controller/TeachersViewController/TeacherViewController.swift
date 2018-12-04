//
//  TeacherViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SVProgressHUD

final class TeacherViewController: BaseViewController {

  @IBOutlet weak var tableView: UITableView!

  var viewModel = TeacherViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    configNavigationBar()
    configTableView()
  }

  override func setupUI() {
    super.setupUI()
    title = Define.title
  }

  override func setupData() {
    super.setupData()

    SVProgressHUD.show()
    viewModel.loadTeachers { [weak self] (result) in
      SVProgressHUD.popActivity()
      guard let this = self else { return }
      switch result {
      case .success:
        this.tableView.reloadData()
        NotificationCenter.default.post(name: .reloadData, object: nil)
      case .failure(let error):
        this.alert(error: error)
      }
    }
  }

  // MARK: - Private functions
  private func configNavigationBar() {
    let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_search"), style: .plain, target: self, action: nil)
    navigationItem.rightBarButtonItem = searchButton
  }

  private func configTableView() {
    tableView.register(CoverCell.self)
    tableView.register(TeacherCell.self)
    tableView.tableFooterView = UIView()
  }
}

// MARK: - UITableViewDataSource
extension TeacherViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSections()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfItems(inSection: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let sectionType = viewModel.sections[indexPath.section]

    switch sectionType {
    case .teachers:
      guard let vm = try? viewModel.viewModelForItem(at: indexPath) else { return TableCell() }
      let cell = tableView.dequeue(TeacherCell.self)
      cell.viewModel = vm
      return cell
    case .cover:
      let cell = tableView.dequeue(CoverCell.self)
      return cell
    }
  }
}

// MARK: - UITableViewDelegate
extension TeacherViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return viewModel.heightForRowAtIndexPath(indexPath: indexPath)
  }
}

// MARK: - Define, Config
extension TeacherViewController {
  struct Define {
    static let title = "Teachers"
  }
}
