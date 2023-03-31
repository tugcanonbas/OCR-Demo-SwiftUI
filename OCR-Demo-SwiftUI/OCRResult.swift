//
//  OCRResult.swift
//  OCR-Demo-SwiftUI
//
//  Created by Tuğcan ÖNBAŞ on 31.03.2023.
//

import Foundation

struct OCRResult {
    let id: UUID = UUID()
    let text: String
    let confidence: Double
    let boundingBox: CGRect
}
