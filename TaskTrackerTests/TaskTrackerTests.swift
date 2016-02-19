//
//  TaskTrackerTests.swift
//  TaskTrackerTests
//
//  Created by Alex Yi on 2/12/16.
//  Copyright © 2016 Alex Yi. All rights reserved.
//

//import XCTest
//@testable import TaskTracker

import UIKit
import XCTest

class TaskTrackerTests: XCTestCase {
    
        // MARK: TaskTracker Tests
    
    // Test to confirm that Task initialier returns when no name provided
    func testMealInitialization() {
        // success case
        let potentialItem = Task(name: "New Task", comments: nil, priority: "Low")
        XCTAssertNotNil(potentialItem)
        
        // failure case
        let noName = Task(name: "", comments: nil, priority: "High")
        XCTAssertNil(noName, "can't have empty name string")
        
        // should fail initialization, but assert that initialization should succeed
        //XCTAssertNotNil(noName)
        XCTAssertNil(noName, "can't have empty name string")
    }
}
