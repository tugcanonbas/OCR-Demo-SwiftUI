//
//  OverlayView.swift
//  OCR-Demo-SwiftUI
//
//  Created by Tuğcan ÖNBAŞ on 31.03.2023.
//

import SwiftUI

struct OverlayView: View {
    let results: [OCRResult]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(results, id:\.id) { item in
                    Text(item.text)
                        .fitSystemFont()
                        .frame(width: item.boundingBox.width * geometry.size.width, height: item.boundingBox.height * geometry.size.height)
                        .background(colorized(item.confidence))
                        .offset(x: item.boundingBox.minX * (geometry.size.width), y: item.boundingBox.maxY * -(geometry.size.height) + geometry.size.height)
                }
            }
        }
    }
    
    private func colorized(_ confidence: Double) -> Color {
        var color: Color = .red
        
        if confidence >= 0.90 {
            color = .green
        } else if confidence >= 0.50 {
            color = .orange
        } else {
            color = .red
        }
        
        return color.opacity(0.5)
    }
}

struct OverlayView_Previews: PreviewProvider {
    static var previews: some View {
        OverlayView(results: [])
    }
}
