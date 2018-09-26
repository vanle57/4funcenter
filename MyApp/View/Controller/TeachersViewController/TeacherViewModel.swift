//
//  TeacherViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/26/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import MVVM

final class TeacherViewModel: ViewModel {

    // MARK: - enum
    enum SectionType {
        case cover
        case teachers
    }

    // MARK: - Properties
    var sections: [SectionType] = [.cover, .teachers]
}

// MARK: - Table view
extension TeacherViewModel {
    func numberOfSections() -> Int {
        return sections.count
    }

    func numberOfItems(inSection section: Int) -> Int {
        return Config.numberOfRows
    }

    func viewModelForItem(at indexPath: IndexPath) throws -> TeacherTableCellViewModel {
        let section = indexPath.section

        guard section < sections.count else {
            throw App.Error.indexOutOfBound
        }

        return TeacherTableCellViewModel()
    }

    func heightForRowAtIndexPath(indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section

        guard section < sections.count else {
            return CGFloat(0)
        }

        let secionType = sections[section]

        switch secionType {
        case .cover:
            return Config.heightOfCover
        case .teachers:
            return Config.heightOfCollection
        }
    }
}

// MARK: - Define
extension TeacherViewModel {
    struct Config {
        static let numberOfRows = 1
        static let heightOfCover: CGFloat = 150 * ratio
        static let heightOfCollection: CGFloat = (667 - 150) * ratio
    }
}
