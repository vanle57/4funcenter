//
//  HomeViewController.swift
//  MyApp
//
//  Created by PCM0023 on 7/30/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

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
        initCollectionView()
    }

    // MARK: - Setup UI
    override func setupUI() {
        super.setupUI()
        title = Define.title
        collectionView.register(HomeCollectionViewCell.self)
        configTableView()
    }

    // MARK: - Setup Data
    override func setupData() {
        super.setupData()
    }

    // MARK: - Private funcs
    private func initCollectionView() {
        collectionView.startScrolling()
    }

    private func configTableView() {
        tableView.register(HomeTableViewCell.self)
        tableView.register(HeaderView.self)
        tableView.rowHeight = Config.rowHeight * ratio
    }

    /// Set page control folow collection View
    private func setCurrentPage() {
        guard let cell = collectionView.visibleCells.first,
            let indexPath = collectionView.indexPath(for: cell) else { return }
        pageControl.currentPage = indexPath.row
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(HomeCollectionViewCell.self, forIndexPath: indexPath)
        cell.imageView.image = viewModel.viewModelForCollectionViewCell(indexPath: indexPath)
        return cell
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

// MARK: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
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
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Config.headerHeight * ratio
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
