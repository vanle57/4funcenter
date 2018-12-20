//
//  Api.RegisterCourse.swift
//  MyApp
//
//  Created by Van Le H. on 12/18/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Alamofire

extension Api.RegisterCourse {
  struct RegisterParams {
    var id: Int
    var token: String

    func toJSON() -> [String: Any] {
      return [
        "IDKhoaHoc": id,
        "Token": token
      ]
    }
  }

  @discardableResult
  static func register(params: RegisterParams, completion: @escaping Completion<Bool>) -> Request? {
    let path = Api.Path.RegisterCourse().urlString
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
