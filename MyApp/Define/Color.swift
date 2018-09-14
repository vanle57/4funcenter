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
        static let navigationGradientColors = [UIColor.RGB(138, 181, 243), UIColor.RGB(110, 126, 227), UIColor.RGB(104, 86, 226), UIColor.RGB(126, 64, 224), UIColor.RGB(161, 42, 218)]

        static let navigationTittleColor = UIColor.black
        static let navigationBarTintColor = UIColor.red
        static let tabBarTintColor = UIColor.RGB(103, 26, 151)
        static let tabBarBarTintColor = UIColor.white
        static let tabBarBackgroudColor = UIColor.gray

        static let buttonGradientColors = [UIColor.RGB(235, 203, 234), UIColor.RGB(221, 169, 226), UIColor.RGB(205, 136, 216), UIColor.RGB(182, 106, 205), UIColor.RGB(161, 83, 198)]

        static let progressTintColor = UIColor.RGB(145, 68, 197)

        static let grayCell = UIColor.RGB(238, 236, 244)
        static let redCell = UIColor.RGB(211, 0, 35)
        static let greenCell = UIColor.RGB(82, 216, 92)

        static let primaryPurple = UIColor.RGB(95, 26, 143)
        static let darkPurple = UIColor.RGB(49, 0, 96)
        static let lightPurple = UIColor.RGB(118, 55, 161)
        static let grayBackground = UIColor.RGB(249, 250, 255)

        static let questionColor = UIColor.RGB(56, 0, 107)
        static func button(state: UIControlState) -> UIColor {
            switch state {
            case UIControlState.normal: return .white
            default: return .gray
            }
        }
    }
}
