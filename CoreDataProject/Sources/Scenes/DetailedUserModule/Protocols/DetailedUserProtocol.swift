//
//  DetailedUserProtocol.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 15.08.2022.
//

import Foundation

// MARK: - DetailedUserViewProtocol

protocol DetailedUserViewProtocol: AnyObject {
    func setValuesForTextFields()
}

// MARK: - DetailedUserPresenterProtocol

protocol DetailedUserPresenterProtocol: AnyObject {
    var userToEdit: User? { get set }

    init(view: DetailedUserViewProtocol, coreDataService: CoreDataProtocol, router: UsersRouterProtocol, user: User?)
    func getUser()
    func updateUser(_ user: User, newName: String?, birthDate: String?, gender: String?, avatar: Data?)
    func backButtonTapped()
}
