//
//  CustomTextFieldView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-03-21.
//

import SwiftUI

struct CustomTextFieldView: View {
    let ImageName: String
    let placeholderText: String
    var isSecureField: Bool? = false
    @State private var isPasswordVisible: Bool = false
    @Binding var text: String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: ImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color(.darkGray))
                
                if isSecureField ?? false && !isPasswordVisible {
                    SecureField(placeholderText, text: $text)
                }else {
                    TextField(placeholderText, text: $text)
                }
                
                if isSecureField ?? false {
                    Button {
                        withAnimation {
                            isPasswordVisible.toggle()
                        }
                    } label: {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundStyle(.gray)
                    }

                }
                
            }
            Divider()
                .background(Color(.darkGray))
        }
    }
}

#Preview {
    CustomTextFieldView(ImageName: "envelope", placeholderText: "E-Mail", isSecureField: false, text: .constant(""))
}
