//
//  SearchViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

final class SearchViewModel: ViewModel {

    // MARK: - enum
    enum SearchType {
        case entry
        case course
    }

    enum SearchResult {
        case success
        case failure(Error)
    }

    typealias SearchCompletion = (SearchResult) -> Void

    var type: SearchType = .entry
    var entries: [Entry] = []
    var courses: [Course] = []
    var histories: [String] = []

    func search(keyword: String, _ completion: SearchCompletion) {

    }
}

// MARK: - Result table view
extension SearchViewModel {

    func numberOfResultItems(inSection section: Int) -> Int {
        switch type {
        case .entry:
            return entries.count
        case .course:
            return courses.count
        }
    }

    func viewModelForResultItem(at indexPath: IndexPath) throws -> ViewModel {
        let index = indexPath.row

        switch type {
        case .entry:
            guard index < entries.count else {
                throw App.Error.indexOutOfBound
            }

            let entry = entries[index]
            return BlogCellViewModel(entry: entry)
        case .course:
            guard index < courses.count else {
                throw App.Error.indexOutOfBound
            }

            let course = courses[index]
            return CourseCellViewModel(course: course)
        }
    }
}

// MARK: - History table view
extension SearchViewModel {

    func numberOfHistoryItems(inSection section: Int) -> Int {
        return histories.count
    }

    func viewModelForHistoryItem(at indexPath: IndexPath) throws -> HistorySearchCellViewModel {
        let index = indexPath.row

        guard index < histories.count else {
            throw App.Error.indexOutOfBound
        }

        let history = histories[index]
        return HistorySearchCellViewModel(title: history)
    }
}
