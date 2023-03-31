//
//  ContentView.swift
//  OCR-Demo-SwiftUI
//
//  Created by Tuğcan ÖNBAŞ on 31.03.2023.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @StateObject var vm: ContentViewModel = ContentViewModel()
    
    var imageHeader: some View {
        HStack {
            Spacer()
            Button {
                vm.clearImage()
            } label: {
                Image(systemName: "clear.fill")
                    .font(.title3)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical)
    }
    
    var body: some View {
        VStack {
            Text("OCR Demo")
                .foregroundColor(.blue)
                .font(.title)
                .bold()
            
            Spacer()
            
            if vm.image != nil {
                imageHeader
            }
            
            OCRView(vm: vm)
            
            GuideView(vm: vm)
            
            Spacer()
            
            PhotosPicker(selection: $vm.selectedItem, matching: .images) {
                Text("Pick an Image!")
                    .button()
            }
            .onChange(of: vm.selectedItem, perform: vm.selectItem)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
