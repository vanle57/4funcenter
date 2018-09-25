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
        pageControl.numberOfPages = viewModel.numberOfSlides()
        configNavigationBar()
        configSlide()
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
        pageControl.numberOfPages = viewModel.numberOfSlides()
        collectionView.register(SlideCollectionCell.self)
    }

    /// Set page control folow collection View
    private func setCurrentPage() {
        let pageWidth = collectionView.frame.width
        pageControl.currentPage = Int(collectionView.contentOffset.x / pageWidth)
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
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
