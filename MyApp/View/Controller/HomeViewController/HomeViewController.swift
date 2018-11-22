//
//  HomeViewController.swift
//  MyApp
//
//  Created by PCM0023 on 7/30/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SVProgressHUD

final class HomeViewController: BaseViewController {

  // MARK: - Outlets
  @IBOutlet weak var collectionView: BJAutoScrollingCollectionView!
  @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var tableView: UITableView!

  // MARK: - Property
  let viewModel = HomeViewModel()

  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: - Setup UI
  override func setupUI() {
    super.setupUI()
    title = Define.title
    configNavigationBar()
    configSlide()
    configTableView()
  }

  // MARK: - Setup Data
  override func setupData() {
    super.setupData()
    SVProgressHUD.show()
    viewModel.loadSlides(completion: { [weak self] (result) in
      guard let this = self else { return }
      switch result {
      case .success:
        this.pageControl.numberOfPages = this.viewModel.numberOfSlides()
        this.collectionView.reloadData()
        this.collectionView.startScrolling()
      case .failure(let error):
        this.alert(error: error)
      }
    })

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

  // MARK: - Private funcs
  private func configNavigationBar() {
    let notificationButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_notification"), style: .plain, target: self, action: nil)
    navigationItem.rightBarButtonItem = notificationButton
  }

  private func configTableView() {
    tableView.register(HomeTableViewCell.self)
    tableView.register(HeaderView.self)
    tableView.rowHeight = Config.rowHeight * ratio
    tableView.tableFooterView = UIView()
  }

  private func configSlide() {
    collectionView.register(SlideCollectionCell.self)
  }

  /// Set page control folow collection View
  private func setCurrentPage() {
    let pageWidth = collectionView.frame.width
    pageControl.currentPage = Int(collectionView.contentOffset.x / pageWidth)
  }

  private func navigateToViewController(index: Int) {
    guard let sectionType = try? viewModel.getSectionType(index: index) else {
      return
    }
    switch sectionType {
    case .blog:
      pushToViewController(viewController: BlogViewController())
    case .course:
      pushToViewController(viewController: CoursesViewController())
    case .teacher:
      pushToViewController(viewController: TeacherViewController())
    }
  }

  private func pushToViewController(viewController: UIViewController) {
    guard let mainViewController = sideMenuController else { return }
    let navigationController = mainViewController.rootViewController as? UINavigationController
    mainViewController.hideLeftView()
    navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfSlides()
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let viewModel = try? viewModel.viewModelForSlideCell(indexPath: indexPath) {
      let cell = collectionView.dequeue(SlideCollectionCell.self, forIndexPath: indexPath)
      cell.viewModel = viewModel
      return cell
    }
    return CollectionCell()
  }

}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    setCurrentPage()
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    setCurrentPage()
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    setCurrentPage()
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    pushToViewController(viewController: AboutViewController())
  }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSections()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfItems(inSection: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let viewModel = try? viewModel.viewModelForItem(at: indexPath) else {
      return TableCell()
    }

    let cell = tableView.dequeue(HomeTableViewCell.self)
    cell.viewModel = viewModel
    return cell
  }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

    guard let viewModel = try? viewModel.viewModelForHeader(inSection: section) else {
      return UITableViewHeaderFooterView()
    }

    let headerView = tableView.dequeue(HeaderView.self)
    headerView.viewModel = viewModel
    headerView.delegate = self
    return headerView
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return Config.headerHeight * ratio
  }
}

// MARK: - HeaderViewDelegate
extension HomeViewController: HeaderViewDelegate {
  func headerView(_ view: HeaderView, needPerform action: HeaderView.Action) {
    switch action {
    case .navigatetoViewController(let index):
      navigateToViewController(index: index)
    }
  }
}

// MARK: - Define
extension HomeViewController {
  struct Define {
    static let title = "Home"
  }

  struct Config {
    static let rowHeight: CGFloat = 100
    static let headerHeight: CGFloat = 40
  }
}
