//
//  SceneDelegate.swift
//  Battleships
//
//  Created by Andrey Volobuev on 30/05/2020.
//  Copyright © 2020 Andrey Volobuev. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let interactor = GameInteractor()
        let viewController = GameViewController(gameInteractorInput: interactor)
        window?.rootViewController = viewController
        interactor.view = viewController
        window?.makeKeyAndVisible()
    }
}
