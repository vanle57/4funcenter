//
//  Color.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

/**
 This file defines all colors which are used in this application.
 Please navigate by the control as prefix.
 */

import UIKit

extension App {
    struct Color {
        static let blackColor = UIColor.RGB(42, 43, 44)

        static func button(state: UIControlState) -> UIColor {
            switch state {
            case UIControlState.normal: return .white
            default: return .gray
            }
        }
    }
}
