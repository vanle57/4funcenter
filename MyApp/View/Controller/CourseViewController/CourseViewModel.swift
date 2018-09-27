//
//  CourseViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/27/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import MVVM

final class CourseViewModel: ViewModel {

    enum MenuItem {
        case detail
        case comment

        var title: String {
            switch self {
            case .detail:
                return "DETAIL"
            case .comment:
                return "COMMENT"
            }
        }
    }

    var items: [MenuItem] = [.detail, .comment]
    var currentItem: MenuItem = .detail

    var title = ""
    init(course: Course) {
        title = course.name
    }
}

extension CourseViewModel {
    func numberOfItems(inSection section: Int) -> Int {
        return items.count
    }

    func viewModelForItem(at indexPath: IndexPath) throws -> PageMenuCellViewModel {
        let index = indexPath.row

        guard index < items.count  else {
            throw App.Error.indexOutOfBound
        }

        let item = items[index]
        switch item {
        case .detail:
            return PageMenuCellViewModel(title: item.title, isSelected: true)
        case .comment:
            return PageMenuCellViewModel(title: item.title, isSelected: false)
        }

    }
}
