//
//  TeacherTableCell.swift
//  MyApp
//
//  Created by MBA0002 on 9/26/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class TeacherTableCell: TableCell {

    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel = TeacherTableCellViewModel()

    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }

    private func configCollectionView() {
        collectionView.register(TeacherCollectionCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension TeacherTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let viewModel = try? viewModel.viewModelForItem(at: indexPath) {
            let cell = collectionView.dequeue(TeacherCollectionCell.self, forIndexPath: indexPath)
            cell.viewModel = viewModel
            return cell
        }
        return CollectionCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TeacherTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = frame.width / 2 - Config.margin
        return CGSize(width: cellWidth * ratio,
                      height: cellWidth / Config.cellRatio * ratio)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Config.padding, left: Config.padding, bottom: Config.padding, right: Config.padding)
    }
}

// MARK: - Define, Config
extension TeacherTableCell {
    struct Config {
        static let cellRatio: CGFloat = 3 / 4
        static let margin: CGFloat = 60
        static let padding: CGFloat = 40 * ratio
    }
}
