//
//  CourseCommentViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 10/1/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import MVVM

final class CourseCommentViewModel: ViewModel {

  // MARK: - enum
  enum LoadCommentCompletion {
    case success
    case failure(Error)
  }

  // MARK: - Properties
  var idCourse = 0
  var comments: [Comment] = []
  var newComment: Comment = Comment()

  init() { }

  init(idCourse: Int) {
    self.idCourse = idCourse
  }

  func addNewComment(_ completion: @escaping (LoadCommentCompletion) -> Void) {
    let params = Api.CourseComment.CommentParams(idParent: 0,
                                                 content: newComment.content,
                                                 idCourse: idCourse,
                                                 rating: newComment.ratingPoint,
                                                 idUser: Session.share.idUser ?? 0)
    Api.CourseComment.comment(params: params) { (result) in
      switch result {
      case .success:
        completion(.success)
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func loadTeachers(completion: @escaping (LoadCommentCompletion) -> Void) {
    Api.Comment.loadComments(id: idCourse) { [weak self] (result) in
      guard let this = self else { return }
      switch result {
      case .success(let comments):
        this.comments = comments
        completion(.success)
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
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
