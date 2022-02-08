//
//  ProfileView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var vm:ProfileViewVM
    @EnvironmentObject private var userService:UserDataService
    
    @State private var isAnimating:Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack (spacing:16) {
                    HStack {
                        Text(userService.user.username ?? "Anonymous")
                            .font(.title.bold())
                        Button {
                            print("Test Edit")
                        } label: {
                            Image(systemName: "pencil")
                                .font(.title.bold())
                                .foregroundStyle(Color("NoirYellow"))
                        }
                        Spacer()
                        Button {
                            vm.inSettings = true
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }
                    }
                    .offset (
                        x: 0,
                        y: isAnimating ? 0 : -100
                    )
                    .foregroundColor(.white)
                    .frame (height: 97, alignment: .leading)
                    
                    ProfileBadge(buttonAction: {
                        print("HEllO")
                    }, profilePic: $userService.user.profilePictureLink,follower: $userService.user.follower,following: $userService.user.following)
                    .frame(height: 145, alignment: .center)
                    .opacity(isAnimating ? 1 : 0)
                    
                    UpcomingEventBadge()
                        .frame(height: 144, alignment: .center)
                        .cornerRadius(44)
                    
                    HStack (spacing:28) {
                        CalendarBadge(buttonAction: {
                            vm.inCalendar = true
                        })
                            .offset(x: isAnimating ? 0 : -geometry.size.width, y: 0)
                        CalendarBadge(buttonAction: {
                            vm.inCalendar = true
                        })
                            .offset(x: isAnimating ? 0 : -geometry.size.width, y: 0)
                    }
                    Spacer()
                }
                .frame(width:geometry.size.width-64)
            }
            .fullScreenCover(isPresented: $vm.inSettings, content: {
                SettingView(vm: SettingViewVM.init(), user:userService.user)
            })
            .fullScreenCover(isPresented: $vm.inCalendar, content: {
                CalendarView()
            })
            .frame(maxWidth:.infinity)
            .background(
                ZStack {Color("NoirBG")}
                    .ignoresSafeArea()
            )
        }
        .onAppear {
            withAnimation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0.4)) {
                isAnimating.toggle()
            }
        }
        .onDisappear {
            isAnimating.toggle()
        }

    }
}

struct ProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileView(vm: ProfileViewVM.init())
            .environmentObject(UserDataService())
    }
}
