//
//  FantalyticsTests.swift
//  FantalyticsTests
//
//  Created by Vik Denic on 11/21/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import XCTest
import Parse
@testable import Fantalytics

class FantalyticsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGamesCreation() {
        let expectation = self.expectationWithDescription("games")

        ProBballManager.getGamesForDate(NSDate()) { (games) -> Void in
            XCTAssertNotNil(games)
            expectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(6.0, handler: nil)
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
