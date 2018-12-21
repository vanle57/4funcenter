//
//  Api.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class Api {
  struct Path {
    static let baseURL = "http://178.128.114.26:8080"
  }

  struct User { }

  struct Slide { }

  struct Entry { }

  struct Teacher { }

  struct Course { }

  struct Comment { }

  struct RegisterCourse { }

  struct CourseDetail { }
}

extension Api.Path {

  struct User: ApiPath {
    static var path: String { return baseURL }
    var api = "api"
    var screen = "home"
    var login = "login"
    var register = "create-account"
    var profile = "profile"

    var urlString: String {
      return User.path / screen
    }

    var urlLogin: String {
      return User.path / api / screen / login
    }

    var urlRegister: String {
      return User.path / api / screen / register
    }

    var urlProfile: String {
      return User.path / api / screen / profile
    }
  }

  struct Slide {
    static var path: String { return baseURL }
    var api = "api"
    var screen = "home"
    var action = "get-slide"

    var urlString: String {
      return User.path / api / screen / action
    }
  }

  struct Entry {
    static var path: String { return baseURL }
    var api = "api"
    var screen = "home"
    var action = "get-tin-tuc"

    var urlString: String {
      return User.path / api / screen / action
    }
  }

  struct Teacher {
    static var path: String { return baseURL }
    var api = "api"
    var screen = "home"
    var action = "get-giang-vien"

    var urlString: String {
      return User.path / api / screen / action
    }
  }

  struct Course {
    static var path: String { return baseURL }
    var api = "api"
    var screen = "home"
    var action = "get-khoa-hoc"

    var urlString: String {
      return User.path / api / screen / action
    }
  }

  struct Comment {
    static var path: String { return baseURL }
    var screen = "khoahoc"
    var api = "api"
    var action = "get-list-comment"

    var id: Int

    var urlString: String {
      return User.path / screen / api / action / id
    }

    init(id: Int) {
      self.id = id
    }
  }

  struct RegisterCourse {
    static var path: String { return baseURL }
    var api = "api"
    var category = "course"
    var action = "register-course"

    var urlString: String {
      return User.path / api / category / action
    }
  }

  struct CourseDetail {
    static var path: String { return baseURL }
    var screen = "khoahoc"
    var api = "api"
    var category = "khoa-hoc"

    var beautyId: String

    var urlString: String {
      return User.path / screen / api / category / beautyId
    }

    init(beautyId: String) {
      self.beautyId = beautyId
    }
  }
}

protocol URLStringConvertible {
  var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
  static var path: String { get }
}

extension URL: URLStringConvertible {
  var urlString: String { return absoluteString }
}

extension Int: URLStringConvertible {
  var urlString: String { return String(describing: self) }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
  return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
  var urlString: String { return self }
}

extension CustomStringConvertible where Self: URLStringConvertible {
  var urlString: String { return description }
}
