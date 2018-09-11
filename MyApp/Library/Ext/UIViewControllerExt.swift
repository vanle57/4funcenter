//
//  UIKitEx.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SwiftUtils

extension UIViewController {

    func alert(error: Error) {
        alert(title: "LỖI", msg: error.localizedDescription, buttons: ["Đồng ý"], handler: nil)
    }

    func alert(title: String? = nil, msg: String, buttons: [String], handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        for button in buttons {
            let action = UIAlertAction(title: button, style: .default, handler: { action in
                handler?(action)
            })
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }

    func alertManyActions(title: String? = nil, msg: String, buttons: [String], handler: ([((UIAlertAction) -> Void)?])) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        for (index, handl) in handler.enumerated() {
            let buttonTitle = buttons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { action in
                handl?(action)
            })
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
}
