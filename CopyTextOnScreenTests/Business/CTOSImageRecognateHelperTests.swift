//
//  CTOSImageRecognateHelperTests.swift
//  CopyTextOnScreenTests
//
//  Created by Dzmitry Kudrashou on 2019-11-17.
//  Copyright © 2019 Dzmitry Kudrashou. All rights reserved.
//

import XCTest
@testable import CopyTextOnScreen

class CTOSImageRecognateHelperTests: XCTestCase {
	
	private typealias TestedType = CTOSImageRecognateHelper
	private var testedObject: TestedType!

    override func setUp() {
		self.testedObject = TestedType()
    }

    override func tearDown() {
        //This code tests that object can be removed correctlly and we don't have memory leaks
		weak var weakObject: TestedType? = self.testedObject
		XCTAssertNotNil(weakObject)
		self.testedObject = nil
		XCTAssertNil(weakObject)
    }

    func testImageRecognate() {

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
