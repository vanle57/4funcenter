//
//  ListTopicViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 8/2/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

final class ListTopicViewModel: MVVM.ViewModel {

    // MARK: - Properties
    var idLevel = 1
    var topics: [Topic] = []
    var topicProgresses: [Float] = []

    // MARK: - init
    init(idLevel: Int = 1) {
        self.idLevel = idLevel
    }

    func loadData() {
        topics = DummyData.fetchEYETopic(idLevel: idLevel)
        topicProgresses = DummyData.fetchTopicProgress()
    }
}

extension ListTopicViewModel {
    func numberOfItems(inSection section: Int) -> Int {
        return topics.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> ListTopicCellViewModel {
        let title = topics[indexPath.row].name
        let progress = topicProgresses[indexPath.row]
        let listTopicCellViewModel = ListTopicCellViewModel(topicTitle: title, progress: progress)
        return listTopicCellViewModel
    }
}
