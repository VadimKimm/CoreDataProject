//
//  DetailedUserViewController.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 15.08.2022.
//

import UIKit

// MARK: - DetailedUserViewType

protocol DetailedUserViewType: AnyObject {
    func setValuesForTextFields()
}

// MARK: - DetailedUserViewController

class DetailedUserViewController: UIViewController, UINavigationControllerDelegate {

    // MARK: - Properties

    var presenter: DetailedUserPresenterType!
    private var selectedAvatar: Data? = nil
    private let genders = ["Choose gender", "Male", "Female"]
    private var isEditingMode = false
    private var editOptionButton = UIBarButtonItem()
    private var backOptionButton = UIBarButtonItem()
    private let datePicker = UIDatePicker()
    private let imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = false
        return picker
    }()

    private var detailedUserView: DetailedUserView? {
        guard isViewLoaded else { return nil }
        return view as? DetailedUserView
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = DetailedUserView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.getUser()
    }

    // MARK: - Private functions

    private func setupView() {
        detailedUserView?.userNameTextField.delegate = self
        detailedUserView?.genderTextField.delegate = self
        detailedUserView?.genderPickerView.delegate = self
        detailedUserView?.genderPickerView.dataSource = self
        imagePicker.delegate = self
        detailedUserView?.avatarButton.addTarget(self, action: #selector(avatarButtonTapped), for: .touchUpInside)

        setupNavigationBar()
        setupDatePicker()
        setupGenderPicker()
    }

    private func setupNavigationBar() {
        backOptionButton = UIBarButtonItem(title: "",
                                               style: .plain,
                                               target: self,
                                               action: #selector(backButtonTapped))
        backOptionButton.setBackgroundImage(UIImage(systemName: "arrow.left"), for: .normal, barMetrics: .default)
        backOptionButton.tintColor = .label

        editOptionButton = UIBarButtonItem(title: "Edit",
                                               style: .plain,
                                               target: self,
                                               action: #selector(editButtonTapped))
        editOptionButton.tintColor = .label

        navigationItem.leftBarButtonItem = backOptionButton
        navigationItem.rightBarButtonItem = editOptionButton
    }

    private func setupDatePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        toolBar.setItems([doneButton], animated: true)
        detailedUserView?.birthDateTextField.inputAccessoryView = toolBar
        detailedUserView?.birthDateTextField.inputView = datePicker

        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self,
                             action: #selector(chooseDate(datePicker:)),
                             for: UIControl.Event.valueChanged)
    }

    private func setupGenderPicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        toolBar.setItems([doneButton], animated: true)
        detailedUserView?.genderTextField.inputAccessoryView = toolBar
        detailedUserView?.genderTextField.inputView = detailedUserView?.genderPickerView
    }

    @objc private func avatarButtonTapped() {
        present(imagePicker, animated: true, completion: nil)
    }

    @objc private func doneButtonPressed() {
        self.view.endEditing(true)
    }

    @objc private func chooseDate(datePicker: UIDatePicker) {
        detailedUserView?.birthDateTextField.text = datePicker.date.convertToString()
    }

    @objc private func backButtonTapped() {
        presenter.backButtonTapped()
    }

    @objc private func editButtonTapped() {
        let userNameTextField = detailedUserView?.userNameTextField
        let birthDateTextField = detailedUserView?.birthDateTextField
        let genderTextField = detailedUserView?.genderTextField
        let avatar = detailedUserView?.avatarButton

        func toggleMode() {
            isEditingMode.toggle()
            editOptionButton.title = isEditingMode ? "Save" : "Edit"
            backOptionButton.isEnabled.toggle()
            detailedUserView?.backgroundColor = isEditingMode ? .systemGray5 : .systemBackground
            userNameTextField?.isEnabled.toggle()
            birthDateTextField?.isEnabled.toggle()
            genderTextField?.isEnabled.toggle()
            avatar?.isEnabled.toggle()

        }

        toggleMode()

        if !isEditingMode {
            guard let userName = userNameTextField?.text,
                  !userName.trimmingCharacters(in: .whitespaces).isEmpty else {
                showAlert(title: "Error", message: "Enter name")
                toggleMode()
                return
            }

            presenter.updateUser(presenter.user!,
                                 newName: userNameTextField?.text,
                                 birthDate: birthDateTextField?.text,
                                 gender: genderTextField?.text,
                                 avatar: selectedAvatar)
        }
    }

}

// MARK: - DetailedUserViewProtocol

extension DetailedUserViewController: DetailedUserViewType {
    func setValuesForTextFields() {
        detailedUserView?.userNameTextField.text = presenter.user?.name
        detailedUserView?.birthDateTextField.text = presenter.user?.birthDate?.convertToString()
        detailedUserView?.genderTextField.text = presenter.user?.gender

        DispatchQueue.main.async {
            if let avatar = self.presenter.user?.avatar {
                self.detailedUserView?.setAvatar(avatar)
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension DetailedUserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UIPickerViewDataSource

extension DetailedUserViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genders.count
    }
}

// MARK: - UIPickerViewDelegate

extension DetailedUserViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genders[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row != 0 else { return }
        detailedUserView?.genderTextField.text = genders[row]
    }
}

// MARK: - UIImagePickerControllerDelegate

extension DetailedUserViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            showAlert(title: "Error", message: "\(info)")
            return
        }

        DispatchQueue.main.async {
            let scaledImage = image.scaleTo(targetSize: CGSize(width: 100, height: 100))
            self.selectedAvatar = scaledImage.pngData()

            if let avatar = self.selectedAvatar {
                self.detailedUserView?.setAvatar(avatar)
            }
        }
    }
}
