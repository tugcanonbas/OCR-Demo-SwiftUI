//
//  ContentViewModel.swift
//  OCR-Demo-SwiftUI
//
//  Created by Tuğcan ÖNBAŞ on 31.03.2023.
//

import SwiftUI
import PhotosUI

enum Guide {
    case idle
    case error
    case success
    
    var description: (String, Color) {
        switch self {
        case .idle:
            return ("Select an image to OCR", .blue)
        case .error:
            return ("Select a Valid Image", .red)
        case .success:
            return ("Press and Hold to Show OCR Data", .yellow)
        }
    }
}

class ContentViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem?
    @Published private(set) var image: Image?
    
    @Published private(set) var results: [OCRResult] = []
    
    @Published private(set) var guideText: Guide = .idle
    
    func clearImage() {
        results = []
        image = nil
    }
    
    func selectItem(_ item: PhotosPickerItem?) {
        Task {
            if let data = try? await item?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    
                    let ocrController = OCRManager(image: uiImage)
                    
                    DispatchQueue.main.async {
                        self.results = ocrController.execute()
                        
                        self.image = Image(uiImage: uiImage)
                    }
                    return
                }
            }
        }
    }
    
    func setGuideText(_ image: Image?) {
        if results.isEmpty {
            if image == nil {
                guideText = .idle
            } else {
                guideText = .error
            }
        } else {
            if image != nil {
                guideText = .success
            } else {
                guideText = .idle
            }
        }
    }
}
