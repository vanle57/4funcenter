//
//  TeacherViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/17/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class TeacherViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
    }

    override func setupUI() {
        super.setupUI()
        title = Define.title
    }

    // MARK: - Private functions
    private func configNavigationBar() {
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_search"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = searchButton
    }
}

extension TeacherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return TableCell()
    }
}

// MARK: - Define, Config
extension TeacherViewController {
    struct Define {
        static let title = "Teachers"
    }

    struct Config {
        static let estimateRowHeight: CGFloat = 500
    }
}
