//
//  UsersModuleAssembly.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 14.08.2022.
//

import UIKit


// MARK: - ModuleAssemblyProtocol

protocol ModuleAssemblyProtocol {
    func createUsersModule(router: UsersRouterProtocol) -> UIViewController
    func createDetailedUserModule(router: UsersRouterProtocol, user: User?) -> UIViewController
}

//MARK: - AssemblyModule

class AssemblyModule: ModuleAssemblyProtocol {
    func createUsersModule(router: UsersRouterProtocol) -> UIViewController {
        let coreDataService = CoreDataService.sharedManager
        let view = UsersViewController()
        let presenter = UsersPresenter(view: view, coreDataService: coreDataService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailedUserModule(router: UsersRouterProtocol, user: User?) -> UIViewController {
        let coreDataService = CoreDataService.sharedManager
        let view = DetailedUserViewController()
        let presenter = DetailedUserPresenter(view: view, coreDataService: coreDataService, router: router, user: user)
        view.presenter = presenter
        return view
    }
}
