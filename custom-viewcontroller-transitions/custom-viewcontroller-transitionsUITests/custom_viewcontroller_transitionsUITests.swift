//
//  custom_viewcontroller_transitionsUITests.swift
//  custom-viewcontroller-transitionsUITests
//
//  Created by Joshua Alvarado on 9/21/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import XCTest

class custom_viewcontroller_transitionsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPushTransition() {
        let app = XCUIApplication()
        app.buttons["Push"].tap()
        app.navigationBars["View Controller"].buttons["Title"].tap()
    }
    
    func testPresentTransition() {
        let app = XCUIApplication()
        app.buttons["Present"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.swipeDown()
    }
    
    func testTabBarTransition() {
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Favorites"].tap()
        tabBarsQuery.buttons["Most Recent"].tap()
    }
}
