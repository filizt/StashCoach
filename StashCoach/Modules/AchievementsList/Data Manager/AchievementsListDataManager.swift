//
//  AchievementsListDataManager.swift
//  StashCoach
//
//  Created by Filiz Kurban on 5/28/18.
//  Copyright © 2018 Filiz Kurban. All rights reserved.
//

import Foundation

// Interactor -> DataManager
protocol AchievementsListDataManagerInputProtocol: class {
    func loadAchievements(resource: String) -> [AchievementModel]?
}

// Load achievements list from a JSON file.

class AchievementsListDataManager: AchievementsListDataManagerInputProtocol {

    func loadAchievements(resource: String) -> [AchievementModel]?  {

        var achievementsList = [AchievementModel]()
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let achievements = jsonResult["achievements"] as? [Any] {

                    for eachAchievement in achievements {
                        if let achievement = eachAchievement as? [String:Any] {
                            if let achievementCreated = AchievementModel(json: achievement) {
                                achievementsList.append(achievementCreated)
                            } else {
                                //json must be misconstructed
                                return nil
                            }
                        }
                    }
                }
            } catch {
                // TO-DO: handle error here or rethrow.
            }
        }
        return achievementsList
    }
}

