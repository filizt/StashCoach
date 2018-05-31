//
//  AchievementsViewController.swift
//  StashCoach
//
//  Created by Filiz Kurban on 5/26/18.
//  Copyright © 2018 Filiz Kurban. All rights reserved.
//

import UIKit

// Presenter -> View
protocol AchievementsListViewProtocol: class {
    var presenter: AchievementsListPresenterProtocol? { get set }

    func showAchievementsList(achievements:[AchievementModel])

    func showNoContentScreen()

    func showError()

}

class AchievementsListViewController: UIViewController {

    @IBOutlet var achievementsTableView: UITableView!
    var presenter: AchievementsListPresenterProtocol?
    var achievementsList: [AchievementModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }

    fileprivate func setupView() {
        let infoButton = UIButton(type: .infoLight)

        let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
        navigationItem.rightBarButtonItem = infoBarButtonItem

        self.achievementsTableView.dataSource = self
        self.achievementsTableView.delegate = self
        self.achievementsTableView.estimatedRowHeight = 100
        self.achievementsTableView.rowHeight = UITableViewAutomaticDimension
        self.achievementsTableView.separatorStyle = .none

    }
}

extension AchievementsListViewController: AchievementsListViewProtocol {

    func showAchievementsList(achievements: [AchievementModel]) {
        achievementsList = achievements
        achievementsTableView.reloadData()
    }

    //for now, just show empty screen
    func showNoContentScreen() {
        achievementsList = []
        achievementsTableView.reloadData()
    }

    func showError() {
       print("Error loading achievements list")
    }
}

//MARK: Tableview delegates

extension AchievementsListViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return achievementsList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "achievementsTableViewCell", for: indexPath) as! AchievementsTableViewCell
        let achievement = achievementsList[indexPath.section]

        cell.selectionStyle = .none
        cell.achievement = achievement

        return cell
    }
}
