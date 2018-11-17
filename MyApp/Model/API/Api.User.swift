//
//  Api.User.swift
//  MyApp
//
//  Created by Van Le H. on 11/8/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire

extension Api.User {
  struct LoginParams {
    var email: String
    var password: String

    func toJSON() -> [String: String] {
      return [
        "Username": email,
        "Password": password
      ]
    }
  }

  @discardableResult
  static func login(params: LoginParams, completion: @escaping Completion<Bool>) -> Request? {
    let path = Api.Path.User().urlString
    return api.request(method: .post, urlString: path, parameters: params.toJSON()) { (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let value):
//          guard let json = value as? JSObject else {
//            completion(.failure(Api.Error.json))
//            return
//          }
//          #warning("delete fake user login to return")
//          guard let fakeUser = User(JSON: ["userName": "aaaa", "password": "aaaa"]) else {
//            completion(.failure(Api.Error.json))
//            return
//          }
          completion(.success(true))
//          guard let user = Mapper<User>().map(JSONObject: json) else {
//            completion(.failure(Api.Error.json))
//            return
//          }
//          User.saveUserToRealm(user: user, completion: completion)
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
