//
//  UIImageViewExt.swift
//  MyApp
//
//  Created by Van Le H. on 11/18/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Kingfisher

extension UIImageView {

  func setImage(path: String, placerholder: UIImage = UIImage()) {
    let url = URL(string: path)
    kf.indicatorType = .activity
    if path.isEmpty {
      self.image = placerholder
    } else {
      kf.setImage(with: url)
    }
  }
}
