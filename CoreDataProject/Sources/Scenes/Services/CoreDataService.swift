//
//  CoreDataService.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 14.08.2022.
//

import Foundation
import CoreData

// MARK: - CoreDataProtocol

protocol CoreDataProtocol: AnyObject {
    func saveUser(_ name: String)
    func getAllUsers() -> [User]?
    func deleteUser(_ user: User)
    func updateUser(_ user: User, newName: String?, birthDate: String?, gender: String?)
}

// MARK: - CoreDataService

class CoreDataService: CoreDataProtocol {

    // MARK: - Propertries

    static let sharedManager = CoreDataService()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private lazy var context = persistentContainer.viewContext

    // MARK: - Functions

    func saveUser(_ name: String) {
        let newUser = User(context: context)
        newUser.name = name

        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    func getAllUsers() -> [User]? {
        do {
            let request = User.fetchRequest() as NSFetchRequest<User>
            let sort = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sort]
            let users = try context.fetch(request)
            return users
        } catch {
            print(error)
            return nil
        }
    }

    func deleteUser(_ user: User) {
        context.delete(user)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    func updateUser(_ user: User, newName: String?, birthDate: String?, gender: String?) {
        if let newName = newName {
            user.name = newName
        }

        if let birthDate = birthDate {
            user.birthDate = birthDate.convertToDate()
        }

        if let gender = gender {
            user.gender = gender
        }

        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

// MARK: - Core Data Saving support

extension CoreDataService {
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}