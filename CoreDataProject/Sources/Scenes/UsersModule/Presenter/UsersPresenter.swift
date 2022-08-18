//
//  UsersPresenter.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 14.08.2022.
//

import Foundation

class UsersPresenter: UsersPresenterProtocol {

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
