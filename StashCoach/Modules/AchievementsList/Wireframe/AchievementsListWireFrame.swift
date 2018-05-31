//
//  AchievementsListWireFrame.swift
//  StashCoach
//
//  Created by Filiz Kurban on 5/28/18.
//  Copyright © 2018 Filiz Kurban. All rights reserved.
//

import UIKit

// Presenter -> Wireframe
protocol AchievementsListWireFrameProtocol: class {
    static func createAchievementsListModule() -> UIViewController
}

class AchievementsListWireFrame: AchievementsListWireFrameProtocol {

    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }

    class func createAchievementsListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "AchievementsNavigationController") as! UINavigationController
        if let view = navController.topViewController as? AchievementsListViewController {
            let presenter: AchievementsListPresenterProtocol & AchievementsListInteractorOutputProtocol = AchievementsListPresenter()
            let interactor: AchievementsListInteractorInputProtocol = AchievementsListInteractor()
            let dataManager: AchievementsListDataManagerInputProtocol = AchievementsListDataManager()
            let wireFrame: AchievementsListWireFrameProtocol = AchievementsListWireFrame()

            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.dataManager = dataManager
           
            return navController
        }
        return UIViewController()
    }



}

