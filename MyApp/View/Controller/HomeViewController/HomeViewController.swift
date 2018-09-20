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
        tableView.register(HomeTableViewCell.self)
        tableView.rowHeight = 150
    }

    // MARK: - Setup Data
    override func setupData() {
        super.setupData()
    }

    // MARK: - Private funcs
    private func initCollectionView() {
        collectionView.startScrolling()
    }


    /// Set page control folow collection View
    private func setCurrentPage() {
        guard let cell = collectionView.visibleCells.first,
            let indexPath = collectionView.indexPath(for: cell) else { return }
        pageControl.currentPage = indexPath.row
    }

    // insert action for each 'seeMore' button
    @objc private func seeMoreButtonTapped() {
        print("SeeMore Tapped")
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
        return viewModel.numberOfSection()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberItemOfSection(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(HomeTableViewCell.self)
        cell.viewModel = viewModel.viewModelForTableViewCell(indexPath: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: tableView.frame.width,
                                              height: tableView.sectionHeaderHeight))
        let seeMoreButton = UIButton(frame: CGRect(x: headerView.frame.width * 3 / 4,
                                                   y: 0,
                                                   width: headerView.frame.width / 4,
                                                   height: headerView.frame.height))
        let titleLable = UILabel(frame: CGRect(x: 10,
                                               y: 0,
                                               width: headerView.frame.width * 3 / 4,
                                               height: headerView.frame.height))
        switch section {
        case 0:
            titleLable.text = "Blog"
        case 1:
            titleLable.text = "Course"
        default:
            titleLable.text = "Teacher"
        }

        titleLable.textColor = .black
        seeMoreButton.setTitle("More >", for: .normal)
        seeMoreButton.titleLabel?.font = UIFont(name: "heebo", size: 13.0)
        seeMoreButton.setTitleColor(.black, for: .normal)
        seeMoreButton.addTarget(self,
                                action: #selector(seeMoreButtonTapped),
                                for: .touchUpInside)
        headerView.addSubview(titleLable)
        headerView.addSubview(seeMoreButton)
        headerView.backgroundColor = App.Color.yellowColor
        return headerView
    }
}

extension HomeViewController {
    struct Define {
        static let title = "Home"
    }
}
