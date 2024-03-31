//
//  AuthView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-03-21.
//

import SwiftUI

struct AuthView: View {
    var textOne: String
    var textTwo: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack{Spacer()}
            Text(textOne)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(textTwo)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .frame(height: 260)
        .padding(.leading)
        .background(Color(.systemBlue))
        .foregroundStyle(.white)
        .clipShape(RounedShape(corners: [.bottomRight]))
    }
}

#Preview {
    AuthView(textOne: "Hello", textTwo: "Welcome Back")
}
