//
//  Api.Entry.swift
//  MyApp
//
//  Created by Van Le H. on 11/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Alamofire
import ObjectMapper

extension Api.Entry {

  @discardableResult
  static func loadEntries(completion: @escaping Completion<[Entry]>) -> Request? {
    let path = Api.Path.Entry().urlString
    return api.request(method: .get, urlString: path) { (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let value):
          guard let data = value as? JSObject, let entryData = data["Data"] as? JSArray else {
            completion(.failure(Api.Error.json))
            return
          }
          let entries = Mapper<Entry>().mapArray(JSONArray: entryData)
          completion(.success(entries))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
