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

  // MARK: - enum
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

  enum LoadDataCompletion {
    case success
    case failure(Error)
  }

  var sections: [SectionType] = [.blog, .course, .teacher]

  /// dummy data
  var slides: [Slide] = []
  var teachers: [Teacher] = []

  func getSectionType(index: Int) throws -> SectionType {

    guard index < sections.count else {
      throw App.Error.indexOutOfBound
    }

    return sections[index]
  }

  // call api
  func loadSlides(completion: @escaping (LoadDataCompletion) -> Void) {
    Api.Slide.loadSlides { [weak self] (result) in
      guard let this = self else { return }
      switch result {
      case .success(let slides):
        this.slides = slides
        completion(.success)
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func loadTeachers(completion: @escaping (LoadDataCompletion) -> Void) {
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

// MARK: - Collection view
extension HomeViewModel {
  func numberOfSlides() -> Int {
    return slides.count
  }

  func viewModelForSlideCell(indexPath: IndexPath) throws -> SlideCellViewModel {
    let index = indexPath.row

    guard index < slides.count else {
      throw App.Error.indexOutOfBound
    }

    let slide = slides[index]
    return SlideCellViewModel(slide: slide)
  }
}

// MARK: - Table view
extension HomeViewModel {
  func numberOfSections() -> Int {
    return sections.count
  }

  func numberOfItems(inSection section: Int) -> Int {
    return Config.numberOfRow
  }

  func viewModelForItem(at indexPath: IndexPath) throws -> HomeCellViewModel {
    let section = indexPath.section

    guard section < sections.count else {
      throw App.Error.indexOutOfBound
    }

    let vm = HomeCellViewModel()
    vm.teachers = teachers
    return vm
  }

  func viewModelForHeader(inSection section: Int) throws -> HeaderViewModel {
    guard section < sections.count else {
      throw App.Error.indexOutOfBound
    }

    let sectionType = sections[section]
    return HeaderViewModel(id: section, title: sectionType.title)
  }
}

// MARK: - Define
extension HomeViewModel {
  struct Config {
    static let numberOfRow = 1
  }
}
