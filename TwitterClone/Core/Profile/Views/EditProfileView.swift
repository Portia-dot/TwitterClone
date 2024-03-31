//
//  EditProfileView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-03-30.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var detailsViewModel: ProfileDetailsViewModel
//    @State private var bio = ""
//    @State private var industry = ""
//    @State var dateOfBirth = Date()
//    @State private var location = ""
//    @State private var website = ""
    var body: some View {
        VStack(spacing: 40){
            CustomTextFieldView(ImageName: "keyboard", placeholderText: "Bio", text: $detailsViewModel.bio)
            CustomTextFieldView(ImageName: "latch.2.case", placeholderText: "Industry", text: $detailsViewModel.industry)
            CustomTextFieldView(ImageName: "link", placeholderText: "Website", text: $detailsViewModel.website)
            
            CustomTextFieldView(ImageName: "location", placeholderText: "Location", text: $detailsViewModel.location)
            
            
            CustomDatePicker(label: "Date Of Birth", systemImage: "calendar", selectedDate: $detailsViewModel.dateOfBirth)
            
        }
        .padding()
    }
}

#Preview {
    EditProfileView(detailsViewModel: ProfileDetailsViewModel())
}

//struct ProfileSelectorViewExtract: View {
//    var label: String
//    var placeholder: String
//    @Binding var text: String
//    var body: some View {
//        HStack{
//            Text("\(label):")
//            TextField(placeholder, text: $text)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//        }
//    }
//}
