//
//  CoursesViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

final class CoursesViewModel: ViewModel {

  // MARK: - enum
  enum SectionType {
    case cover
    case course
  }

  enum LoadCourseCompletion {
    case success
    case failure(Error)
  }

  // MARK: - Properties
  var sections: [SectionType] = [.cover, .course]
  var courses: [Course] = []
  
  func loadCourses(completion: @escaping (LoadCourseCompletion) -> Void) {
    Api.Course.loadCourses { [weak self] (result) in
      guard let this = self else { return }
      switch result {
      case .success(let courses):
        this.courses = courses
        completion(.success)
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}

// MARK: - Table view
extension CoursesViewModel {
  func numberOfSections() -> Int {
    return sections.count
  }

  func numberOfItems(inSection section: Int) throws -> Int {
    guard section < sections.count else {
      throw App.Error.indexOutOfBound
    }

    let sectionType = sections[section]

    switch sectionType {
    case .course:
      return courses.count
    case .cover:
      return Config.numberOfSlide
    }
  }

  func viewModelForItem(at indexPath: IndexPath) throws -> CourseCellViewModel {
    let section = indexPath.section

    guard section < sections.count else {
      throw App.Error.indexOutOfBound
    }

    let course = courses[indexPath.row]
    return CourseCellViewModel(course: course)
  }

  func didSelectRowAtIndexPath(indexPath: IndexPath) -> CourseViewModel {
    let course = courses[indexPath.row]
    return CourseViewModel(course: course)
  }
}

// MARK: - Define
extension CoursesViewModel {
  struct Config {
    static let numberOfSlide = 1
  }
}
