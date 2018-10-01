//
//  CourseCommentViewController.swift
//  MyApp
//
//  Created by MBA0203 on 9/29/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class CourseCommentViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!

    var viewModel = CourseCommentViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func configTableView() {
        tableView.register(CourseCommentCell.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Config.rowHeight
    }

    @IBAction func cancelButtonTouchUpInside(_ sender: Any) {
    }

    @IBAction func sendButtonTouchUpInside(_ sender: Any) {
    }
}

extension CourseCommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let vm = try? viewModel.viewModelForItem(at: indexPath) {
            let cell = tableView.dequeue(CourseCommentCell.self)
            cell.viewModel = vm
            return cell
        }
        return TableCell()
    }
}

extension CourseCommentViewController {
    struct Config {
        static let rowHeight = 50 * ratio
    }
}
