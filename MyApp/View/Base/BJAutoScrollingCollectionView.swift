//
//  BJAutoScrollingCollectionView.swift
//  MyApp
//
//  Created by PCI0007 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

enum BJAutoScrollingCollectionViewDirection: String {
    case left = "left"
    case right = "right"
}

/**BJAutoScrollingCollectionView is a simple UICollectionView subclass which will automatically scroll cells of the collection view in specified time intervals. Just make your collection view an instance of BJAutoScrollingCollectionView and call the startScrolling method to start auto-scrolling.
 * Make sure you set your custom collection view cell's frame size equal to your collection view frame size. There should be only one visible cell in your collection view at a time.
 * Paging is enabled by default even if you did not enable it.
 */
class BJAutoScrollingCollectionView: UICollectionView {

    private var timer = Timer()

    var scrollInterval: Int = 5
    deinit { stopScrolling() }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.isPagingEnabled = true
    }

    fileprivate func setTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(scrollInterval), target: self, selector: #selector(self.autoScrollImageSlider), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer, forMode: .commonModes)
    }

    /**
     * Starts scrolling the collection view if there is at least one item in the datsource.
     */
    func startScrolling() {
        if !timer.isValid {
            if self.numberOfItems(inSection: 0) != 0 {
                stopScrolling()
                setTimer()
            }
        }
    }

    func stopScrolling() { if timer.isValid { self.timer.invalidate() } }

    @objc fileprivate func autoScrollImageSlider() {
        DispatchQueue.main.async {
            let firstIndex = 0
            let lastIndex = self.numberOfItems(inSection: 0) - 1
            let visibleCellsIndexes = self.indexPathsForVisibleItems.sorted()

            if !visibleCellsIndexes.isEmpty {
                let nextIndex = visibleCellsIndexes[0].row + 1
                let nextIndexPath: IndexPath = IndexPath(item: nextIndex, section: 0)
                let firstIndexPath: IndexPath = IndexPath(item: firstIndex, section: 0)
                (nextIndex > lastIndex) ? (self.scrollToItem(at: firstIndexPath,
                                                             at: .centeredHorizontally, animated: true)) : (self.scrollToItem(at: nextIndexPath,
                                                                                                                              at: .centeredHorizontally, animated: true))
            }
        }
    }

    func scrollToPreviousOrNextCell(direction: BJAutoScrollingCollectionViewDirection) {
        DispatchQueue.main.async {
            let firstIndex = 0
            let lastIndex = self.numberOfItems(inSection: 0) - 1
            let visibleCellsIndexes = self.indexPathsForVisibleItems.sorted()

            if !visibleCellsIndexes.isEmpty {
                let nextIndex = visibleCellsIndexes[0].row + 1
                let previousIndex = visibleCellsIndexes[0].row - 1
                let nextIndexPath: IndexPath = IndexPath(item: nextIndex, section: 0)
                let previousIndexPath: IndexPath = IndexPath(item: previousIndex, section: 0)

                switch direction {
                case .left:
                    (previousIndex < firstIndex) ? self.doNothing() : self.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
                //                    break
                case .right:
                    (nextIndex > lastIndex) ? self.doNothing() : self.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                    //                    break
                }
            }
        }
    }

    private func doNothing() { }
}
