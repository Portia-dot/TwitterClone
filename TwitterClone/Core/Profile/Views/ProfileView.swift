//
//  ProfileView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-22.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(alignment: .leading){
            headerView
            ProfileButton()
            UserInfo()
            ProfessionalPart()
            ProfileLocAndLink()
            UserStatView()
                .padding(.horizontal)
            TweetFilterBar()
            
            //Tweet Display
            TweetView()
            Spacer()
            
        }
    }
}

#Preview {
    ProfileView()
}


//Extensions

extension ProfileView {
    var headerView: some View {
        ZStack(alignment: .bottomLeading, content: {
            Color(.systemBlue)
                .ignoresSafeArea()
            
            //Profile Picture
            VStack {
                //Back Button
                Button(action: {
                    dismiss()
                    
                }, label: {
                    Image(systemName: "arrow.left")
                        .frame(width: 20, height: 16)
                        .foregroundStyle(.white)
                        .offset(x: 16, y: 12)
                })
                
                Circle()
                    .frame(width: 72, height: 72)
                .offset(x:16, y: 24)
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
    var body: some View {
        VStack(alignment:.leading, spacing: 4){
            HStack{
                Text("Bruce Lee")
                    .font(.title2).bold()
                //Verification Badge
                
                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(Color(.systemYellow))
            }
            Text("@brucelee")
                .font(.subheadline)
                .foregroundStyle(.gray)
            
            //Bio
            
            Text("Your Favorite")
                .font(.subheadline).bold()
                .padding(.vertical)
        }
        .padding(.horizontal)
    }
}

struct ProfessionalPart: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack{
                Image(systemName: "latch.2.case")
                Text("Entertainment & Recreation")
                    .font(.subheadline).bold()
                    .foregroundStyle(.gray)
                Spacer()
                
                //Location
                Button {
                    
                } label: {
                    Image(systemName: "location")
                    Text("Germany")
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

struct ProfileLocAndLink: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack{
                Button {
                    
                } label: {
                    Image(systemName: "link")
                    Text("kick.com")
                        .foregroundStyle(.blue)
                }
                .font(.subheadline).bold()
                .foregroundStyle(.gray)
                Spacer()
                
                //Join Date
                Image(systemName: "calendar")
                Text("Joined August 2023")
                    .font(.subheadline).bold()
                    .foregroundStyle(.gray)
                Spacer()
                
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 2)
    }
}

//struct FollowingDisPlay: View {
//    var body: some View {
//        HStack{
//            Text("172")
//                .font(.subheadline).bold()
//            Text("Following")
//                .font(.subheadline).bold()
//                .foregroundStyle(.gray)
//            Text("11.5M")
//                .font(.subheadline).bold()
//            Text("Followers")
//                .font(.subheadline).bold()
//                .foregroundStyle(.gray)
//        }
//        .padding()
//    }
//}

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
