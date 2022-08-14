//
//  UsersViewController.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 14.08.2022.
//

import UIKit

class UsersViewController: UIViewController {

    var models = ["test1", "test2", "test3"]

    // MARK: - Properties

    private var usersView: UsersView? {
        guard isViewLoaded else { return nil }
        return view as? UsersView
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = UsersView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private functions

    private func setupView() {
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true

        usersView?.tableView.delegate = self
        usersView?.tableView.dataSource = self
        usersView?.addUserTextField.delegate = self
        usersView?.tableView.keyboardDismissMode = .onDrag
    }
}

// MARK: - UITableViewDataSource

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = model
        return cell
    }
}

// MARK: - UITableViewDelegate

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in

        }

        return UISwipeActionsConfiguration(actions: [action])
    }
}

// MARK: - UITextFieldDelegate

extension UsersViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
