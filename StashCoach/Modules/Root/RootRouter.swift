//
//  RootRouter.swift
//  StashCoach
//
//  Created by Filiz Kurban on 5/28/18.
//  Copyright © 2018 Filiz Kurban. All rights reserved.
//

import UIKit

protocol RootWireframe: class {
    func presentRootScreen(in window: UIWindow)
}

class RootRouter: RootWireframe {

    func presentRootScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = AchievementsListWireFrame.createAchievementsListModule()
    }

}
