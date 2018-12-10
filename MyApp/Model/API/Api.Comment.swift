//
//  Api.Comment.swift
//  MyApp
//
//  Created by Van Le H. on 12/10/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Alamofire
import ObjectMapper

extension Api.Comment {
  @discardableResult
  static func loadComments(id: Int,completion: @escaping Completion<[Comment]>) -> Request? {
    let path = Api.Path.Comment(id: id).urlString
    return api.request(method: .get, urlString: path) { (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let value):
          guard let data = value as? JSObject, let courseData = data["Data"] as? JSArray else {
            completion(.failure(Api.Error.json))
            return
          }
          let comments = Mapper<Comment>().mapArray(JSONArray: courseData)
          completion(.success(comments))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
