//
//  ProfileSelectorView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-03-28.
//

import SwiftUI

struct ProfileSelectorView: View {
    @State private var showImagePicker = false
    @State private var imageSelected: UIImage?
    @State private var profileImage: Image?
    @StateObject var detailsViewModel = ProfileDetailsViewModel()

    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        ScrollView {
            VStack{
                AuthView(textOne: "Create", textTwo: "Your profile Details")
                Button{
                    showImagePicker.toggle()
                } label: {
                    ZStack{
                        Circle()
                            .stroke(lineWidth: 3)
                            .foregroundStyle(Color(.systemBlue))
                            .frame(width: 180, height: 180)
                        
                        if let profileImage = profileImage {
                            profileImage
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color(.systemBlue))
                                .clipShape(Circle())
                        }else{
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(Color(.systemBlue))
                            
                               
                            Text("Profile Picture")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .offset(y: 30)
                        }
                    }
                    .sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
                        ImagePicker(selectedImage: $imageSelected)
                    })
                    .padding()
                }
                //Profile Details Edits
                
                EditProfileView(detailsViewModel: detailsViewModel)
                
                //Submit Button
                if let imageSelected = imageSelected {
                    ButtonReuse(text: "Continue") {
                        guard let uid = viewModel.tempUserSession?.uid else {
                            print("UID is not avaliable")
                            return
                        }
                        viewModel.uploadProfileImage(imageSelected)
                        print("\(String(describing: viewModel.tempUserSession?.uid))")
                        viewModel.updateUserDetails(uid: uid, bio: detailsViewModel.bio, industry: detailsViewModel.industry, location: detailsViewModel.location, website: detailsViewModel.website, dateOfBirth: detailsViewModel.dateOfBirth) { success in
                            if success{
                                
                            }else {
                                
                            }
                        }
                    }
                }
            }
            
        }
        .ignoresSafeArea()
    }
    func loadImage(){
        guard let selectedImage = imageSelected else {return}
        profileImage = Image(uiImage: selectedImage)
    }
}

#Preview {
    ProfileSelectorView()
}
