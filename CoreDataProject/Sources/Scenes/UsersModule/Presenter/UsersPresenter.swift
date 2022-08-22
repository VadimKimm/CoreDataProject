//
//  UsersPresenter.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 14.08.2022.
//

import Foundation

// MARK: - UsersPresenterType

protocol UsersPresenterType: AnyObject {
    var users: [User]? { get }

    init(view: UsersViewType, storage: StorageType, router: UsersRouterProtocol)
    func saveUser(_ name: String)
    func getAllUsers()
    func deleteUser(_ user: User)
    func userDidSelect(user: User?)
}

// MARK: - UsersPresenter

class UsersPresenter: UsersPresenterType {

    // MARK: - Properties

    weak var view: UsersViewType?
    private let storage: StorageType
    private let router: UsersRouterProtocol?
    var users: [User]?

    // MARK: - Initialize
    
    required init(view: UsersViewType, storage: StorageType, router: UsersRouterProtocol) {
        self.view = view
        self.storage = storage
        self.router = router
    }

    // MARK: - Functions

    func getAllUsers() {
        users = storage.allUsers
        view?.updateTableView()
    }

    func saveUser(_ name: String) {
        storage.saveUser(name)
        getAllUsers()
    }

    func deleteUser(_ user: User) {
        storage.deleteUser(user)
        getAllUsers()
    }

    func userDidSelect(user: User?) {
        router?.showDetailedViewController(user: user)
    }
}
