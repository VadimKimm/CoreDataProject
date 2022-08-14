//
//  SceneDelegate.swift
//  CoreDataProject
//
//  Created by Vadim Kim on 14.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: UsersViewController())
        window.makeKeyAndVisible()
        self.window = window
    }
}

