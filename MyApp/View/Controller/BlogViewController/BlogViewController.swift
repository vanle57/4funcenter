//
//  BlogViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/11/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SwiftUtils

final class BlogViewController: BaseViewController {

  // MARK: - Outlet
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var collectionView: BJAutoScrollingCollectionView!
  @IBOutlet weak var pageControl: UIPageControl!

  var viewModel = BlogViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    initCollectionView()
  }

  override func setupUI() {
    super.setupUI()
    title = Define.title
    configNavigationBar()
    configTableView()
    configSlide()
  }

  override func setupData() {
    super.setupData()
    viewModel.loadEntries(completion: { [weak self] (result) in
      guard let this = self else { return }
      switch result {
      case .success:
        this.tableView.reloadData()
      case .failure(let error):
        this.alert(error: error)
      }
    })
  }

  // MARK: - Private functions
  private func configNavigationBar() {
    let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_search"), style: .plain, target: self, action: #selector(showSearchView))
    navigationItem.rightBarButtonItem = searchButton
  }

  private func configTableView() {
    tableView.register(BlogCell.self)
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = Config.estimateRowHeight * ratio
  }

  private func configSlide() {
    pageControl.numberOfPages = viewModel.numberOfSlides()
    collectionView.register(SlideCollectionCell.self)
  }

  private func initCollectionView() {
    collectionView.startScrolling()
  }

  /// Set page control folow collection View
  private func setCurrentPage() {
    let pageWidth = collectionView.frame.width
    pageControl.currentPage = Int(collectionView.contentOffset.x / pageWidth)
  }

  @objc func showSearchView() {
    let viewModel = SearchViewModel(type: .entry)
    let vc = SearchViewController()
    vc.viewModel = viewModel
    navigationController?.pushViewController(vc, animated: true)
  }
}

// MARK: - UICollectionViewDataSource
extension BlogViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfSlides()
  }

  func collectionView(_ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let viewModel = try? viewModel.viewModelForSlideCell(indexPath: indexPath) {
      let cell = collectionView.dequeue(SlideCollectionCell.self, forIndexPath: indexPath)
      cell.viewModel = viewModel
      return cell
    }
    return CollectionCell()
  }

}

// MARK: - UICollectionViewDelegate
extension BlogViewController: UICollectionViewDelegate {
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
extension BlogViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }
}

// MARK: - UITableViewDataSource
extension BlogViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let numberOfRow = try? viewModel.numberOfItems(inSection: section) {
      return numberOfRow
    }
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let viewModel = try? viewModel.viewModelForItem(at: indexPath) else {
      return TableCell()
    }

    let cell = tableView.dequeue(BlogCell.self)
    cell.viewModel = viewModel
    return cell

  }
}

// MARK: - Define, Config
extension BlogViewController {
  struct Define {
    static let title = "Blog"
  }

  struct Config {
    static let estimateRowHeight: CGFloat = 303
  }
}
