//
//  Api.CourseComment.swift
//  MyApp
//
//  Created by Van Le H. on 12/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Alamofire

extension Api.CourseComment {
  struct CommentParams {
    var idParent: Int
    var content: String
    var idCourse: Int
    var rating: Int
    var idUser: Int

    func toJSON() -> [String: Any] {
      return [
        "idParentComment": idParent,
        "contentReply": content,
        "idKhoaHoc": idCourse,
        "starRating": rating,
        "IdUser": idUser
      ]
    }
  }

  @discardableResult
  static func comment(params: CommentParams, completion: @escaping Completion<Bool>) -> Request? {
    let path = Api.Path.User().urlLogin
    return api.request(method: .post, urlString: path, parameters: params.toJSON()) { (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let value):
          guard let json = value as? JSObject else {
            completion(.failure(Api.Error.json))
            return
          }
          if let error = json["MsgError"] as? String, let code = json["Code"] as? Int {
            let error = NSError(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey: error])
            completion(.failure(error))
            return
          }
          completion(.success(true))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
