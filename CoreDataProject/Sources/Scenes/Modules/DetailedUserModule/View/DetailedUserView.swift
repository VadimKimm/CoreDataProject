//
//  DetailedUserView.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 15.08.2022.
//

import UIKit
import SnapKit

class DetailedUserView: UIView {

    // MARK: - Views

    var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .blue
        return imageView
    }()

    var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
        textField.setIcon("person")
        textField.borderStyle = .roundedRect
        textField.isEnabled = false
        return textField
    }()

    var birthDateTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.placeholder = "Enter your birth date"
        textField.setIcon("calendar")
        textField.borderStyle = .roundedRect
        textField.isEnabled = false
        return textField
    }()

    var genderTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Choose your gender"
        textField.textAlignment = .left
        textField.setIcon("person.2.circle")
        textField.borderStyle = .roundedRect
        textField.isEnabled = false
        return textField
    }()

    var genderPickerView: UIPickerView = {
        UIPickerView()
    }()

    // MARK: - Initial

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupHierarchy()
        setupLayout()
        setupView()
    }

    // MARK: - Settings

    private func setupHierarchy() {
        let subviews = [avatarImageView,
                        userNameTextField,
                        birthDateTextField,
                        genderTextField]
        subviews.forEach { addSubview($0) }
    }

    private func setupLayout() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(Metrics.avatarImageViewTopOffset)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.height.width.equalTo(Metrics.avatarImageViewHeight)
            avatarImageView.frame = CGRect(x: 0,
                                           y: 0,
                                           width: Metrics.avatarImageViewHeight,
                                           height: Metrics.avatarImageViewHeight)
            avatarImageView.makeRounded()
        }

        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(Metrics.primaryTopOffset)
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(Metrics.primaryLeftOffset)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right).offset(Metrics.primaryRightOffset)
            make.height.equalTo(Metrics.primaryHeight)
        }

        birthDateTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(Metrics.primaryTopOffset)
            make.left.right.height.equalTo(userNameTextField)
        }

        genderTextField.snp.makeConstraints { make in
            make.top.equalTo(birthDateTextField.snp.bottom).offset(Metrics.primaryTopOffset)
            make.left.right.height.equalTo(birthDateTextField)
        }
    }

    private func setupView() {
        backgroundColor = .systemBackground
    }
}

// MARK: - Metrics

extension DetailedUserView {
    enum Metrics {
        static let avatarImageViewTopOffset = 30
        static let avatarImageViewHeight = 180

        static let primaryTopOffset = 20
        static let primaryLeftOffset = 15
        static let primaryRightOffset = -15
        static let primaryHeight = 60
    }
}

// MARK: - UIImageView

extension UIImageView {
    func makeRounded() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}

// MARK: - UITextField

extension UITextField {
    func setIcon(_ image: String) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        iconView.contentMode = .scaleAspectFit
        iconView.image = UIImage(systemName: image)
        iconView.tintColor = .label
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
