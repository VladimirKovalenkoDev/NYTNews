//
//  SceneDelegate.swift
//  NYTNews
//
//  Created by Владимир Коваленко on 26.02.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        let navigationController = UINavigationController(rootViewController: NewsListController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

