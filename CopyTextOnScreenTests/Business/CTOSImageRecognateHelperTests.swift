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
		let verifiedTexts = ["// Called as the scene is being released by the system.", "// This occurs shortly after the scene enters the background, or when its session is discarded.", "// Release any resources associated with this scene that can be re-created the next time the scene connects.", "// The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead)."]

		let imageName = "TextExample1"
		
		let image = UIImage(named: imageName, in: self.bundle, compatibleWith: nil)
		
		XCTAssertNotNil(image)
		guard let verifiedImage = image else { return }
		
		let expectation = XCTestExpectation(description: "Recognate text on image")
		self.testedObject.recognateText(from: verifiedImage) { (recogntedTexts, error, recognitionTime) in
			XCTAssertNil(error)
			XCTAssertEqual(verifiedTexts, recogntedTexts)
			expectation.fulfill()
		}
		// Wait until the expectation is fulfilled, with a timeout of 10 seconds.
		self.wait(for: [expectation], timeout: self.expectationTimeout)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
