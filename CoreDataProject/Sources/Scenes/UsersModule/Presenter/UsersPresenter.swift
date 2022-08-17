//
//  UsersPresenter.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 14.08.2022.
//

import Foundation

class UsersPresenter: UsersPresenterProtocol {

    weak var view: UsersViewProtocol?
    private let coreDataService: CoreDataProtocol
    private let router: UsersRouterProtocol?
    var users: [User]?
    
    required init(view: UsersViewProtocol, coreDataService: CoreDataProtocol, router: UsersRouterProtocol) {
        self.view = view
        self.coreDataService = coreDataService
        self.router = router
    }

    func getAllUsers() {
        users = coreDataService.getAllUsers()
        view?.fetchTableView()
    }

    func saveUser(_ name: String) {
        coreDataService.saveUser(name)
        getAllUsers()
    }

    func deleteUser(_ user: User) {
        coreDataService.deleteUser(user)
        getAllUsers()
    }

    func userDidSelect(user: User?) {
        router?.showDetailedViewController(user: user)
    }
}
