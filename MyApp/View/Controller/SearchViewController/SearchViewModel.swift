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
    var histories: [String]?

    init() { }

    init(type: SearchType) {
        self.type = type
    }

    func loadHistory() {
        histories = App.userDefault.array(forKey: App.KeyUserDefault.historySearch) as? [String]
    }

    func saveHistory(keyword: String) {
        histories = App.userDefault.array(forKey: App.KeyUserDefault.historySearch) as? [String]

        guard var histories = histories else {
            App.userDefault.set([keyword], forKey: App.KeyUserDefault.historySearch)
            return
        }

        if !histories.contains(keyword) {
            histories.append(keyword)
            App.userDefault.set(histories, forKey: App.KeyUserDefault.historySearch)
        }
    }

    func deleteHistory() {
        App.userDefault.removeObject(forKey: App.KeyUserDefault.historySearch)
        histories = nil
    }

    func search(keyword: String, _ completion: SearchCompletion) {
        saveHistory(keyword: keyword)

        switch type {
        case .entry:
             // TODO: query api search blog with keyword
            completion(.success)
        case .course:
            // TODO: query api search course with keyword
            completion(.success)
        }
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
        guard let histories = histories else { return 0 }
        return histories.count
    }

    func viewModelForHistoryItem(at indexPath: IndexPath) throws -> HistorySearchCellViewModel {
        guard let histories = histories else {
            throw App.Error.unknown
        }

        let index = indexPath.row

        guard index < histories.count else {
            throw App.Error.indexOutOfBound
        }

        let history = histories[index]
        return HistorySearchCellViewModel(history: history)
    }

    func didSelectHistory(at indexPath: IndexPath) -> String {
        guard let histories = histories else { return "" }

        let row = indexPath.row

        guard row < histories.count else {
            return ""
        }

        let history = histories[row]
        return history
    }
}
