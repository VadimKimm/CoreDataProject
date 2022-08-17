//
//  UsersView.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 14.08.2022.
//

import UIKit
import SnapKit

class UsersView: UIView {

    // MARK: - Views

    var addUserTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Print your name here"
        textField.textAlignment = .center
        textField.layer.cornerRadius = Metrics.cornerRadius
        textField.clearsOnBeginEditing = true
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = .systemGray5
        return textField
    }()

    var addUserButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .large
        configuration.cornerStyle = .medium
        configuration.title = "Press"
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
            return outgoing
        }
        button.configuration = configuration
        return button
    }()

    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
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
           let subviews = [addUserTextField,
                           addUserButton,
                           tableView]
           subviews.forEach { addSubview($0) }
       }

       private func setupLayout() {
           addUserTextField.snp.makeConstraints { make in
               make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
               make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(Metrics.addUserTextFieldLeftOffset)
               make.right.equalTo(self.safeAreaLayoutGuide.snp.right).offset(Metrics.addUserTextFieldRightOffset)
               make.height.equalTo(Metrics.addUserTextFieldHeight)
           }

           addUserButton.snp.makeConstraints { make in
               make.top.equalTo(addUserTextField.snp.bottom).offset(Metrics.addUserButtonTopOffset)
               make.left.right.equalTo(addUserTextField)
           }

           tableView.snp.makeConstraints { make in
               make.top.equalTo(addUserButton.snp.bottom).offset(Metrics.tableViewTopOffset)
               make.left.right.bottom.equalTo(self)
           }
       }

       private func setupView() {
           backgroundColor = .systemBackground
       }
}

// MARK: - Metrics

extension UsersView {
    enum Metrics {
        static let addUserTextFieldLeftOffset = 15
        static let addUserTextFieldRightOffset = -addUserTextFieldLeftOffset
        static let addUserTextFieldHeight = 45
        static let addUserButtonHeight = addUserTextFieldHeight

        static let addUserButtonTopOffset = 20

        static let tableViewTopOffset = 20

        static let cornerRadius: CGFloat = 10
    }
}
