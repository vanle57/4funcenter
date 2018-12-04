//
//  Api.User.swift
//  MyApp
//
//  Created by Van Le H. on 11/8/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

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

  struct RegisterParams {
    var username: String
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var confirmPassword: String
    var agree: Bool

    func toJSON() -> [String: Any] {
      return [
        "Username": username,
        "Ho": firstName,
        "Ten": lastName,
        "Email": email,
        "Password": password,
        "ConfirmPassword": confirmPassword,
        "Agree": agree
      ]
    }
  }

  @discardableResult
  static func login(params: LoginParams, completion: @escaping Completion<User>) -> Request? {
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
          guard let data = json["Data"] as? JSObject,
            let accessToken = data["Token"] as? String else {
            completion(.failure(Api.Error.json))
            return
          }
          Session.share.accessToken = accessToken
          guard let userData = data["User"] as? JSObject,
            let user = Mapper<User>().map(JSONObject: userData) else {
            completion(.failure(Api.Error.json))
            return
          }
          User.saveUserToRealm(user: user, completion: completion)
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }

  @discardableResult
  static func register(params: RegisterParams, completion: @escaping Completion<Bool>) -> Request? {
    let path = Api.Path.User().urlRegister
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
