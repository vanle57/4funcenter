//
//  HomeTableViewCell.swift
//  MyApp
//
//  Created by PCI0007 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {

  // MARK: - Outlet
  @IBOutlet weak var collectionView: UICollectionView!

  // MARK: - Property
  var viewModel = HomeTableCellModel()

  // MARK: - func
  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.register(TeacherCollectionViewCell.self)
    collectionView.dataSource = self
    collectionView.delegate = self
    NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .reloadData, object: nil)
  }

  @objc func reloadData() {
    collectionView.reloadData()
  }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfItem()
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeue(TeacherCollectionViewCell.self, forIndexPath: indexPath)
    cell.viewModel = viewModel.viewModelForCollectionViewcell(at: indexPath)
    return cell
  }

}

extension HomeTableViewCell: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.height * 0.7, height: collectionView.frame.height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
}
