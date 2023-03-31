//
//  OCRManager.swift
//  OCR-Demo-SwiftUI
//
//  Created by Tuğcan ÖNBAŞ on 31.03.2023.
//

import SwiftUI
import Vision

struct OCRManager {
    let image: UIImage
    var textRecognitionRequst = VNRecognizeTextRequest()
    
    func execute() -> [OCRResult] {
        let raw: [VNRecognizedTextObservation] = ocr()
        let results: [OCRResult] = convert(from: raw)
        
        return results
    }
    
    private func convert(from results: [VNRecognizedTextObservation]) -> [OCRResult] {
        var ocrResults: [OCRResult] = []
        
        for textObservation in results {
            guard let candidate = textObservation.topCandidates(1).first else {
                print("Can not find top candidate's first")
                return []
            }
            
            let ocrResult = OCRResult(text: candidate.string, confidence: Double(candidate.confidence), boundingBox: textObservation.boundingBox.standardized)
            
            ocrResults.append(ocrResult)
        }
        
        return ocrResults
    }
    
    private func ocr() -> [VNRecognizedTextObservation] {
        
        textRecognitionRequst.recognitionLevel = .accurate
        textRecognitionRequst.usesLanguageCorrection = true
        textRecognitionRequst.revision = VNRecognizeTextRequestRevision3
        
        guard let cgImage = image.cgImage else {
            print("Can not convert image to cgImage")
            return []
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage)
        
        do {
            try handler.perform([textRecognitionRequst])
            
            guard let results = textRecognitionRequst.results else {
                print("Can not find results")
                return []
            }
            
            return results
        } catch {
            print("Error: \(error)")
        }
        
        return []
    }
}
