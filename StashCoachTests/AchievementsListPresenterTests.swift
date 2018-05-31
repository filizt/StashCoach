//
//  AchievementsListPresenterTests.swift
//  StashCoachTests
//
//  Created by Filiz Kurban on 5/30/18.
//  Copyright © 2018 Filiz Kurban. All rights reserved.
//

import XCTest
import SDWebImage
@testable import StashCoach

class AchievementsListPresenterTests: XCTestCase {

    var presenter : AchievementsListPresenter!
    weak var view: AchievementsListViewProtocol!
    var mockInteractor: MockInteractor!
    var mockRouter: MockRouter!
    var mockAchievementsViewController : MockListViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.mockRouter = MockRouter()
        self.mockAchievementsViewController = MockListViewController()
        self.mockInteractor = MockInteractor()

        presenter = AchievementsListPresenter()

        presenter.view = self.mockAchievementsViewController

        mockInteractor.presenter = self.presenter
        presenter.interactor = self.mockInteractor

        mockAchievementsViewController.presenter = self.presenter
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    class MockInteractor: AchievementsListInteractorInputProtocol {
        var presenter: AchievementsListInteractorOutputProtocol?
        var dataManager: AchievementsListDataManagerInputProtocol?
        var achievementsResource = AchievementsFileTestMode.none

        func loadAchievements() {

            switch achievementsResource {
            case .testValid:
                var achivementsList = [AchievementModel]()
                 achivementsList.append(AchievementModel.init(id: 0, level: "1", progress: 10, total: 50, bgImageURL: "https://foo.bar", accessible: true))
                presenter?.achievementsListLoaded(achivementsList)
            case .testMissingValues:
                presenter?.achievementsListLoadFailed()
            case .testEmpty:
                let achivementsList = [AchievementModel]()
                presenter?.achievementsListLoaded(achivementsList)
            case .none:
                print("no-op")
            }
        }

        func setAchievementsLoaderMode(mode: AchievementsFileTestMode) {
            achievementsResource = mode
        }
    }

    class MockRouter: RootWireframe {
        var inputCallbackResults = [String:AnyObject]()
        var currentWindow = UIApplication.shared.keyWindow

        func presentRootScreen(in currentWindow: UIWindow) {
            inputCallbackResults["showAchievementsViewController"] = currentWindow.rootViewController
        }
    }

    class MockListViewController: UIViewController, AchievementsListViewProtocol {
        var presenter: AchievementsListPresenterProtocol?

        var achievementsListShown = false
        var noContentViewShown = false
        var showAchievementsListFailed = false

        func showAchievementsList(achievements: [AchievementModel]) {
            achievementsListShown = true
        }

        func showNoContentScreen() {
            noContentViewShown = true
        }

        func showError() {
            showAchievementsListFailed = true
        }
    }

    // MARK: Tests

    func testAchievementsListShowSuccess() {
        self.mockInteractor.setAchievementsLoaderMode(mode: AchievementsFileTestMode.testValid)
        self.mockInteractor.loadAchievements()
        XCTAssertTrue(mockAchievementsViewController.achievementsListShown)
    }

    func testAchievementsListShowNoContentView() {
        self.mockInteractor.setAchievementsLoaderMode(mode: AchievementsFileTestMode.testEmpty)
        self.mockInteractor.loadAchievements()
        XCTAssertTrue(mockAchievementsViewController.noContentViewShown)
    }

    func testAchievementsListShowFail() {
        self.mockInteractor.setAchievementsLoaderMode(mode: AchievementsFileTestMode.testMissingValues)
        self.mockInteractor.loadAchievements()
        XCTAssertTrue(mockAchievementsViewController.showAchievementsListFailed)

    }
}
