//
//  SideMenuView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-23.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    @Environment(\.appColorScheme) var appColorScheme
    @EnvironmentObject var viewModel: AuthViewModel
    var imageWidth: CGFloat = 24
    var body: some View {
        if let user = viewModel.currentUser{
            VStack (alignment: .leading, spacing: 10) {
                VStack(alignment: .leading) {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 48, height: 48)
                    
                    VStack(alignment: .leading, spacing: 4){
                        HStack{
                            Text(user.fullname)
                                .font(.headline)
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundStyle(Color(.systemYellow))
                        }
                        Text("@\(user.username)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    UserStatView()
                   
                }
                .padding(.leading)
                //Bars
                
                ForEach(SideMenuViewModel.allCases, id: \.rawValue){ option in
                        HStack(spacing: 16) {
                            Image(systemName: option.imageName)
                                .frame(width: imageWidth, alignment: .center)
                                .font(.title2)
                                .foregroundStyle(.black)

                            if option == .logout {
                                Button(action: {
                                    viewModel.logout()
                                }) {
                                    Text(option.description)
                                        .font(.title2).bold()
                                        .foregroundStyle(.black)
                                }
                                Spacer()
                            } else if option == .profile {
                                NavigationLink {
                                    ProfileView()
                                } label: {
                                    Text(option.description)
                                        .font(.title2).bold()
                                        .foregroundStyle(.black)
                                }
                                Spacer()

                                if option == .getPremium {
                                    Text("New")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .padding(5)
                                        .background(Color.blue)
                                        .clipShape(RoundedRectangle(cornerRadius: 4))
                                }
                            } else {
                                Text(option.description)
                                    .font(.title2).bold()
                                    .foregroundStyle(.black)
                                Spacer()
                                
                                if option == .getPremium {
                                    Text("New")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .padding(5)
                                        .background(Color.blue)
                                        .clipShape(RoundedRectangle(cornerRadius: 4))
                                }
                            }
                        }
                        .frame(height: 40)
                        .padding(.horizontal)

                }
                .padding(.vertical, 4)
                Divider()
                //Setting and Supports
                SettingAndPrivacy()
                
                Spacer()
                darkAndLightMode()
                    .padding(.horizontal)
                    .padding(.bottom, 3)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(Color.white)
            .preferredColorScheme(appColorScheme)
           
            
            Spacer()

        }

    }
}

#Preview {
    SideMenuView()
}

struct SettingAndPrivacy: View {
    @State private var isExpanded: Bool = false
    var body: some View {
        HStack(spacing: 16){
            Text("Setting and Support")
                .font(.title3).bold()
            
            Button(action: {
                withAnimation{
                    isExpanded.toggle()
                }
            }, label: {
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
            })
        }
        .padding(.horizontal, 6)
        
        if isExpanded {
            VStack(spacing: 16){
                settingOptions(imageName: "gear", text: "Setting and Privacy")
                settingOptions(imageName: "questionmark.circle", text: "Help Center")
                settingOptions(imageName: "cart", text: "Purchases")
            }
        }
    
        
    }
}

struct settingOptions: View {
    let imageName: String
    let text: String
    
    var body: some View {
        HStack(spacing: 16){
            Image(systemName: imageName)
            .frame(width: 24, alignment: .center)
            .font(.title3).bold()
            .foregroundStyle(.black)
            
            Text(text)
                .font(.title3).bold()
                .foregroundStyle(.black)
            Spacer()
        }.padding(.horizontal)
    }
}

struct darkAndLightMode: View {
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled: Bool = false
    var body: some View {
        Button(action: {
            withAnimation {
                isDarkModeEnabled.toggle()
            }
        }, label: {
            Image(systemName: isDarkModeEnabled ? "moon.fill" : "sun.max.fill")
                .frame(width: 24, alignment: .center)
                .font(.title3).bold()
                .foregroundStyle(.black)
        })
      
        
        
    }
}

//Dark Mode

private struct AppColorSchemeKey: EnvironmentKey {
    static let defaultValue: ColorScheme? = nil
}

extension EnvironmentValues {
    var appColorScheme: ColorScheme? {
        get{ self[AppColorSchemeKey.self]}
        set{self[AppColorSchemeKey.self] =  newValue}
    }
}
