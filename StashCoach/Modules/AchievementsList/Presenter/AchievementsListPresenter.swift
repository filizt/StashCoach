//
//  AchievementsPresenter.swift
//  StashCoach
//
//  Created by Filiz Kurban on 5/28/18.
//  Copyright © 2018 Filiz Kurban. All rights reserved.
//

import Foundation

// View -> Presenter
protocol AchievementsListPresenterProtocol: class {
    var view: AchievementsListViewProtocol? { get set }
    var interactor: AchievementsListInteractorInputProtocol? { get set }
    var wireFrame: AchievementsListWireFrameProtocol? { get set }

    func viewDidLoad()
    
}

class AchievementsListPresenter: AchievementsListPresenterProtocol {
    weak var view: AchievementsListViewProtocol?
    var interactor: AchievementsListInteractorInputProtocol?
    var wireFrame: AchievementsListWireFrameProtocol?

    var achievements: [AchievementModel] = [] {
        didSet {
            if achievements.count > 0 {
                view?.showAchievementsList(achievements: achievements)
            } else {
                view?.showNoContentScreen()
            }
        }
    }

    func viewDidLoad() {
        interactor?.loadAchievements()
    }
}

// Interactor -> Presenter
protocol AchievementsListInteractorOutputProtocol: class {
    func achievementsListLoaded(achievements: [AchievementModel])
    func achievementsListLoadFailed()
}

extension AchievementsListPresenter: AchievementsListInteractorOutputProtocol {

    func achievementsListLoaded(achievements: [AchievementModel]) {
        self.achievements = achievements
    }

    internal func achievementsListLoadFailed() {
        view?.showError()
    }
}

