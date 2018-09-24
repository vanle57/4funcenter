//
//  HomeViewModel.swift
//  MyApp
//
//  Created by PCI0007 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

final class HomeViewModel: ViewModel {

    enum SectionType {
        case teacher
        case blog
        case course

        var title: String {
            switch self {
            case .teacher:
                return "Teacher"
            case .blog:
                return "Blog"
            case .course:
                return "Course"
            }
        }
    }

    var sections: [SectionType] = [.blog, .course, .teacher]

    let images: [UIImage] = [#imageLiteral(resourceName: "image3"), #imageLiteral(resourceName: "image4"), #imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image7"), #imageLiteral(resourceName: "image8")]
    var teachers = DummyData.fetchTeachers()

    func viewModelForCollectionViewCell(indexPath: IndexPath) -> UIImage {
        return images[indexPath.row]
    }
}

extension HomeViewModel {
    func numberOfSections() -> Int {
        return sections.count
    }

    func numberOfItems(inSection section: Int) -> Int {
        return Config.numberOfRow
    }

    func viewModelForItem(at indexPath: IndexPath) throws -> HomeTableCellModel {
        let section = indexPath.section

        guard section < sections.count else {
            throw App.Error.indexOutOfBound
        }

        let cellModel = HomeTableCellModel()
        cellModel.teachers = teachers
        return cellModel
    }

    func viewModelForHeader(inSection section: Int) throws -> HeaderViewModel {
//        guard section < sections.count else {
//            throw App.Error.indexOutOfBound
//        }

        let sectionType = sections[section]

        switch sectionType {
        case .blog:
            return HeaderViewModel(title: sectionType.title)
        case .course:
            return HeaderViewModel(title: sectionType.title)
        case .teacher:
            return HeaderViewModel(title: sectionType.title)
        }
    }
}

extension HomeViewModel {
    struct Config {
        static let numberOfRow = 1
    }
}
