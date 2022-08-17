//
//  UsersProtocols.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 14.08.2022.
//

import Foundation

// MARK: - UsersViewProtocol

protocol UsersViewProtocol: AnyObject {
    func fetchTableView()
    func addUserButtonTapped()
}

// MARK: - UsersPresenterProtocol

protocol UsersPresenterProtocol: AnyObject {
    var users: [User]? { get set  }

    init(view: UsersViewProtocol, coreDataService: CoreDataProtocol, router: UsersRouterProtocol)
    func saveUser(_ name: String)
    func getAllUsers()
    func deleteUser(_ user: User)
    func userDidSelect(user: User?)
}
