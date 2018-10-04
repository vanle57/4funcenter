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
    @IBOutlet weak var commentRatingTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var ratingView: UIView!
    
    var viewModel = CourseCommentViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configCommentView()
        configRatingView()
        hiddenRatingView()
    }

    // MARK: - Private function
    private func configTableView() {
        tableView.register(CourseCommentCell.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Config.rowHeight
    }

    private func configCommentView() {
        commentView.addBorders(edges: .top, color: App.Color.defaultTableViewSeperatorColor)
        commentTextView.delegate = self
    }

    private func configRatingView() {
        ratingView.addBorders(edges: .top, color: App.Color.defaultTableViewSeperatorColor)
        commentRatingTextView.delegate = self
        hiddenCancelButton()
    }

    private func hiddenRatingView(_ status: Bool = true) {
        ratingView.isHidden = status
    }

    private func hiddenCancelButton(_ status: Bool = true) {
        cancelButton.isHidden = status
    }

    // MARK: - Actions
    @IBAction func cancelButtonTouchUpInside(_ sender: Any) {
        commentRatingTextView.text = ""
    }


    @IBAction func starButtonTouchUpInside(_ sender: Any) {
    }

    @IBAction func sendButtonTouchUpInside(_ sender: Any) {
        guard !commentRatingTextView.text.isEmpty else { return }
        viewModel.newComment.content = commentRatingTextView.text
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
        if textView == commentTextView {
            hiddenRatingView(false)
        } else if textView == commentRatingTextView {
            commentRatingTextView.text = ""
            hiddenCancelButton(false)
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == commentRatingTextView {
            hiddenCancelButton()
        }
    }
}

extension CourseCommentViewController {
    struct Config {
        static let rowHeight = 130 * ratio
    }
}
