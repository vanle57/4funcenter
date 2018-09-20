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

    enum CategoryRowType: String {
        case blog = "blog"
        case course = "courses"
        case teacher = "teacher"
        case about = "about"
    }

    enum ProfileItemRowType: String {
        case myCourses = "my courses"
        case results = "results"
        case me = "me"
        case logout = "log out"
    }

    // MARK: - Properties
    var sections: [SectionType] = [.main, .profileItem]
    var categories: [CategoryRowType] = [.blog, .course, .teacher, .about]
    var profileItem: [ProfileItemRowType] = [.myCourses, .results, .me, .logout]
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
            let viewModel = SideMenuCellViewModel(title: category.rawValue, isNotMain: false)
            return viewModel
        case .profileItem:
            guard index < profileItem.count else {
                throw App.Error.indexOutOfBound
            }
            let item = profileItem[index]
            let viewModel = SideMenuCellViewModel(title: item.rawValue, isNotMain: true)
            return viewModel
        }
    }

    func didSelectRow(at indexPath: IndexPath) throws -> SectionType {
        let section = indexPath.section
        guard section < sections.count else {
            throw App.Error.indexOutOfBound
        }
        let sectionType = sections[section]
        return sectionType
    }
}
