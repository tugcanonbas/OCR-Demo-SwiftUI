//
//  OCRView.swift
//  OCR-Demo-SwiftUI
//
//  Created by Tuğcan ÖNBAŞ on 31.03.2023.
//

import SwiftUI

struct OCRView: View {
    
    @ObservedObject var vm: ContentViewModel
    
    @GestureState var isPressed: Bool = false
    
    @ViewBuilder
    private func confidenceText(_ text: String, color: Color = .blue) -> some View {
        HStack {
            Rectangle()
                .foregroundColor(color.opacity(0.5))
                .frame(width: 16.0, height: 16.0)
            Text(text)
        }
    }
    
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity)
            .updating($isPressed) { currentState, gestureState, transaction in
                withAnimation(.easeOut(duration: 0.5)) {
                    gestureState = currentState
                }
            }
    }
    
    var body: some View {
        ZStack {
            vm.image?
                .resizable()
                .simultaneousGesture(longPress)
                .opacity(isPressed ? 0.5 : 1.0)
                .overlay {
                    if isPressed {
                        OverlayView(results: vm.results)
                    }
                }
                .scaledToFit()
        }
        .frame(maxHeight: UIScreen.screenHeight * 0.8)
    }
}

struct OCRView_Previews: PreviewProvider {
    static var previews: some View {
        OCRView(vm: ContentViewModel())
    }
}
