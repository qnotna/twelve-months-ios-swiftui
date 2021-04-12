//
//  Copyright © 2019 Anton Quietzsch. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let rootController = RootController()
            coordinator = MainCoordinator(navigationController: rootController)
            coordinator?.start()
            self.window = window
            window.rootViewController = rootController
            window.makeKeyAndVisible()
        }
    }
}
