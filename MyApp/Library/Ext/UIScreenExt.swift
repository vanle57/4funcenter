//
//  Ratio.swift
//  MyApp
//
//  Created by MBA0002 on 9/18/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.

import UIKit

let ratio = screenSize.width / DeviceType.iPhone6.size.width
let screenSize = UIScreen.main.bounds.size

public enum DeviceType {
    case iPhone4
    case iPhone5
    case iPhone6
    case iPhone6p
    case iPhoneX
    case iPad

    public var size: CGSize {
        switch self {
        case .iPhone4: return CGSize(width: 320, height: 480)
        case .iPhone5: return CGSize(width: 320, height: 568)
        case .iPhone6: return CGSize(width: 375, height: 667)
        case .iPhone6p: return CGSize(width: 414, height: 736)
        case .iPhoneX: return CGSize(width: 375, height: 812)
        case .iPad: return CGSize(width: 768, height: 1_024)
        }
    }

    /// Used to identify the current screen and check to fix
    /// some bugs on different screen layouts.
    /// This function returns results purpose to examine the case
    /// switch instead of having to check the conditions on each case.
    ///
    /// - Returns: Name of the current screen
    static func currentDevice() -> DeviceType {
        switch screenSize {
        case DeviceType.iPhone4.size: return .iPhone4
        case DeviceType.iPhone5.size: return .iPhone5
        case DeviceType.iPhone6.size: return .iPhone6
        case DeviceType.iPhone6p.size: return .iPhone6p
        case DeviceType.iPhoneX.size: return .iPhoneX
        default: return .iPad
        }
    }
}

extension UIScreen {

    public static var widthIphone6: CGFloat {
        return 375
    }
}

public let iPhone = (UIDevice.current.userInterfaceIdiom == .phone)
public let iPad = (UIDevice.current.userInterfaceIdiom == .pad)
public let iPhone4 = (iPhone && DeviceType.iPhone4.size == screenSize)
public let iPhone5 = (iPhone && DeviceType.iPhone5.size == screenSize)
public let iPhone6 = (iPhone && DeviceType.iPhone6.size == screenSize)
public let iPhone6p = (iPhone && DeviceType.iPhone6p.size == screenSize)
public let iPhoneX = (iPhone && DeviceType.iPhoneX.size == screenSize)
