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
  @IBOutlet var starButtons: [UIButton]!

  var viewModel: CourseCommentViewModel? {
    didSet {
      setupData()
    }
  }

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

  private func setupData() {
    guard let viewModel = viewModel else { return }
    viewModel.loadTeachers { [weak self] (result) in
      guard let this = self else { return }
      switch result {
      case .success:
        this.tableView.reloadData()
      case .failure(let error):
        this.alert(error: error)
      }
    }
  }

  // MARK: - Actions
  @IBAction func cancelButtonTouchUpInside(_ sender: Any) {
    commentRatingTextView.text = ""
  }

  @IBAction func starButtonTouchUpInside(_ sender: UIButton) {
    for tag in 0...sender.tag {
      starButtons[tag].setImage(#imageLiteral(resourceName: "ic_star"), for: .normal)
    }

    if sender.tag < starButtons.count - 1 {
      for tag in (sender.tag + 1)...(starButtons.count - 1) {
        starButtons[tag].setImage(#imageLiteral(resourceName: "ic_star_blank"), for: .normal)
      }
    }

    guard let viewModel = viewModel else { return }
    viewModel.newComment.ratingPoint = sender.tag + 1
  }

  @IBAction func sendButtonTouchUpInside(_ sender: Any) {
    guard let viewModel = viewModel else { return }
    viewModel.newComment.content = commentRatingTextView.text
    viewModel.addNewComment()
    commentTextView.resignFirstResponder()
    commentRatingTextView.resignFirstResponder()
    commentRatingTextView.text = "Comment..."
    for tag in 0...starButtons.count - 1 {
      starButtons[tag].setImage(#imageLiteral(resourceName: "ic_star_blank"), for: .normal)
    }
    hiddenRatingView()
  }
}

// MARK: - UITableViewDataSource
extension CourseCommentViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let viewModel = viewModel else { return 0 }
    return viewModel.numberOfItems(inSection: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let viewModel = viewModel else { return UITableViewCell() }
    if let vm = try? viewModel.viewModelForItem(at: indexPath) {
      let cell = tableView.dequeue(CourseCommentCell.self)
      cell.viewModel = vm
      cell.selectionStyle = .none
      return cell
    }
    return TableCell()
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    commentRatingTextView.resignFirstResponder()
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
