//
//  ProfileView.swift
//  TwitterClone
//
//  Created by Modamori Felix Noah on 2024-02-22.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var showingImagePicker = false
    
    
    
   
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            headerView
            HStack{
                UserInfo()
                ProfileButton()
                
            }
            .padding(.top)
            ProfessionalPart()
            ProfileLocAndLink()
            UserStatView(showFull: true)
                .padding(.horizontal)
            TweetFilterBar()
            
            //Tweet Display
            TweetView()
            Spacer()
            
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}


//Extensions

extension ProfileView {

    var headerView: some View {
        //Modify To Allow Modification Of Cover Image
        ZStack(alignment: .bottomLeading, content: {
                    Color.gray
                        .ignoresSafeArea(edges: .top)
                    
            //Profile Picture
            VStack {
                //Back Button
                Button(action: {
                    dismiss()
                    
                }, label: {
                    Image(systemName: "arrow.left")
                        .frame(width: 20, height: 16)
                        .foregroundStyle(.white)
                        .offset(x: 16, y: -20)
                })
                
                if let user = viewModel.currentUser{
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 72, height: 72)
                        .offset(x:16, y: 24)
                }else{
                    Circle()
                        .frame(width: 72, height: 72)
                        .offset(x:16, y: 24)
                    
                }
            }
        })
        .frame(height: 96)
    }
}

//Profile Buttons
struct ProfileButton: View {
    var body: some View {
        HStack(spacing: 12) {
            Spacer()
            //Message Bell
            Image(systemName: "envelope")
                .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
            //Subscribe
            CustomProfileIcon()
            //Edit Profile
            Button {
                
            } label: {
                Text("Edit Profile")
                    .font(.subheadline).bold()
                    .frame(width: 120, height: 32)
                    .foregroundStyle(.black)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
            }
            
        }
        .padding(.trailing)
    }
}

struct UserInfo: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        if let user = viewModel.currentUser{
            VStack(alignment:.leading, spacing: 4){
                HStack{
                    Text(user.fullname)
                        .font(.title2).bold()
                    //Verification Badge
                    
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(Color(.systemYellow))
                }
                Text("@\(user.username)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
            }
            .padding(.horizontal)
        }else{
            VStack(alignment:.leading, spacing: 4){
                HStack{
                    Text("Sample")
                        .font(.title2).bold()
                    //Verification Badge
                    
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(Color(.systemYellow))
                }
                Text("@\("sampleUser")")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
            }
            .padding(.horizontal)
        }
    }
}

struct ProfessionalPart: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        if let user =  viewModel.currentUser{
            VStack(alignment: .leading, spacing: 4) {
                HStack{
                    Image(systemName: "latch.2.case")
                    Text(user.industry)
                        .font(.subheadline).bold()
                        .foregroundStyle(.gray)
                    Spacer()
                    //Location
                    Button {
                        
                    } label: {
                        Image(systemName: "location")
                            .foregroundStyle(.black)
                        Text(user.location)
                    }
                    .font(.subheadline).bold()
                    .foregroundStyle(.gray)
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 2)
        }else{
            VStack(alignment: .leading, spacing: 4) {
                HStack{
                    Image(systemName: "latch.2.case")
                    Text("Industry")
                        .font(.subheadline).bold()
                        .foregroundStyle(.gray)
                    Spacer()
                    //Location
                    Button {
                        
                    } label: {
                        Image(systemName: "location")
                            .foregroundStyle(.black)
                        Text("Location")
                    }
                    .font(.subheadline).bold()
                    .foregroundStyle(.gray)
                    Spacer()
                    
                }
                
                
            }
            .padding(.horizontal)
            .padding(.bottom, 2)
        }
    }
}

struct ProfileLocAndLink: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        if let user = viewModel.currentUser{
            VStack(alignment: .leading, spacing: 4) {
                HStack{
                    Button {
                        
                    } label: {
                        Image(systemName: "link")
                        Text(user.website)
                            .foregroundStyle(.blue)
                    }
                    .font(.subheadline).bold()
                    .foregroundStyle(.black)
                    Spacer()
                    
                    //Join Date
                    Image(systemName: "birthday.cake")
                    Text(user.dateOfBirth)
                        .font(.subheadline).bold()
                        .foregroundStyle(.gray)
                    Spacer()
                    
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 2)
        }else {
            VStack(alignment: .leading, spacing: 4) {
                HStack{
                    Button {
                        
                    } label: {
                        Image(systemName: "link")
                        Text("website")
                            .foregroundStyle(.blue)
                    }
                    .font(.subheadline).bold()
                    .foregroundStyle(.black)
                    
                    Spacer()
                    //Join Date
                    Image(systemName: "birthday.cake")
                    Text("Date Of Birth")
                        .font(.subheadline).bold()
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 2)
        }
    }
}

struct FollowingDisPlay: View {
    var body: some View {
        HStack{
            Text("172")
                .font(.subheadline).bold()
            Text("Following")
                .font(.subheadline).bold()
                .foregroundStyle(.gray)
            Text("11.5M")
                .font(.subheadline).bold()
            Text("Followers")
                .font(.subheadline).bold()
                .foregroundStyle(.gray)
        }
        .padding()
    }
}

struct TweetFilterBar: View {
    @State private var selectedFilter: TweetFilterViewModel = .tweets
    @Namespace var animation
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(TweetFilterViewModel.allCases, id: \.rawValue) { item in
                    VStack {
                        Text(item.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter ==  item ? .semibold : .regular)
                            .foregroundStyle(selectedFilter ==  item ? .black : .gray)
                        
                        //Selected Filter
                        if selectedFilter  == item {
                            Capsule()
                                .foregroundStyle(Color(.systemBlue))
                                .frame(height: 3)
                                .opacity(1)
                                .matchedGeometryEffect(id: "filter", in: animation)
                        } else {
                            Capsule()
                                .foregroundStyle(Color(.systemBlue))
                                .frame(height: 3)
                                .opacity(0)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            self.selectedFilter = item
                        }
                    }
                }
            }
            .overlay(Divider().offset(x:0, y: 13))
        }
        .padding(.horizontal)
    }
}

struct TweetView: View {
    var body: some View {
        ScrollView{
            LazyVStack {
                ForEach(0 ... 9, id: \.self) { _ in
                    TweetRowView()
                }
            }
        }
    }
}
