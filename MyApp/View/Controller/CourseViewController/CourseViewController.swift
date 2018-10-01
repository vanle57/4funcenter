//
//  CourseViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/27/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var pageMenuCollectionView: UICollectionView!
    @IBOutlet weak var displayView: UIView!

    var viewModel: CourseViewModel? {
        didSet {
            title = viewModel?.course.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        configCollectionView()
        configDefaultChildView()
    }

    // MARK: - Private functions
    private func configNavigationBar() {
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backButton

        let notificationButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_notification"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = notificationButton
    }

    private func configCollectionView() {
        pageMenuCollectionView.register(PageMenuCell.self)
    }

    private func configDefaultChildView() {
        guard let viewModel = viewModel else { return }
        let child = CourseDetailViewController()
        child.viewModel = viewModel.defaultChildViewModel()
        addChildViewController(child)
        displayView.addSubview(child.view)
        child.didMove(toParentViewController: self)
    }

    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension CourseViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfItems(inSection: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let viewModel = viewModel, let vm = try? viewModel.viewModelForItem(at: indexPath) else { return CollectionCell() }

        let cell = pageMenuCollectionView.dequeue(PageMenuCell.self, forIndexPath: indexPath)
        cell.viewModel = vm
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CourseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pageMenuCollectionView.frame.width / 2,
                      height: pageMenuCollectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Config.minimumSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Config.minimumSpacing
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        if indexPath.row != viewModel.rowSelected {
            guard let cell = collectionView.cellForItem(at: indexPath) as? PageMenuCell else { return }
            viewModel.rowSelected = indexPath.row
            cell.viewModel?.isSelected = true
            pageMenuCollectionView.reloadData()
        }

        showViewControllerForSelectedItem(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PageMenuCell else { return }
        cell.viewModel?.isSelected = false
        cell.updateUI()
    }

    func showViewControllerForSelectedItem(at indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }

        if let item = try? viewModel.getItem(at: indexPath), let viewModel = try? viewModel.viewModelForChildView(at: indexPath) {
            switch item {
            case .detail:
                guard let vm = viewModel as? CourseDetailViewModel else { return }
                let childVC = CourseDetailViewController()
                childVC.viewModel = vm
                addChildViewController(childVC)
                displayView.addSubview(childVC.view)
                childVC.didMove(toParentViewController: self)
            case .comment:
                guard let vm = viewModel as? CourseCommentViewModel else { return }
                let childVC = CourseCommentViewController()
                childVC.viewModel = vm
                addChildViewController(childVC)
                displayView.addSubview(childVC.view)
                childVC.didMove(toParentViewController: self)
            }
        }
    }
}

// MARK: - Config
extension CourseViewController {
    struct Config {
        static let minimumSpacing: CGFloat = 0
    }
}
