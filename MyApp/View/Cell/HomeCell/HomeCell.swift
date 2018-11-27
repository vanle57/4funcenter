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
    collectionView.dataSource = self
    collectionView.delegate = self
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
    cell.viewModel = viewModel.viewModelForCollectionViewcell(at: indexPath)
    return cell
  }

}

extension HomeCell: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.height * 0.7, height: collectionView.frame.height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
}
