//
//  GuideView.swift
//  OCR-Demo-SwiftUI
//
//  Created by Tuğcan ÖNBAŞ on 31.03.2023.
//

import SwiftUI

struct GuideView: View {
    
    @ObservedObject var vm: ContentViewModel
    
    var body: some View {
        VStack {
            if vm.guideText == .success {
                VStack {
                    Text("c = Confidence")
                        .font(.caption)
                    HStack {
                        HStack {
                            Rectangle()
                                .foregroundColor(.green.opacity(0.5))
                                .frame(width: 16.0, height: 16.0)
                            Text("c >= 0.90")
                        }
                        HStack {
                            Rectangle()
                                .foregroundColor(.orange.opacity(0.5))
                                .frame(width: 16.0, height: 16.0)
                            Text("c >= 0.50")
                        }
                        HStack {
                            Rectangle()
                                .foregroundColor(.red.opacity(0.5))
                                .frame(width: 16.0, height: 16.0)
                            Text("c < 0.50")
                        }
                    }
                    .font(.caption2)
                }
                .foregroundColor(.blue)
            }
            
            Text(vm.guideText.description.0)
                .font(.callout)
                .foregroundColor(vm.guideText.description.1)
                .onChange(of: vm.image, perform: vm.setGuideText)
        }
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView(vm: ContentViewModel())
    }
}
