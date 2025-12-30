//
//  Picker.swift
//  CustomPicker
//
//  Created by Iqbal Alhadad on 30/12/25.
//

import SwiftUI
import Combine

struct Picker: View {
    var isLeft: Bool
    @Binding var Edit : Bool
    @Binding var selectedValue: String
    let value: [String]
    let title: String
    @State private var scrollID: String? = nil
    var body: some View {
        HStack(spacing: Edit ? 5 : 0) {
            ZStack {
                ScrollViewReader {
                    proxy in
                    ScrollView {
                        LazyVStack(spacing: -30) {
                            ForEach(value, id : \.self) {
                                value in
                                Text(value)
                                    .font(.system(size:25)).bold().frame(height: 63)
                                    .foregroundStyle(selectedValue == value ? Color.primary: .gray).id(value)
                                    .opacity(selectedValue == value ? 1 :(Edit ? 1 : 0000.01))
                                    .scrollTransition(axis: .vertical) {
                                        effect, phase in
                                        effect.scaleEffect((phase.isIdentity ? 1.0 : 0.1))
                    
                                    }
                            }
                        }.scrollTargetLayout()
                        
                    }
                    
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .safeAreaPadding(.vertical, 18)
                    .scrollPosition(id: $scrollID, anchor: .center)
                    .allowsHitTesting(Edit)
                    .onAppear {
                        scrollID = selectedValue
                        DispatchQueue.main.async {
                            proxy.scrollTo(selectedValue, anchor: .center)
                        }
                    }
                    .onChange(of: scrollID) { _, newID in
                       if let newID {
                          selectedValue = newID
                           
                        }
                    }
                        

                        } .frame(width: 40, height: 100)
                    }
                Text(title) .font(.system(size: 25)).bold()
                    .foregroundStyle(.gray)
                    
                    
                }
            .padding(.trailing,3)
            .padding(Edit ? .horizontal : .leading,10)
            .frame(height:Edit ? 105 : 60).clipped()
            .background(Color.gray.tertiary,in:shape(edit: Edit, isLeft: isLeft))
            }
        }
    
    func shape(edit: Bool, isLeft: Bool) -> UnevenRoundedRectangle {
        if edit {
            return UnevenRoundedRectangle (
                topLeadingRadius: 12,
                bottomLeadingRadius: 12,
                bottomTrailingRadius: 12,
                topTrailingRadius: 12
                
            )
        } else {
            if isLeft {
                return UnevenRoundedRectangle (
                    topLeadingRadius: 12,
                    bottomLeadingRadius: 12,
                    bottomTrailingRadius: 12,
                    topTrailingRadius: 0
                    )
            } else {
                return UnevenRoundedRectangle (
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 0
                )
            }
        }
    }
    



