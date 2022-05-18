//
//  ProfileView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

public enum FollowMode {
    case follower
    case following
}

struct ProfileView: View {
    
    @StateObject var vm = ProfileViewVM()
    @EnvironmentObject private var userService:UserDataService
    @State private var isAnimating:Bool = false
    @State private var isViewingFollower:Bool = false
    @State private var mode:FollowMode = .follower
    
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
                        isViewingFollower.toggle()
                    }, loading: .constant(false), profilePic: $userService.user.profilePictureLink,follower: $userService.user.follower,following: $userService.user.following)
                    .frame(height: 145, alignment: .center)
                    .opacity(isAnimating ? 1 : 0)
                    
                    VStack (spacing:34){
                        VStack {
                            UpcomingEventBadge(latestEvent: $vm.event.events.first ?? .constant(EventDetail(eventID: 0, eventLocation: "", eventTitle: "No Events", eventDescription: "", eventDate: "", userEmail: "", isCreator: false, eventMembers: [])))
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
            .sheet(isPresented: $isViewingFollower, content: {
                ZStack {
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                withAnimation {
                                    mode = .follower
                                }
                            } label: {
                                Text("Follower")
                                    .fontWeight(mode == .follower ? .bold : .none)
                                    .font(.body)
                                    .foregroundColor(mode == .follower ? Color("NoirGreen") : .white)
                            }
                            Spacer()
                            Button {
                                withAnimation {
                                    mode = .following
                                }
                            } label: {
                                Text("Followings")
                                    .fontWeight(mode == .following ? .bold : .none)
                                    .font(.body)
                                    .foregroundColor(mode == .following ? Color("NoirGreen") : .white)
                            }
                            Spacer()
                        }
                        .padding(.top,40)
                        if mode == .follower {
                            VStack (spacing:20) {
                                ForEach(userService.user.followerDetails ?? []) { follower in
                                    HStack {
                                        VStack {
                                            HStack {
                                                Text(follower.followerUsername)
                                                    .font(.body.bold())
                                                    .foregroundColor(Color("NoirGreen"))
                                                Spacer()
                                            }
                                            HStack {
                                                Text(follower.followerEmail)
                                                    .foregroundColor(.white)
                                                Spacer()
                                            }
                                        }
                                        Spacer()
                                        WebImage(url: URL(string: "https://images.pexels.com/photos/8059137/pexels-photo-8059137.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 40, height: 40, alignment: .center)
                                            .cornerRadius(40)
                                    }
                                }
                            }
                            .padding(.top,30)
                        } else {
                            VStack (spacing:20) {
                                ForEach(userService.user.followingDetails ?? []) { follower in
                                    HStack {
                                        VStack {
                                            HStack {
                                                Text(follower.followedUsername)
                                                    .font(.body.bold())
                                                    .foregroundColor(Color("NoirGreen"))
                                                Spacer()
                                            }
                                            HStack {
                                                Text(follower.followedEmail)
                                                    .foregroundColor(.white)
                                                Spacer()
                                            }
                                        }
                                        Spacer()
                                        WebImage(url: URL(string: "https://images.pexels.com/photos/8059137/pexels-photo-8059137.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 40, height: 40, alignment: .center)
                                            .cornerRadius(40)
                                    }
                                }
                            }
                            .padding(.top,30)
                        }
                        Spacer()
                    }
                    .padding(.horizontal,32)
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity)
                .background(Color("NoirBG"))
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
