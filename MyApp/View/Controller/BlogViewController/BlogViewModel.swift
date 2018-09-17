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
    var entries = DummyData.fetchEntries()
}

extension BlogViewModel {
    func numberOfItems(inSection section: Int) -> Int {
        return entries.count
    }

    func viewModelForItem(at indexPath: IndexPath) throws -> BlogCellViewModel {
        let index = indexPath.row
        guard index < entries.count else {
            throw App.Error.indexOutOfBound
        }
        let entry = entries[index]
        let viewModel = BlogCellViewModel(entry: entry)
        return viewModel
    }
}
