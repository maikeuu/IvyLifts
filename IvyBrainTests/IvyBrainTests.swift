//
//  IvyBrainTests.swift
//  IvyBrainTests
//
//  Created by Mike Chu on 1/1/19.
//  Copyright © 2019 Mike Lin. All rights reserved.
//

import XCTest
@testable import IvyLifts
class IvyBrainTests: XCTestCase {

    var ivyBrain: IvyBrain!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let personalRecords = PersonalRecords()
        personalRecords.bench = 155.0
        personalRecords.deadlift = 315.0
        personalRecords.barbellRow = 155.0
        personalRecords.shoulderPress = 135.0
        personalRecords.squat = 215.0
        personalRecords.pullUps = 155.0
        
        ivyBrain = IvyBrain(personalRecords: personalRecords)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.ivyBrain = nil
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

}
