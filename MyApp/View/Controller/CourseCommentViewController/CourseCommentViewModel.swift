//
//  CourseCommentViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 10/1/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import MVVM

final class CourseCommentViewModel: ViewModel {

    var comments: [Comment] = []
}

// MARK: - Table view
extension CourseCommentViewModel {
    func numberOfItems(inSection section: Int) -> Int {
        return comments.count
    }

    func viewModelForItem(at indexPath: IndexPath) throws -> CourseCommentCellViewModel {
        let index = indexPath.row
        guard index < comments.count else {
            throw App.Error.indexOutOfBound
        }

        let comment = comments[index]
        return CourseCommentCellViewModel(comment: comment)
    }
}
