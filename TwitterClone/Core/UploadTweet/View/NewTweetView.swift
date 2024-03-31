//
//  NewTweetView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-03-12.
//

import SwiftUI

struct NewTweetView: View {
    @State private var caption = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                            .foregroundColor(Color.blue)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("Tweet")
                    }) {
                        Text("Tweet")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .clipShape(Capsule())
                    }
                }
                .padding()
                
                HStack(alignment: .top) {
                    Circle()
                        .frame(width: 64, height: 64)
//                        .foregroundColor(Color.gray.opacity(0.5))
                    
                    TextArea("What's happening?", text: $caption)
                        .frame(minHeight: 100)
                        .bold()
                }
                .padding()
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}


#Preview {
    NewTweetView()
}
