//
//  Api.Detail.swift
//  MyApp
//
//  Created by Van Le H. on 12/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Alamofire
import ObjectMapper

extension Api.CourseDetail {
  @discardableResult
  static func loadDetail(beautyId: String, completion: @escaping Completion<Course>) -> Request? {
    let path = Api.Path.CourseDetail(beautyId: beautyId).urlString
    return api.request(method: .get, urlString: path) { (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let value):
          guard let data = value as? JSObject,
            let courseData = data["Data"] as? JSObject,
            let course = Mapper<Course>().map(JSONObject: courseData)else {
            completion(.failure(Api.Error.json))
            return
          }
          completion(.success(course))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
