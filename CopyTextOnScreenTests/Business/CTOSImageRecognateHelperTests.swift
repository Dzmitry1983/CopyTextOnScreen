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
	private let bundle = Bundle(for: CTOSImageRecognateHelperTests.self)
	private let expectationTimeout: TimeInterval = 5

    override func setUp() {
		self.testedObject = TestedType()
		XCTAssertNotNil(self.testedObject)
    }

    override func tearDown() {
        //This code tests that object can be removed correctlly and we don't have memory leaks
		weak var weakObject: TestedType? = self.testedObject
		XCTAssertNotNil(weakObject)
		self.testedObject = nil
		XCTAssertNil(weakObject)
    }

	func testImageExample1Recognate() {
		let verifiedTexts = [
			"Test1",
			"Test2",
			"Text to test 3"
		]

		let imageName = "TextExample1"
		
		let image = UIImage(named: imageName, in: self.bundle, compatibleWith: nil)
		
		XCTAssertNotNil(image)
		guard let verifiedImage = image else { return }
		
		let expectation = XCTestExpectation(description: "Recognate text on image")
		self.testedObject.recognateText(from: verifiedImage) { (recogntedTexts, error, recognitionTime) in
			XCTAssertNil(error)
			XCTAssertEqual(verifiedTexts.count, recogntedTexts.count)
			for index in 0..<min(verifiedTexts.count, recogntedTexts.count) {
				XCTAssertEqual(verifiedTexts[index], recogntedTexts[index])
			}
			XCTAssertEqual(verifiedTexts, recogntedTexts)
			expectation.fulfill()
		}
		self.wait(for: [expectation], timeout: self.expectationTimeout)
    }

    func testPerformanceExample() {
		let imageName = "TextExample1"
		guard let verifiedImage = UIImage(named: imageName, in: self.bundle, compatibleWith: nil) else { return }
        self.measure {
			let expectation = XCTestExpectation(description: "Recognate text on image")
			self.testedObject.recognateText(from: verifiedImage) { (recogntedTexts, error, recognitionTime) in
				expectation.fulfill()
			}
			self.wait(for: [expectation], timeout: 10)
        }
    }

}
