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
                VStack (spacing:28) {
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
                    .frame (
                        width: geometry.size.width-64,
                        height: 97,
                    alignment: .leading)
                    
                    ProfileBadge(buttonAction: {
                        print("HEllO")
                    }, profilePic: $userService.user.profilePictureLink,follower: $userService.user.follower,following: $userService.user.following)
                    .frame(width: geometry.size.width-64, height: 145, alignment: .center)
                    
                    CalendarBadge(buttonAction: {
                        vm.inCalendar = true
                    }, registerDate: $userService.user.registerDate)
                        .frame(width:geometry.size.width-32)
                    Spacer()
                }
            }
            .fullScreenCover(isPresented: $vm.inSettings, content: {
                SettingView(vm: SettingViewVM.init())
            })
            .fullScreenCover(isPresented: $vm.inCalendar, content: {
                CalendarView()
            })
            .frame(maxWidth:.infinity)
            .background(
                ZStack {
                    Color(
                        "NoirBG"
                    )
                    ProfileBlob()
                }

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
        ProfileView(vm: ProfileViewVM.init()).environmentObject(UserDataService())
    }
}
