//
//  SideMenuViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

final class SideMenuViewModel: MVVM.ViewModel {
    // MARK: - enum
    enum SectionType {
        case main
        case profileItem
    }

    // MARK: - Properties
    var sections: [SectionType] = [.main, .profileItem]
    var categories = Define.categories
    var profileItem = Define.profileItem
}

// MARK: - Table view
extension SideMenuViewModel {
    func numberOfSections() -> Int {
        return sections.count
    }

    func numberOfItems(inSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .main:
            return categories.count
        case .profileItem:
            return profileItem.count
        }
    }

    func viewModelForItem(at indexPath: IndexPath) throws -> SideMenuCellViewModel {
        let section = indexPath.section
        guard section < sections.count else {
            throw App.Error.indexOutOfBound
        }
        let sectionType = sections[section]
        let index = indexPath.row
        switch sectionType {
        case .main:
            guard index < categories.count else {
                throw App.Error.indexOutOfBound
            }
            let category = categories[index]
            let viewModel = SideMenuCellViewModel(title: category, isNotMain: false)
            return viewModel
        case .profileItem:
            guard index < profileItem.count else {
                throw App.Error.indexOutOfBound
            }
            let item = profileItem[index]
            let viewModel = SideMenuCellViewModel(title: item, isNotMain: true)
            return viewModel
        }
    }
}

// MARK: - Define
extension SideMenuViewModel {
    struct Define {
        static let categories = ["Courses", "Blog", "Teacher", "About"]
        static let profileItem = ["My Courses", "Results", "Me"]
    }
}
