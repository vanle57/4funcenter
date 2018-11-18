//
//  Api.Slide.swift
//  MyApp
//
//  Created by Van Le H. on 11/18/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Alamofire
import ObjectMapper

extension Api.Slide {

  @discardableResult
  static func loadSlides(completion: @escaping Completion<[Slide]>) -> Request? {
    let path = Api.Path.Slide().urlString
    return api.request(method: .get, urlString: path) { (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let value):
          guard let data = value as? JSArray else {
            completion(.failure(Api.Error.json))
            return
          }
          let slides = Mapper<Slide>().mapArray(JSONArray: data)
          completion(.success(slides))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
