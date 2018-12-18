//
//  CoursesViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/11/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SVProgressHUD

final class CoursesViewController: BaseViewController {

  // MARK: - Outlets
  @IBOutlet weak var tableView: UITableView!

  var viewModel = CoursesViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func setupUI() {
    super.setupUI()
    title = Define.title
    configNavigationBar()
    configTableView()
  }

  override func setupData() {
    super.setupData()
    SVProgressHUD.show()
    viewModel.loadCourses { [weak self] (result) in
      SVProgressHUD.popActivity()
      guard let this = self else { return }
      switch result {
      case .success:
        this.tableView.reloadData()
      case .failure(let error):
        this.alert(error: error)
      }
    }
  }

  // MARK: - Private functions
  private func configNavigationBar() {
    let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_search"), style: .plain, target: self, action: #selector(showSearchView))
    navigationItem.rightBarButtonItem = searchButton
  }

  private func configTableView() {
    tableView.register(CourseCell.self)
    tableView.register(CoverCell.self)
    tableView.rowHeight = 150
    tableView.tableFooterView = UIView()
    tableView.estimatedRowHeight = Config.estimateRowHeight * ratio
  }

  @objc func showSearchView() {
    let viewModel = SearchViewModel(type: .entry)
    let vc = SearchViewController(viewModel: viewModel)
    navigationController?.pushViewController(vc, animated: true)
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
      guard let cellVM = try? viewModel.viewModelForItem(at: indexPath) else { return TableCell() }
      let cell = tableView.dequeue(CourseCell.self)
      cell.updateView(with: cellVM)
      return cell
    case .cover:
      let cell = tableView.dequeue(CoverCell.self)
      return cell
    }
  }
}

// MARK: - UITableViewDelegate
extension CoursesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vm = viewModel.didSelectRowAtIndexPath(indexPath: indexPath)
    let vc = CourseViewController()
    vc.viewModel = vm
    navigationController?.pushViewController(vc, animated: true)
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
