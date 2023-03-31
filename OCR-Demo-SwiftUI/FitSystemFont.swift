//
//  FitSystemFont.swift
//  OCR-Demo-SwiftUI
//
//  Created by Tuğcan ÖNBAŞ on 31.03.2023.
//

import SwiftUI

struct FitSystemFontModifier: ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .font(.system(size: min(min(geometry.size.width, geometry.size.height), CGFloat.greatestFiniteMagnitude)))
                .minimumScaleFactor(0.01)
                .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
        }
    }
}

extension View {
    func fitSystemFont() -> ModifiedContent<Self, FitSystemFontModifier> {
        return modifier(FitSystemFontModifier())
    }
}

