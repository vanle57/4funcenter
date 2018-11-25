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

  // MARK: - enum
  enum LoadEntriesCompletion {
    case success
    case failure(Error)
  }

  /// dummy data
  var slides: [Slide] = DummyData.fetchSlide()
  var entries: [Entry] = []

  // call api
  func loadEntries(completion: @escaping (LoadEntriesCompletion) -> Void) {
    Api.Entry.loadEntries { [weak self] (result) in
      guard let this = self else { return }
      switch result {
      case .success(let entries):
        this.entries = entries
        completion(.success)
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}

// MARK: - Table view
extension BlogViewModel {

  func numberOfItems(inSection section: Int) throws -> Int {
    guard section < 1 else {
      throw App.Error.indexOutOfBound
    }

    return entries.count
  }

  func viewModelForItem(at indexPath: IndexPath) throws -> BlogCellViewModel {
    let section = indexPath.section

    guard section < 1 else {
      throw App.Error.indexOutOfBound
    }

    let index = indexPath.row

    guard index < entries.count else {
      throw App.Error.indexOutOfBound
    }

    let entry = entries[index]
    let viewModel = BlogCellViewModel(entry: entry)
    return viewModel
  }
}

// MARK: - Collection view
extension BlogViewModel {
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

// MARK: - Define
extension BlogViewModel {
  struct Config {
    static let numberOfSlide = 1
  }
}
