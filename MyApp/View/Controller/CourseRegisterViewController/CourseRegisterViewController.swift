//
//  CourseRegisterViewController.swift
//  MyApp
//
//  Created by MBA0002 on 10/9/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class CourseRegisterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel = CourseRegisterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    private func configTableView() {
        tableView.register(CourseRegisterCell.self)
        tableView.rowHeight = 150
    }

    @IBAction func registerButtonTouchUpInside(_ sender: Any) {
    }

    @IBAction func cancelButtonTouchUpInside(_ sender: Any) {
    }

}

extension CourseRegisterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemInSection(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CourseRegisterCell.self)
        cell.viewModel = viewModel.viewModelForItem(at: indexPath)
        return cell
    }
}
