//
//  TableCell.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

class TableCell: UITableViewCell, MVVM.View {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configView()
    }

    private func configView() {
        textLabel?.font = App.Font.playfairBoldFont
        textLabel?.textColor = App.Color.blackColor
        backgroundColor = .clear
    }
}
