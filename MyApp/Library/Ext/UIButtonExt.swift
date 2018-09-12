//
//  UIButtonExt.swift
//  MyApp
//
//  Created by MBA0002 on 9/11/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }

        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: text.count))

        self.setAttributedTitle(attributedString, for: .normal)
    }
}
