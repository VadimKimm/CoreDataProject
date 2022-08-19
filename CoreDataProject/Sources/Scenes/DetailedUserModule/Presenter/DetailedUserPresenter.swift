//
//  DetailedUserPresenter.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 15.08.2022.
//

import Foundation

// MARK: - DetailedUserPresenterType

protocol DetailedUserPresenterType: AnyObject {
    var user: User? { get set }

    init(view: DetailedUserViewType, storage: StorageType, router: UsersRouterProtocol, user: User?)
    func getUser()
    func updateUser(_ user: User, newName: String?, birthDate: String?, gender: String?, avatar: Data?)
    func backButtonTapped()
}

// MARK: - DetailedUserPresenter

class DetailedUserPresenter: DetailedUserPresenterType {

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
