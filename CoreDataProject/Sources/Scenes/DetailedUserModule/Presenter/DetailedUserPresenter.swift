//
//  DetailedUserPresenter.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 15.08.2022.
//

import Foundation

class DetailedUserPresenter: DetailedUserPresenterProtocol {

    weak var view: DetailedUserViewProtocol?
    private let coreDataService: CoreDataProtocol
    private let router: UsersRouterProtocol?
    var userToEdit: User?

    required init(view: DetailedUserViewProtocol, coreDataService: CoreDataProtocol, router: UsersRouterProtocol, user: User?) {
        self.view = view
        self.coreDataService = coreDataService
        self.router = router
        self.userToEdit = user
    }

    func getUser() {
        view?.setValuesForTextFields()
    }

    func updateUser(_ user: User, newName: String?, birthDate: String?, gender: String?) {
        coreDataService.updateUser(user, newName: newName, birthDate: birthDate, gender: gender)
    }

    func backButtonTapped() {
        router?.popToRoot()
    }
}
