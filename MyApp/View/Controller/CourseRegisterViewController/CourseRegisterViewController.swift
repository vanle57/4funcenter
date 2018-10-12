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
        configNavigationBar()
        configTableView()
    }

    private func configTableView() {
        tableView.register(CourseRegisterCell.self)
        tableView.rowHeight = 50
    }

    private func configNavigationBar() {
        let cancelButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_cancel"), style: .plain, target: self, action: #selector(cancelAction))
        navigationItem.leftBarButtonItem = cancelButton
    }

    @objc func cancelAction() {
        navigationController?.popViewController(animated: true)
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
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeaderInSection(in: section)
    }
}

extension CourseRegisterViewController: CourseRegisterCellDelegate {
    func courseRegisterCell(_ cell: CourseRegisterCell, needPerform action: CourseRegisterCell.Action) {
        guard var indexPath = tableView.indexPath(for: cell) else { return }
        switch action {
        case .shouldShowScheduler(let scheduler):
            indexPath.row += 1
            guard let cell = tableView.cellForRow(at: indexPath) as? CourseRegisterCell else { return }
            viewModel.scheduler = scheduler
            cell.viewModel = viewModel.viewModelForClassInforItem(at: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .shouldReturnValue(let value):
            do {
                try viewModel.saveInformationForIndex(index: indexPath.row, value: value)
            } catch let error {
                alert(error: error)
            }
        }
    }
}

extension CourseRegisterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.backgroundView?.backgroundColor = .white
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont(name: "Heebo-Medium", size: 17)
        header.textLabel?.frame = header.frame
    }

}
