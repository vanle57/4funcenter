//
//  SideMenuViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/14/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    // MARK: - Private function
    private func configTableView() {
        tableView.register(SideMenuCell.self)
        tableView.register(ProfileCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0..<3:
            let cell = tableView.dequeue(SideMenuCell.self)
            cell.itemLabel.text = "MAIN".capitalizingFirstLetter()
            cell.itemLabel.font = UIFont(name: "Heebo-Bold", size: UIFont.labelFontSize)
            return cell
        case 3..<5:
            let cell = tableView.dequeue(SideMenuCell.self)
            cell.itemLabel.text = "ITEM".capitalizingFirstLetter()
            cell.itemLabel.font = UIFont(name: "Heebo-Regular", size: UIFont.labelFontSize)
            return cell
        default:
            return TableCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = App.Color.yellowColor
    }
}
