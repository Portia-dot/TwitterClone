//
//  SearchView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-22.
//

import SwiftUI

struct SearchView: View {
    @State  var searchText = ""
    @State private var isSearching =  true
    @State private var selectedFilter: SearchFilterViewModel = .forYou
    @ObservedObject var viewModel = ExploreViewModel()
    
     
    
    var filterUsers: [User]{
        if searchText.isEmpty{
            return viewModel.users
        }else{
            return viewModel.users.filter{ user in
                user.fullname.lowercased().contains(searchText.lowercased()) || user.username.lowercased().contains(searchText.lowercased())
            }
                                          
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                //Search Bar, Profile and Setting
                topBar
                
                //Check if search is active
                if searchText.isEmpty {
                    //Filter Bar
                    searchFilterBar()
                    //Trending
                    mainContent
                    Spacer()
                } else {
                    searchResults
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    
    var topBar: some View {
        HStack {
//            Image(systemName: "person")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 20, height: 20)
//                .padding(.all, 5)
//                .clipShape(Circle())
//                .overlay(Circle().stroke(lineWidth: 1.0))
//            Spacer()
            //Search Bar
            HStack {
                TextField("Search", text: $searchText)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .overlay(
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .bold()
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            
                            if isSearching {
                                Button {
                                    isSearching = false
                                    searchText = ""
                                    hideKeyboard()
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(.gray)
                                        .padding(.trailing, 8)
        
                                }

                            }
                        }
                    )
                    .onTapGesture {
                        isSearching = true
                    }
                    .transition(.move(edge: .trailing))
                    .animation(.default, value: isSearching)
            }
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "gear")
                    .foregroundStyle(.gray)
                    .font(.title)
            }

        }
        .padding()
    }
    struct searchFilterBar: View {
        @State private var selectedFilter: SearchFilterViewModel = .forYou
        @Namespace var animation
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(SearchFilterViewModel.allCases, id: \.rawValue) { item in
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
    var mainContent: some View {
        ScrollView{
            LazyVStack {
                ForEach(0 ... 9, id: \.self) { _ in
                    Trending(title: "Wizkid", category: "Music . Entertainment", posts: "2M posts")
                }
            }
        }
    }
    
    var searchResults: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(filterUsers) { user in
                        NavigationLink {ProfileView(user: user)}
                    label:{
                            UserSearchRow(user: user)
                                }
                        }
                    }
            }
        }
        .navigationTitle("Explore")
        .navigationBarTitleDisplayMode(.inline)
        
        }
    }


#Preview {
    SearchView()
        .environmentObject(AuthViewModel())
}


#if canImport(UIKit)
extension View {
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
