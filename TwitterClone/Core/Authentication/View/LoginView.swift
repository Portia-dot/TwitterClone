//
//  Login.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-03-20.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack{
            AuthView(textOne: "Hello", textTwo: "Welcome Back")
            
            VStack(spacing: 40){
                CustomTextFieldView(ImageName: "envelope", placeholderText: "Email", text: $email)
                
                CustomTextFieldView(ImageName: "lock", placeholderText: "Password", isSecureField: true, text: $password)
                
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            HStack{
                Spacer()
                
                NavigationLink{
                    Text("Reset Password View")
                }label: {
                    Text("Forgot Password")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.systemBlue))
                        .padding(.top)
                        .padding(.trailing, 24)
                    
                }
            }
            ButtonReuse(text: "Sign In", action: {
                viewModel.login(withEmail: email, password: password)
            })
            Spacer()
            
            ExtractedViewReuse(primaryText: "Dont have an account?", secondaryText:"Sign Up", destination: RegistrationView())
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

#Preview {
    LoginView()
}


struct ButtonReuse: View {
    var text: String
    var action: () -> Void
    var body: some View {
       
        Button (action: action) {
            Text(text)
                .font(.headline)
                .foregroundStyle(.white)
                .frame(width: 340, height: 50)
                .background(Color(.systemBlue))
                .clipShape(Capsule())
                .padding()
        }
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
    }
}

struct ExtractedViewReuse<Destination:View> : View {
    var primaryText: String
    var secondaryText: String
    var destination: Destination
    var body: some View {
        NavigationLink{
            destination
                .navigationBarHidden(true)
        } label: {
            HStack{
                Text(primaryText)
                    .font(.caption)
                Text(secondaryText)
                    .font(.footnote)
                    .fontWeight(.semibold)
            }
        }
        .padding(.bottom, 32)
        .foregroundStyle(Color(.systemBlue))
    }
}
