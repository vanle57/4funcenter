//
//  TableViewCell.swift
//  MyApp
//
//  Created by PCI0007 on 9/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

protocol ProfileCellDelegate: class {
  func profileCell(_ profileCell: ProfileCell, neddPerform action: ProfileCell.Action)
}

final class ProfileCell: TableCell {

  // MARK: - Enum
  enum Action {
    case shouldBecomeFirstResponder
  }

  // MARK: - Outlet
  @IBOutlet weak var textField: SkyFloatingLabelTextField!

  // MARK: - property
  var viewModel: ProfileCellViewModel? {
    didSet {
      guard let viewModel = viewModel else { return }
      textField.title = viewModel.title
      textField.placeholder = viewModel.title
      textField.text = viewModel.text
    }
  }

  // MARK: - Protocol
  weak var delegate: ProfileCellDelegate?

  override func awakeFromNib() {
    super.awakeFromNib()
    textField.delegate = self
  }

  // MARK: - Override function
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    textField.resignFirstResponder()
  }
}

// MARK: - Extension
extension ProfileCell: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.becomeFirstResponder()
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    textField.resignFirstResponder()
  }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    delegate?.profileCell(self, neddPerform: .shouldBecomeFirstResponder)
    return true
  }
}
