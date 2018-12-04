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

    lazy var detailVC: CourseDetailViewController = {
        let detailVC = CourseDetailViewController()
        guard let viewModel = viewModel else { return detailVC }
        detailVC.viewModel = viewModel.viewModelForDetailView()
        return detailVC
    }()

    lazy var commentVC: CourseCommentViewController = {
        let commentVC = CourseCommentViewController()
        guard let viewModel = viewModel else { return commentVC }
        commentVC.viewModel = viewModel.viewModelForCommentView()
        return commentVC
    }()

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

//        navigationItem.setLeftBarButton(title+ imag, target: , action:)
    }

    private func configCollectionView() {
        pageMenuCollectionView.register(PageMenuCell.self)
    }

    private func configDefaultChildView() {
        displayView.addSubview(commentVC.view)
        displayView.addSubview(detailVC.view)
        addChildViewController(detailVC)
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
        if indexPath.row == viewModel.rowSelected {
            return
        } else {
            guard let cell = collectionView.cellForItem(at: indexPath) as? PageMenuCell else { return }
            viewModel.rowSelected = indexPath.row
            cell.viewModel?.isSelected = true
            pageMenuCollectionView.reloadData()
        }

        guard let menuItem = try? viewModel.getItem(at: indexPath) else { return }

        switch menuItem {
        case .detail:
            for subview in displayView.subviews {
                subview.isHidden = subview != detailVC.view
            }
        case .comment:
            for subview in displayView.subviews {
                subview.isHidden = subview != commentVC.view
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
