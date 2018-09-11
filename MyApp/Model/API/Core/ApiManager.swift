//
//  ApiManager.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]
typealias Completion<Value> = (Result<Value>) -> Void

let api = ApiManager()

final class ApiManager {

    var defaultHTTPHeaders: [String: String] {
        var headers: [String: String] = [:]
        if let accessToken = Session.share.accessToken {
            headers["Authorization"] = "Bearer " + accessToken
        }
        return headers
    }
}
