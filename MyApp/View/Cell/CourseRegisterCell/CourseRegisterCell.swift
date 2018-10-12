//
//  CourseRegisterCell.swift
//  MyApp
//
//  Created by MBA0002 on 10/9/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

protocol CourseRegisterCellDelegate: class {
    func courseRegisterCell(_ cell: CourseRegisterCell, needPerform action: CourseRegisterCell.Action)
}
final class CourseRegisterCell: TableCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!

    var viewModel: CourseRegisterCellViewModel? {
        didSet {
            updateView()
        }
    }

    enum Action {
        case shouldShowScheduler(String)
        case shouldReturnValue(String)
    }

    weak var delegate: CourseRegisterCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        configTextField()
        switch viewModel.type {
        case .justDisplay(let content):
            textField.isEnabled = false
            textField.text = content
        case .choose:
            configPickerView()
        case .normal:
            textField.isEnabled = true
        }
    }

    private func configPickerView() {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        textField.inputView = pickerView
    }

    private func configTextField() {
        textField.addBorders(edges: .bottom, color: App.Color.blackColor)
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension CourseRegisterCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.numberOfRowsInComponent() ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.titleForRow(at: row)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let viewModel = viewModel else { return }
        let text = viewModel.titleForRow(at: row)
        textField.text = text
        let scheduler = viewModel.didSelectRow(at: row)
        delegate?.courseRegisterCell(self, needPerform: .shouldShowScheduler(scheduler))
    }
}

// MARK: - UITextFieldDelegate
extension CourseRegisterCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        guard let text = textField.text else { return }
        delegate?.courseRegisterCell(self, needPerform: .shouldReturnValue(text))
    }
}
