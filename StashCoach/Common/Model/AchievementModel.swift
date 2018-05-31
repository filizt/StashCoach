//
//  AchievementModel.swift
//  StashCoach
//
//  Created by Filiz Kurban on 5/28/18.
//  Copyright © 2018 Filiz Kurban. All rights reserved.
//

// Model class for Achievements

import Foundation

struct AchievementModel {
    var id: Int
    var level: String
    var progress: Int
    var total: Int
    var bgImageURL: String
    var accessible: Bool
}


extension AchievementModel {
    init?(json: [String: Any]) {
       guard let id = json["id"] as? Int,
        let level = json["level"] as? String,
        let progress = json["progress"] as? Int,
        let total = json["total"] as? Int,
        let bgImageURL = json["bg_image_url"] as? String,
        let accessible = json["accessible"] as? Bool
        else {
            return nil
        }

        // Initialize properties
        self.id = id
        self.level = level
        self.progress = progress
        self.total = total
        self.bgImageURL = bgImageURL
        self.accessible = accessible
    }
}
