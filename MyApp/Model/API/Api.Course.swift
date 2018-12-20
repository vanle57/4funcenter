//
//  Api.Course.swift
//  MyApp
//
//  Created by Van Le H. on 12/4/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper
import Alamofire

extension Api.Course {

  @discardableResult
  static func loadCourses(completion: @escaping Completion<[Course]>) -> Request? {
    let path = Api.Path.Course().urlString
    return api.request(method: .get, urlString: path) { (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let value):
          guard let data = value as? JSObject, let courseData = data["DanhSachKhoaHoc"] as? JSArray else {
            completion(.failure(Api.Error.json))
            return
          }
          let courses = Mapper<Course>().mapArray(JSONArray: courseData)
          completion(.success(courses))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
