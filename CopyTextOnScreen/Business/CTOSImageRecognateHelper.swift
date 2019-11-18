//
//  CTOSImageRecognateHelper.swift
//  CopyTextOnScreen
//
//  Created by Dzmitry Kudrashou on 2019-11-17.
//  Copyright © 2019 Dzmitry Kudrashou. All rights reserved.
//

import UIKit
import Vision
import VisionKit

class CTOSImageRecognateHelper: CTOSTextRecognition {
	func recognateText(from image: UIImage, callback: @escaping CTOSImageRecognateHelper.RecognationClosureType) {
		var callbackWasCalled = false
		guard let cgImage = image.cgImage else {
			let error = NSError(domain: "Image can't be converted", code: 0, userInfo: nil)
			callback([], error, 0)
			return
		}
		
		let maximumCandidates = 1
		let dateStart = Date()
		let textRecognitionRequest = VNRecognizeTextRequest { (request, error) in
			var recognatedTexts: [String] = []

			defer {
				if !callbackWasCalled {
					callbackWasCalled = true
					callback(recognatedTexts, error, Date().timeIntervalSince(dateStart))
				}
			}
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                print("The observations are of an unexpected type.")
                return
            }
            
            for observation in observations {
				if let candidate = observation.topCandidates(maximumCandidates).first {
					recognatedTexts.append(candidate.string)
				}
            }
        }
        // specify the recognition level
        textRecognitionRequest.recognitionLevel = .accurate
		
		let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
		do {
			try requestHandler.perform([textRecognitionRequest])
		} catch {
			if !callbackWasCalled {
				callbackWasCalled = true
				callback([], error, Date().timeIntervalSince(dateStart))
			}
			print(error)
		}
	}
}
