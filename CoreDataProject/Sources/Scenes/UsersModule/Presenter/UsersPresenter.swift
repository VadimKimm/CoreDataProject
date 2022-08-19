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

    weak var view: UsersViewProtocol?
    private let coreDataService: CoreDataProtocol
    private let router: UsersRouterProtocol?

    // MARK: - Initialize
    
    required init(view: UsersViewProtocol, coreDataService: CoreDataProtocol, router: UsersRouterProtocol) {
        self.view = view
        self.coreDataService = coreDataService
        self.router = router
    }

    // MARK: - Functions

    func getAllUsers() {
        view?.fetchTableView()
    }

    func saveUser(_ name: String) {
        coreDataService.saveUser(name)
        view?.fetchTableView()
    }

    func deleteUser(_ user: User) {
        coreDataService.deleteUser(user)
        view?.fetchTableView()
    }

    func userDidSelect(user: User?) {
        router?.showDetailedViewController(user: user)
    }
}
