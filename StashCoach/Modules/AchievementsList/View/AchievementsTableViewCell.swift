//
//  AchievementsTableViewCell.swift
//  StashCoach
//
//  Created by Filiz Kurban on 5/26/18.
//  Copyright © 2018 Filiz Kurban. All rights reserved.
//

import UIKit
import SDWebImage

class AchievementsTableViewCell: UITableViewCell {

    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var levelTitleLabel: UILabel!
    @IBOutlet weak var levelNumberLabel: UILabel!
    @IBOutlet weak var currentAchievementsPointsLabel: UILabel!
    @IBOutlet weak var targetAchievementPointsLabel: UILabel!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var levelView: UIView!
    @IBOutlet var progressViewBar: UIProgressView!
    
    var achievement: AchievementModel? {
        didSet {
            setupUI()
        }
    }
    
    override func prepareForReuse() {
        backgroundImageView.sd_cancelCurrentImageLoad()
        progressViewBar = nil
        levelTitleLabel = nil
    }

    func setupUI() {
        //update ui elements
        if let achievement = achievement {
            levelTitleLabel.text = "LEVEL"
            levelNumberLabel.text = achievement.level
            currentAchievementsPointsLabel.text = String(achievement.progress) + " pts"
            targetAchievementPointsLabel.text = String(achievement.total) + " pts"
            levelView.layer.cornerRadius = levelView.frame.size.width / 2
            backgroundImageView.sd_setImage(with: URL(string: achievement.bgImageURL), completed: nil)
            
            if achievement.progress > 0 {
                progressViewBar.setProgress(Float(achievement.progress)/100, animated: false)
            }
        }
    }
}
