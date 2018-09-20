//
//  HomeViewModel.swift
//  MyApp
//
//  Created by PCI0007 on 9/20/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

enum TypeOfSecction {
    case teacher
    case blog
    case course
}

final class HomeViewModel {
    let images: [UIImage] = [#imageLiteral(resourceName: "image3"), #imageLiteral(resourceName: "image4"), #imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image7"), #imageLiteral(resourceName: "image8")]
    let teacher1 = Teacher(name: "Hoa", image: #imageLiteral(resourceName: "image7"))
    let teacher2 = Teacher(name: "Lan", image: #imageLiteral(resourceName: "image2"))
    let teacher3 = Teacher(name: "Mai", image: #imageLiteral(resourceName: "ic_high_beginner"))
    var teachers: [Teacher] {
        return [teacher1, teacher2, teacher3, teacher3, teacher3]
    }

    func viewModelForCollectionViewCell(indexPath: IndexPath) -> UIImage {
        return images[indexPath.row]
    }

    // - Returns: 3: Blog, Course, Teacher
    func numberOfSection() -> Int {
        return 3
    }

    // 1 table view cell for 1 section
    func numberItemOfSection(in section: Int) -> Int {
        return 1
    }

    func viewModelForTableViewCell(indexPath: IndexPath) -> HomeTableCellModel {
        let cellModel = HomeTableCellModel()
        cellModel.teachers = self.teachers
        return cellModel
    }

}
