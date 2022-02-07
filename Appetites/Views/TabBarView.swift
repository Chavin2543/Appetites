//
//  TabView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct TabBarView: View {
    
    
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var userService:UserDataService
    
     
    @State var selectedTab:Tab = .home
    
    var body: some View {
            ZStack (alignment:.bottom) {
                Group {
                    switch selectedTab {
                    case .home:
                        HomeView()
                    case .discover:
                        DiscoverView(vm: DiscoverViewVM.init())
                    case .post:
                        HomeView()
                    case .notification:
                        NotificationView()
                    case .profile:
                        ProfileView(vm: ProfileViewVM.init())
                    }
                }.frame(maxWidth:.infinity,maxHeight: .infinity)
                
                
                HStack {
                    ForEach(TabItems) { item in
                        Button {
                            selectedTab = item.tab
                        } label: {
                            Image(systemName: item.logo)
                                .symbolVariant(.fill)
                                .frame(maxWidth:.infinity)
                                .padding(4)
                                .background(
                                    Circle()
                                        .foregroundColor(selectedTab == item.tab ? Color("NoirGreen") : .clear)
                                )
                        }
                        .foregroundStyle(
                            selectedTab == item.tab ?
                            Color.white : Color("NoirGrayL")
                        )
                        .offset(x: 0, y: selectedTab == item.tab ? -20 : 0)
                        .font(
                            selectedTab == item.tab ?
                                .title2.bold() : .body
                        )
                    }
                }
                .frame(height:49)
                .background(Color("NoirGrayD"))
            }
            .fullScreenCover(isPresented: !$userService.isAuthenticated, content: {
                AuthView(vm: AuthViewVM.init())
            })
    }
}

struct TabView_Previews: PreviewProvider {
    
    static var previews: some View {
        TabBarView()
    }
}

prefix func ! (value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}
