//
//  RegisterViewController.swift
//  MyApp
//
//  Created by MBA0002 on 9/13/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

final class RegisterViewController: BaseViewController {

  // MARK: - Outlets
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var usernameTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var firstNameTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var confirmPasswordTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var checkButton: UIButton!

  var viewModel = RegisterViewModel()

  override func setupUI() {
    super.setupUI()
    navigationController?.isNavigationBarHidden = true
    usernameTextField.delegate = self
    firstNameTextField.delegate = self
    lastNameTextField.delegate = self
    emailTextField.delegate = self
    passwordTextField.delegate = self
    confirmPasswordTextField.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    navigationController?.isNavigationBarHidden = true
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    usernameTextField.resignFirstResponder()
    firstNameTextField.resignFirstResponder()
    lastNameTextField.resignFirstResponder()
    emailTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
    confirmPasswordTextField.resignFirstResponder()
  }

  // MARK: - Private functions
  private func register() {
    guard let username = usernameTextField.text,
      let firstName = firstNameTextField.text,
      let lastName = lastNameTextField.text,
      let email = emailTextField.text,
      let password = passwordTextField.text,
      let confirmPassword = confirmPasswordTextField.text else {
        alert(error: App.Error.emptyField)
        return
    }
    viewModel = RegisterViewModel(avatar: viewModel.avatar,
                                  username: username,
                                  firstName: firstName,
                                  lastName: lastName,
                                  email: email,
                                  password: password,
                                  confirmPassword: confirmPassword,
                                  isChecked: viewModel.isChecked)
    viewModel.register { [weak self] (result) in
      guard let this = self else { return }
      switch result {
      case .success:
        this.navigationController?.pushViewController(RegisterSuccessViewController(), animated: true)
      case .failure(let error):
        guard let error = error as? RegisterViewModel.RegisterError else {
          this.alert(error: App.Error.unknown)
          return
        }
        this.alert(title: "ERROR",
          msg: error.localizedDescription, buttons: [App.String.ok],
          handler: nil)
      }
    }
  }

  private func updateCheckButtonUI() {
    if viewModel.isChecked {
      checkButton.setImage(#imageLiteral(resourceName: "ic_check"), for: .normal)
    } else {
      checkButton.setImage(#imageLiteral(resourceName: "ic_uncheck"), for: .normal)
    }
  }

  // MARK: - Actions
  @IBAction func cameraButtonTouchUpInside(_ sender: Any) {
    showPickAvatarAlert()
  }

  @IBAction func checkButtonTouchUpInside(_ sender: Any) {
    viewModel.isChecked = !viewModel.isChecked
    updateCheckButtonUI()
  }

  @IBAction func registerButtonTouchUpInside(_ sender: Any) {
    register()
  }

  @IBAction func loginButtonTouchUpInside(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
}

// MARK: - UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == usernameTextField {
      firstNameTextField.becomeFirstResponder()
      return true
    }
    if textField == firstNameTextField {
      lastNameTextField.becomeFirstResponder()
      return true
    }
    if textField == lastNameTextField {
      emailTextField.becomeFirstResponder()
      return true
    }
    if textField == emailTextField {
      passwordTextField.becomeFirstResponder()
      return true
    }
    if textField == passwordTextField {
      confirmPasswordTextField.becomeFirstResponder()
      return true
    }
    if textField == confirmPasswordTextField {
      updateCheckButtonUI()
      register()
      return true
    }
    return true
  }
}

// MARK: - Pick picture
extension RegisterViewController {
  private func showPickAvatarAlert() {
    let libraryAction: (UIAlertAction) -> Void = { (action) in
      self.pickPictureFromLibrary()
    }
    let cameraAction: (UIAlertAction) -> Void = { (action) in
      self.pickPictureFromCamera()
    }
    alertManyActions(title: Define.pickPictureAlert, msg: "", buttons: [Define.libraryAction, Define.cameraAction, Define.cancelAction], handler: [libraryAction, cameraAction, nil])
  }

  private func pickPictureFromLibrary() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.sourceType = .photoLibrary
    navigationController?.present(imagePickerController, animated: true, completion: nil)
  }

  private func pickPictureFromCamera() {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      let imagePickerController = UIImagePickerController()
      imagePickerController.delegate = self
      imagePickerController.sourceType = .camera
      imagePickerController.cameraCaptureMode = .photo
      imagePickerController.modalPresentationStyle = .fullScreen
      present(imagePickerController, animated: true, completion: nil)
    } else {
      alert(msg: Define.noCameraAlert, buttons: [Define.agreeAction], handler: nil)
    }
  }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
    var newImage: UIImage
    if let possibleImage = info[Define.editedImage] as? UIImage {
      newImage = possibleImage
    } else if let possibleImage = info[Define.originalImage] as? UIImage {
      newImage = possibleImage
    } else {
      return
    }
    dismiss(animated: true)
    viewModel.avatar = newImage
    avatarImageView.contentMode = .scaleToFill
    avatarImageView.image = newImage
  }
}

// MARK: - Define
extension RegisterViewController {
  struct Define {
    static let pickPictureAlert = "Choose picture from"
    static let libraryAction = "Library"
    static let cameraAction = "Camera"
    static let cancelAction = "Cancel"
    static let agreeAction = "Ok"
    static let editedImage = "UIImagePickerControllerEditedImage"
    static let originalImage = "UIImagePickerControllerOriginalImage"
    static let noCameraAlert = "Sorry, this device not have camera"
  }
}
