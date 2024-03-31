//
//  RegistrationView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-03-20.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var userName = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var isLoading = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            VStack{
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(1.5)
                }else{
                    content
                }
            }
            .ignoresSafeArea()
            .navigationDestination(isPresented: $viewModel.didAuthenticateUser) {
                ProfileSelectorView()
            }
        }
        
    }
    @ViewBuilder
    private var content : some View {
                AuthView(textOne: "Get Started.", textTwo: "Create your account")
                
                VStack(spacing: 40){
                    CustomTextFieldView(ImageName: "envelope", placeholderText: "Email", text: $email)
                    
                    CustomTextFieldView(ImageName: "person", placeholderText: "UserName", text: $userName)
                    
                    CustomTextFieldView(ImageName: "person", placeholderText: "Full Name", text: $fullName)
                    
                    CustomTextFieldView(ImageName: "lock", placeholderText: "Password", isSecureField: true, text: $password)
                }
                .padding(32)
                
                ButtonReuse(text: "Sign Up") {
                    viewModel.register(withEmail: email, password: password, fullname: fullName, username: userName){
                        isLoading = false
                    }
                }
                
                Button(action: {
                    dismiss()
                }, label: {
                    HStack{
                        Text("Already have an account ?")
                            .font(.footnote)
                        Text("Sign In")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                })
                
                Spacer()
                
    
        }

}

#Preview {
    RegistrationView()
        .environmentObject(AuthViewModel())
}
