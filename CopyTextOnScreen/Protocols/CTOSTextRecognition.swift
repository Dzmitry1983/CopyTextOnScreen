//
//  CTOSTextRecognition.swift
//  CopyTextOnScreen
//
//  Created by Dzmitry Kudrashou on 2019-11-17.
//  Copyright © 2019 Dzmitry Kudrashou. All rights reserved.
//

import UIKit

protocol CTOSTextRecognition {
	typealias RecognationClosureType = (_ text: [String], _ error: Error?, _ recognitionTime: TimeInterval) -> Void
	func recognateText(from image: UIImage, callback: @escaping RecognationClosureType)
}
