//
//  BlogViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

final class BlogViewModel: MVVM.ViewModel {

    // MARK: - enum
    enum SectionType {
        case slide
        case entry
    }

    // MARK: - Properties
    var sections: [SectionType] = [.slide, .entry]
    var entries = DummyData.fetchEntries()
}

// MARK: - Table view
extension BlogViewModel {
    func numberOfSections() -> Int {
        return sections.count
    }

    func numberOfItems(inSection section: Int) throws -> Int {
        guard section < sections.count else {
            throw App.Error.indexOutOfBound
        }

        let sectionType = sections[section]

        switch sectionType {
        case .entry:
            return entries.count
        case .slide:
            return Config.numberOfSlide
        }
    }

    func viewModelForItem(at indexPath: IndexPath) throws -> ViewModel {
        let section = indexPath.section
        
        guard section < sections.count else {
            throw App.Error.indexOutOfBound
        }

        let sectionType = sections[section]
        let index = indexPath.row

        switch sectionType {
        case .entry:
            guard index < entries.count else {
                throw App.Error.indexOutOfBound
            }

            let entry = entries[index]
            let viewModel = BlogCellViewModel(entry: entry)
            return viewModel
        case .slide:
            return SlideCellViewModel()
        }
    }
}

// MARK: - Define
extension BlogViewModel {
    struct Config {
        static let numberOfSlide = 1
    }
}
