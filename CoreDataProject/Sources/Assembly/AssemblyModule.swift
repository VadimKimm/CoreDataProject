//
//  UsersModuleAssembly.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 14.08.2022.
//

import UIKit

// MARK: - ModuleAssemblyType

protocol ModuleAssemblyType {
    var storage: StorageType { get }

    func createUsersModule(router: UsersRouterProtocol) -> UIViewController
    func createDetailedUserModule(router: UsersRouterProtocol, user: User?) -> UIViewController
}

//MARK: - AssemblyModule

class AssemblyModule: ModuleAssemblyType {

    // MARK: - Properties

    var storage: StorageType = Storage()

    // MARK: - Functions

    func createUsersModule(router: UsersRouterProtocol) -> UIViewController {
        let view = UsersViewController()
        let presenter = UsersPresenter(view: view,
                                       storage: storage,
                                       router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailedUserModule(router: UsersRouterProtocol, user: User?) -> UIViewController {
        let view = DetailedUserViewController()
        let presenter = DetailedUserPresenter(view: view,
                                              storage: storage,
                                              router: router,
                                              user: user)
        view.presenter = presenter
        return view
    }
}
