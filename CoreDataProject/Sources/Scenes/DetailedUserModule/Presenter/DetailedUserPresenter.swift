//
//  DetailedUserPresenter.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 15.08.2022.
//

import Foundation

class DetailedUserPresenter: DetailedUserPresenterProtocol {

    // MARK: - Properties

    weak var view: DetailedUserViewProtocol?
    private let coreDataService: CoreDataProtocol
    private let router: UsersRouterProtocol?
    var userToEdit: User?

    // MARK: - Initialize

    required init(view: DetailedUserViewProtocol, coreDataService: CoreDataProtocol, router: UsersRouterProtocol, user: User?) {
        self.view = view
        self.coreDataService = coreDataService
        self.router = router
        self.userToEdit = user
    }

    // MARK: - Functions

    func getUser() {
        view?.setValuesForTextFields()
    }

    func updateUser(_ user: User, newName: String?, birthDate: String?, gender: String?, avatar: Data?) {
        coreDataService.updateUser(user, newName: newName, birthDate: birthDate, gender: gender, avatar: avatar)
    }

    func backButtonTapped() {
        router?.popToRoot()
    }
}
