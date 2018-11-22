//
//  TeacherViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/26/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import MVVM

final class TeacherViewModel: ViewModel {

  // MARK: - enum
  enum SectionType {
    case cover
    case teachers
  }
  
  enum LoadTeacherCompletion {
    case success
    case failure(Error)
  }

  // MARK: - Properties
  var sections: [SectionType] = [.cover, .teachers]
  var teachers: [Teacher] = []
  
  func loadTeachers(completion: @escaping (LoadTeacherCompletion) -> Void) {
    Api.Teacher.loadTeachers { [weak self] (result) in
      guard let this = self else { return }
      switch result {
      case .success(let teachers):
        this.teachers = teachers
        completion(.success)
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

}

// MARK: - Table view
extension TeacherViewModel {
  func numberOfSections() -> Int {
    return sections.count
  }

  func numberOfItems(inSection section: Int) -> Int {
    return Config.numberOfRows
  }

  func viewModelForItem(at indexPath: IndexPath) throws -> TeacherTableCellViewModel {
    let section = indexPath.section

    guard section < sections.count else {
      throw App.Error.indexOutOfBound
    }

    let cellViewModel = TeacherTableCellViewModel()
    cellViewModel.teachers = teachers
    return cellViewModel
  }

  func heightForRowAtIndexPath(indexPath: IndexPath) -> CGFloat {
    let section = indexPath.section

    guard section < sections.count else {
      return CGFloat(0)
    }

    let secionType = sections[section]

    switch secionType {
    case .cover:
      return Config.heightOfCover
    case .teachers:
      return Config.heightOfCollection
    }
  }
}

// MARK: - Define
extension TeacherViewModel {
  struct Config {
    static let numberOfRows = 1
    static let heightOfCover: CGFloat = 150 * ratio
    static let heightOfCollection: CGFloat = (667 - 150) * ratio
  }
}
