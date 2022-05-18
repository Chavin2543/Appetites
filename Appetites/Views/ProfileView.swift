//
//  ProfileView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI
import SDWebImage

struct ProfileView: View {
    
    @StateObject var vm = ProfileViewVM()
    @EnvironmentObject private var userService:UserDataService
    @State private var isAnimating:Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators:false) {
                VStack (spacing:16) {
                    HStack {
                        Text(userService.user.username ?? "Anonymous")
                            .font(.title.bold())
                        Button {
                            vm.isEditingProfile.toggle()
                        } label: {
                            Image(systemName: "pencil")
                                .font(.title.bold())
                                .foregroundStyle(Color("NoirYellow"))
                        }
                        Spacer()
                        
                        Button {
                            userService.getUser()
                        } label: {
                            Image(systemName: "rays")
                        }
                        
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
                    .frame (width:geometry.size.width-64,height: 97, alignment: .leading)
                    
                    ProfileBadge(buttonAction: {
                        print("HEllO")
                    }, loading: .constant(false), profilePic: $userService.user.profilePictureLink,follower: $userService.user.follower,following: $userService.user.following)
                    .frame(height: 145, alignment: .center)
                    .opacity(isAnimating ? 1 : 0)
                    
                    VStack (spacing:34){
                        VStack {
                            UpcomingEventBadge(latestEvent: vm.event.events.first ?? EventDetail(eventID: 0, eventLocation: "UnderConstruction", eventTitle: "No Upcoming Event", eventDescription: "", eventDate: "", userEmail: "temo", isCreator: false, eventMembers: []))
                                .frame(height: 144, alignment: .center)
                                .cornerRadius(24)
                            .offset(x: isAnimating ? 0 : -geometry.size.width, y: 0)
                        }
                        .frame(width:geometry.size.width-64)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 4, y: 4)
                        .shadow(color: .gray.opacity(0.1), radius: 1, x: -4, y: -4)
                        VStack (spacing:24) {
                            CalendarBadge {
                                vm.inCalendar.toggle()
                            }
                            PostBadge(postCount:vm.personalPost.postCount) {
                                vm.inPost.toggle()
                            }
                        }
                        .frame(width:geometry.size.width-64)
                        
                        Color.clear
                            .frame(height:300)
                    }
                    Spacer()
                }
                .frame(width:geometry.size.width)
            }
            .fullScreenCover(isPresented: $vm.inSettings, content: {
                SettingView(vm: SettingViewVM.init(), user:userService.user)
            })
            .fullScreenCover(isPresented: $vm.inCalendar, content: {
                CalendarView()
            })
            .fullScreenCover(isPresented: $vm.inPost, content: {
                PersonalPostView(post: vm.personalPost)
            })
            .fullScreenCover(isPresented: $vm.isEditingProfile, content: {
                InfoFillView(user: userService.user)
            })
            .frame(maxWidth:.infinity)
            .background(
                ZStack {Color("NoirBG")}
                    .ignoresSafeArea()
            )
        }
        .onAppear {
            withAnimation(.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0.4)) {
                vm.getPersonalPost(token: userService.token)
                vm.getEvent(token: userService.token, month: "5", year: "2022")
                isAnimating.toggle()
                userService.getUser()
            }
        }
        .onDisappear {
            isAnimating.toggle()
            SDImageCache.shared.clear(with: .all)
            
        }

    }
}

struct ProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileView(vm: ProfileViewVM.init())
            .environmentObject(UserDataService())
    }
}
