//
//  ButtonModifier.swift
//  OCR-Demo-SwiftUI
//
//  Created by Tuğcan ÖNBAŞ on 31.03.2023.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(32)
    }
}

extension View {
    func button() -> ModifiedContent<Self, ButtonModifier> {
        return modifier(ButtonModifier())
    }
}
