//
//  HomeTableViewCell.swift
//  MyApp
//
//  Created by PCI0007 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class HomeCell: UITableViewCell {

  // MARK: - Outlet
  @IBOutlet weak var collectionView: UICollectionView!

  // MARK: - Property
  var viewModel = HomeCellViewModel()

  // MARK: - func
  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.register(TeacherHomeCell.self)
    NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .reloadData, object: nil)
  }

  @objc func reloadData() {
    collectionView.reloadData()
  }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfItem()
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeue(TeacherHomeCell.self, forIndexPath: indexPath)
    cell.updateView(with: viewModel.viewModelForCollectionViewcell(at: indexPath))
    return cell
  }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeCell: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.height * 0.7, height: collectionView.frame.height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .zero
  }
}
