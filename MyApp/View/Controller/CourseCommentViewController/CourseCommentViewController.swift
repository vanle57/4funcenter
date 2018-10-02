//
//  CourseCommentViewController.swift
//  MyApp
//
//  Created by MBA0203 on 9/29/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class CourseCommentViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var commentView: UIView!

    var viewModel = CourseCommentViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configCommentView()
    }

    // MARK: - Private function
    private func configTableView() {
        tableView.register(CourseCommentCell.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Config.rowHeight
    }

    private func configCommentView() {
        commentView.addBorders(edges: [.top], color: App.Color.defaultTableViewSeperatorColor)
        commentTextView.delegate = self
        cancelButton.isHidden = true
    }

    // MARK: - Actions
    @IBAction func cancelButtonTouchUpInside(_ sender: Any) {
        commentTextView.text = ""
    }

    @IBAction func sendButtonTouchUpInside(_ sender: Any) {
        guard !commentTextView.text.isEmpty else { return }
        viewModel.newComment.content = commentTextView.text
    }
}

// MARK: - UITableViewDataSource
extension CourseCommentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let vm = try? viewModel.viewModelForItem(at: indexPath) {
            let cell = tableView.dequeue(CourseCommentCell.self)
            cell.viewModel = vm
            cell.selectionStyle = .none
            return cell
        }
        return TableCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        commentTextView.resignFirstResponder()
    }
}

// MARK: - UITextViewDelegate
extension CourseCommentViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        commentTextView.text = ""
        cancelButton.isHidden = false
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        cancelButton.isHidden = true
    }
}

extension CourseCommentViewController {
    struct Config {
        static let rowHeight = 130 * ratio
    }
}
