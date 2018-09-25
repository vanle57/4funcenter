//
//  SideMenuViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/14/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class SideMenuViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    var viewModel = SideMenuViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatarImageView.circle()
    }

    // MARK: - Private function
    private func configTableView() {
        tableView.register(SideMenuCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }

    private func logout() {
    }

    // MARK: - Public functions
    func switchToViewController(at index: Int) {
        guard index < viewModel.categories.count else { return }
        let rowType = viewModel.categories[index]
        var vc = UIViewController()
        guard let mainViewController = sideMenuController else { return }
        let navigationController = mainViewController.rootViewController as? UINavigationController
        switch rowType {
        case .blog:
            vc = BlogViewController()
        case .course:
            vc = CoursesViewController()
        case .about:
            vc = AboutViewController()
        case .teacher:
            vc = TeacherViewController()
        }
        mainViewController.hideLeftView()
        navigationController?.pushViewController(vc, animated: true)
    }

    func switchToProfileItemOrLogout(at index: Int) {
        guard index < viewModel.profileItem.count else { return }
        let rowType = viewModel.profileItem[index]
        switch rowType {
        case .me, .myCourses, .results:
            navigationController?.pushViewController(ProfileViewController(), animated: true)
        case .logout:
            logout()
        }
    }

    @IBAction func homeButtonTouchUpInside(_ sender: Any) {
        guard let mainViewController = sideMenuController else { return }
        let navigationController = mainViewController.rootViewController as? UINavigationController
        mainViewController.hideLeftView()
        navigationController?.pushViewController(HomeViewController(), animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let viewModel = try? viewModel.viewModelForItem(at: indexPath) {
            let cell = tableView.dequeue(SideMenuCell.self)
            cell.viewModel = viewModel
            return cell
        }
        return TableCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = App.Color.lightYellowColor
        if let sectionType = try? viewModel.didSelectRow(at: indexPath) {
            switch sectionType {
            case .main:
                switchToViewController(at: indexPath.row)
            case .profileItem:
                switchToProfileItemOrLogout(at: indexPath.row)
            }
        }
    }
}
