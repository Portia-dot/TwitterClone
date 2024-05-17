//
//  ProfileView.swift
//  TwitterClone
//
//  Created by Modamori Felix Noah on 2024-02-22.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    let user: User
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var showingImagePicker = false

    
   
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            headerView
            HStack{
                UserInfo(user: user)
                ProfileButton(user: user)
                
            }
            .padding(.top)
            UserAndProfessionalDetailsView(user: user)
            UserStatView(showFull: true)
                .padding(.horizontal)
            TweetFilterBar()
            
            //Tweet Display
            TweetView(user: user)

        }
        .navigationBarBackButtonHidden()
    }
}
//
//#Preview {
//    ProfileView()
//        .environmentObject(AuthViewModel())
//}


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
                        .offset(x: 16, y: -4)
                })
                
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 72, height: 72)
                        .offset(x:16, y: 24)
            }
        })
        .frame(height: 100)
    }
}

//Profile Buttons
struct ProfileButton: View {
    let user: User
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        HStack(spacing: 4) {
            Spacer()
            //Message Bell
            Image(systemName: "envelope")
                .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
            //Subscribe
            CustomProfileIcon()
            //Conditional Edit Profile
            Spacer()
            if viewModel.currentUser? .id == user.id {
                editProfileButton
            }
            
            Spacer()

            
        }
        .padding(.trailing)
    }
}

struct UserInfo: View {
    let user: User
    var body: some View {
            VStack(alignment:.leading, spacing: 4){
                HStack{
                    Text(user.fullname)
                        .font(.title2).bold()
                        .lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                        .font(user.fullname.count > 20 ? .headline : .title2)
                    //Verification Badge
                    
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(Color(.systemYellow))
                }
                Text("@\(user.username)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
            }
            .padding(.horizontal)
    }
}

struct UserAndProfessionalDetailsView: View {
    let user: User
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10){
                VStack(alignment: .leading, content: {
                    HStack{
                        Image(systemName: "latch.2.case")
                            .foregroundStyle(.gray)
                        Text(user.industry)
                            .font(.caption).bold()
                            .foregroundStyle(.gray)
                    }
                    
                    HStack{
                        Image(systemName: "link")
                            .foregroundStyle(.gray)
                        Text(user.website)
                            .foregroundStyle(.blue)
                            .font(.caption).bold()
                    }
                    
                })
                Spacer()
                VStack(alignment: .leading, content: {
                    HStack{
                        Image(systemName: "location")
                            .foregroundStyle(.gray)
                        Text(user.location)
                            .font(.caption).bold()
                            .foregroundStyle(.gray)
                    }
                    
                    HStack{
                        Image(systemName: "birthday.cake")
                            .foregroundStyle(.gray)
                        Text(user.dateOfBirth)
                            .foregroundStyle(.gray)
                            .font(.caption).bold()
                    }
                    
                })
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 2)
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
    @EnvironmentObject var viewModel : AuthViewModel
    

    var user: User
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(viewModel.tweets, id: \.id) { tweet in
                    TweetRowView(post: tweet)
                }
            }
        }
        .onAppear(perform: {
            viewModel.fetchTweets(for: user.id)
        })
    }
}

var editProfileButton: some View{
    Button {
        
    } label: {
        Text("Edit Profile")
            .font(.subheadline).bold()
            .frame(width: 90, height: 32)
            .foregroundStyle(.black)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
    }
}
