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

    weak var view: DetailedUserViewType?
    private let coreDataService: StorageType
    private let router: UsersRouterProtocol?
    var user: User?

    // MARK: - Initialize

    required init(view: DetailedUserViewType, storage: StorageType, router: UsersRouterProtocol, user: User?) {
        self.view = view
        self.coreDataService = storage
        self.router = router
        self.user = user
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
