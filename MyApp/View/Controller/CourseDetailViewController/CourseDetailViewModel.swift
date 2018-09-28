//
//  File.swift
//  MyApp
//
//  Created by MBA0002 on 9/27/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import MVVM

final class CourseDetailViewModel: ViewModel {

    // MARK: - enum
    enum SectionType {
        case name
        case infor
    }

    enum InforRowType {
        case time
        case fee
        case detail
        case classes

        var title: String {
            switch self {
            case .time:
                return "Time"
            case .fee:
                return "Fee"
            case .detail:
                return "Detail"
            case .classes:
                return "Classes"
            }
        }
    }

    var sections: [SectionType] = [.name, .infor]
    var rows: [InforRowType] = [.time, .fee, .detail, .classes]

    var course: Course = Course()

    init() { }

    init(course: Course) {
        self.course = course
    }
}

extension CourseDetailViewModel {
    func numberOfSections() -> Int {
        return sections.count
    }

    func numberOfItems(inSection section: Int) throws -> Int {
        guard section < sections.count else {
            throw App.Error.indexOutOfBound
        }

        let sectionType = sections[section]

        switch sectionType {
        case .name:
            return 1
        case .infor:
            return rows.count
        }
    }

    func viewModelForItem(at indexPath: IndexPath) throws -> CourseDetailCellViewModel {
        let section = indexPath.section
        let index = indexPath.row

        guard section < sections.count, index < rows.count else {
            throw App.Error.indexOutOfBound
        }

        let rowType = rows[index]
        switch rowType {
        case .time:
            return CourseDetailCellViewModel(title: rowType.title, content: course.time)
        case .fee:
            return CourseDetailCellViewModel(title: rowType.title, content: "\(course.fee)")
        case .detail:
            return CourseDetailCellViewModel(title: rowType.title, content: course.detail)
        case .classes:
            return CourseDetailCellViewModel(title: rowType.title, content: Define.classDummyData)
        }
    }

    func getSectionType(at indexPath: IndexPath) throws -> SectionType {
        let section = indexPath.section

        guard section < sections.count else {
            throw App.Error.indexOutOfBound
        }

        return sections[section]
    }
}

extension CourseDetailViewModel {
    struct Define {
        static let classDummyData = "3-4-6 17h30:19h00; 2-4-6 8h00:10h30"
    }
}
