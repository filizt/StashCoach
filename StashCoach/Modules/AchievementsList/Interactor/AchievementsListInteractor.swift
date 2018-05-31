//
//  AchievementsListInteractor.swift
//  StashCoach
//
//  Created by Filiz Kurban on 5/28/18.
//  Copyright © 2018 Filiz Kurban. All rights reserved.
//

import Foundation

// Presenter -> Interactor
protocol AchievementsListInteractorInputProtocol: class {
    var presenter: AchievementsListInteractorOutputProtocol? { get set }
    var dataManager: AchievementsListDataManagerInputProtocol? { get set }

    func loadAchievements()
    //test hook
    func setAchievementsLoaderMode(mode: AchievementsFileTestMode)
}

public enum AchievementsFileTestMode:String {
    case none //assuming production for now
    case testValid
    case testEmpty
    case testMissingValues

    public var resource: String {
        switch self {
        case .none: return "achievements"
        case .testValid: return "achievements"
        case .testEmpty: return "achievementsTest_Empty"
        case .testMissingValues: return "achievementsTestMissingFields"
        }
    }
}

class AchievementsListInteractor: AchievementsListInteractorInputProtocol {

    weak var presenter: AchievementsListInteractorOutputProtocol?
    var dataManager: AchievementsListDataManagerInputProtocol?

    var achievementsResource = AchievementsFileTestMode.none

    func loadAchievements() {
        if let list  = dataManager?.loadAchievements(resource: achievementsResource.resource) {
            presenter?.achievementsListLoaded(achievements: list)
        } else {
            presenter?.achievementsListLoadFailed()
        }
    }

    func setAchievementsLoaderMode(mode: AchievementsFileTestMode) {
        achievementsResource = mode
    }
}

