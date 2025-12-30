//
//  ContentView.swift
//  CustomPicker
//
//  Created by Iqbal Alhadad on 30/12/25.
//

import SwiftUI

struct ContentView: View {
    @State var Edit = false
    @State private var hour = "20"
    @State private var minute = "30"
    
    private let Hr = (0...24).map {
        String(format: "%1d", $0)
    }
    private let min = (0...60).map {
        String($0)
    }
    
    var body: some View {
        HStack(spacing: Edit ? 20 : 0) {
            Picker(isLeft: true, Edit: $Edit, selectedValue: $hour, value: Hr, title: "Hr")
            Picker(isLeft: false, Edit: $Edit, selectedValue: $minute, value: min, title: "Min")
            ZStack {
                if Edit {
                    Image(systemName: "checkmark")
                        .font(.system(size: 25)) .bold()
                        .transition(.blurReplace.combined(with: .offset(x:-35)))
                        
                } else {
                    Image(systemName: "pencil")
                        .renderingMode(.template)
                        .resizable().scaledToFill()
                        .foregroundStyle(.primary)
                        .frame(width: 20, height: 20)
                        .transition(.blurReplace.combined(with: .offset(x:35)))
                    
                }
            }
            .padding(.horizontal,20)
            .frame(height:Edit ? 105 : 60)
            .background(Color.gray.tertiary,in:UnevenRoundedRectangle(topLeadingRadius: Edit ? 12 : 0 ,bottomLeadingRadius: Edit ? 12 : 0, bottomTrailingRadius: 12, topTrailingRadius: 12))
            .onTapGesture {
                withAnimation(!Edit ? .smooth(duration: 0.5,extraBounce: 0.5) : .smooth) {
                    Edit.toggle()
                }
            }
           
        }
    }
}

#Preview {
    ContentView()
}
