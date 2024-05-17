//
//  ContentView.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-02-21.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
            } else {
              MainInterFaceView()

            }
        }
        .alert("Logged Out", isPresented: $viewModel.showLogOutAlert) {
            Button("Ok", role: .cancel) {}
        } message: {
            Text("You have been logged out because your account no longer exists")
        }
    }
}
#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}


struct ConditionalToolbarModifier: ViewModifier {
    @Binding var isHidden: Bool
    
    func body(content: Content) -> some View {
        if isHidden {
            content
                .toolbar(.hidden, for: .navigationBar)
        } else {
            content
        }
    }
}

extension View {
    func conditionalToolbarHidden(_ isHidden: Binding<Bool>) -> some View {
        modifier(ConditionalToolbarModifier(isHidden: isHidden))
    }
}

struct MainInterFaceView: View {
    
    @State var showMenu: Bool = false
    @State var showSidebarToggle: Bool = true
    @AppStorage("isDarkModeEnabled") var isDarkModeEnabled:  Bool = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var dragOffset : CGFloat = 0
    var body: some View {
        ZStack(alignment: .topLeading){
            MainTabView(showSidebarToggle: $showSidebarToggle)
                .conditionalToolbarHidden($showMenu)
            
            if showMenu && showSidebarToggle {
                ZStack {
                    Color.black.opacity(showMenu ? 0.25 : 0.0)
                }.onTapGesture {
                    withAnimation(.easeInOut){
                        showMenu = false
                    }
                }
                .ignoresSafeArea()
            }
            SideMenuView()
                .frame(width: 300)
                .offset(x: showMenu ? max(0, dragOffset - 300) : -300, y: 0)
                .animation(.default, value: showMenu)
                .gesture (
                    DragGesture()
                        .onChanged { value in
                            if value.translation.width < 0 {
                                dragOffset = value.translation.width
                            }
                        }
                        .onEnded({ value in
                            if value.translation.width < -100 {
                                withAnimation(.easeInOut){
                                    showMenu = false
                                }
                            }
                            dragOffset = 0
                        }
                                )
                )
            
        }
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                if showSidebarToggle && viewModel.currentUser != nil {
                    Button(action: {
                        withAnimation(.easeInOut){
                            showMenu.toggle()
                        }
                    }, label: {
                        KFImage(URL(string: viewModel.currentUser!.profileImageUrl))
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 32, height: 32)
                    })
                }
            }
        }
        .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
        .onAppear{
            showMenu = false
        }
    }
}
