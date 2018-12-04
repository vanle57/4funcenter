//
//  Session.swift
//  MyApp
//
//  Created by MBA0002 on 8/14/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class Session {

  // MARK: - Singleton
  public static var share: Session = {
    let session = Session()
    return session
  }()

  private init() { }

  var accessToken: String? = App.userDefault.string(forKey: App.KeyUserDefault.accessToken) {
    didSet {
      App.userDefault.set(accessToken, forKey: App.KeyUserDefault.accessToken)
    }
  }
}
