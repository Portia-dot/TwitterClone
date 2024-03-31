//
//  CustomProfileIcon.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-22.
//

import SwiftUI

struct CustomProfileIcon: View {
    var body: some View {
        ZStack{
            Image(systemName: "person")
                .font(.title3)
                .foregroundStyle(.purple)
                .padding(6)
                .overlay(Circle().stroke(Color.purple, lineWidth: 0.75))
            
            
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 7, height: 7)
                .foregroundStyle(.purple)
                .background(Circle().fill(Color.white))
                .offset(x: 8, y: 7)
        }
    }
}

#Preview {
    CustomProfileIcon()
}
