//
//  SynchronizeArrayTests.swift
//  tips-and-tricksTests
//
//  Created by Arkady Smirnov on 7/3/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import XCTest
@testable import tips_and_tricks

class SynchronizeArrayTests: XCTestCase {
    
    func test_append() {
        let array: SynchronizedArray<Int> = []
        array.append(1)
        XCTAssertTrue(array[0] == 1)
    }
    
    func test_map() {
        let array: SynchronizedArray<Int> = [1]
        let stringArray = array.map { String($0) }
        XCTAssertTrue(stringArray[0] == "1")
    }
    
}
