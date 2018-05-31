//
//  AchievementsListInteractorTests.swift
//  StashCoachTests
//
//  Created by Filiz Kurban on 5/30/18.
//  Copyright © 2018 Filiz Kurban. All rights reserved.
//

import XCTest
@testable import StashCoach

class AchievementsListInteractorTests: XCTestCase {

    var presenter: MockPresenter!
    var interactor: AchievementsListInteractor!
    var dataManager: AchievementsListDataManager!

    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.presenter = MockPresenter()
        self.interactor = AchievementsListInteractor()
        self.dataManager = AchievementsListDataManager()
        self.interactor.presenter = presenter
        self.interactor.dataManager = dataManager

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

class MockPresenter: AchievementsListInteractorOutputProtocol {
    var achievementsListLoaded = false
    var achievementsListLoadFail = false

    func achievementsListLoaded(achievements: [AchievementModel]) {
        achievementsListLoaded = true
    }

    func achievementsListLoadFailed() {
        achievementsListLoadFail = true
    }
}

//MARK: Tests

    func testAchievementsListLoadSuccess() {
        self.interactor.setAchievementsLoaderMode(mode: AchievementsFileTestMode.testValid)
        self.interactor.loadAchievements()
        XCTAssertTrue(self.presenter.achievementsListLoaded)
    }

    func testAchievementsListLoadFail_EmptyFile() {
        self.interactor.setAchievementsLoaderMode(mode: AchievementsFileTestMode.testEmpty)
        self.interactor.loadAchievements()
        XCTAssertTrue(self.presenter.achievementsListLoaded) //To show no-content view
    }

    func testAchievementsListLoadFail_MissingValues() {
        self.interactor.setAchievementsLoaderMode(mode: AchievementsFileTestMode.testMissingValues)
        self.interactor.loadAchievements()
        XCTAssertTrue(presenter.achievementsListLoadFail)
    }

}




