//
//  SlideCollectionCellViewModel.swift
//  MyApp
//
//  Created by MBA0002 on 9/25/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class SlideCellViewModel {

  // MARK: - Properties
  let title: String
  let imageUrl: String
  let image: UIImage

  // MARK: - init
  init(slide: Slide) {
    title = slide.title
    imageUrl = slide.imageUrl
    image = slide.image
  }
}
