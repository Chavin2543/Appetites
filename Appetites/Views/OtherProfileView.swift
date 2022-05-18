//l
//  OtherProfileView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 7/2/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct OtherProfileView: View {
    
    //MARK: - Properties
    var items: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @Environment(\.presentationMode) private var presentationMode
    @State private var isViewingFollower:Bool = false
    @EnvironmentObject private var userService:UserDataService
    @StateObject private var vm = OtherProfileViewVM()
    @State var otherUser:SearchResultDetails
    @State private var mode:FollowMode = .follower
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView (showsIndicators:false){
                VStack (spacing:16) {
                    
                    //MARK: - Header
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title)
                        }

                        Text(otherUser.username)
                            .font(.title.bold())
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .frame (height: 97, alignment: .leading)
                    
                    ProfileBadge(buttonAction: {
                        isViewingFollower.toggle()
                    }, loading: $vm.isLoading, profilePic:$otherUser.profilePictureLink, follower: $vm.user.follower, following: $vm.user.following)
                    
                    if userService.user.username != vm.dataFromSearch.username {
                        LongButton(title:vm.isFollowing ? .constant("Unfollow") : .constant("Follow"), color:vm.isFollowing ? .constant("NoirGrayL") : .constant("NoirGreen")) {
                            if vm.isFollowing {
                                vm.unfollow(token: userService.token, email:otherUser.email )
                            } else {
                                vm.follow(token: userService.token, email: otherUser.email)
                            }
                        }
                    }
                    
                    
                    //MARK: - Hero Section
                    UpcomingEventBadge(latestEvent: .constant(EventDetail(eventID: 0, eventLocation: "Under Construction", eventTitle: "Going to Dinner", eventDescription: "At Sathorn", eventDate: "20 May 2021", userEmail: "rungallday@email.com", isCreator: false, eventMembers: [])))
                        .frame(height: 144, alignment: .center)
                        .cornerRadius(24)
                    
//                    CalendarBadge(buttonAction: {
//                            print("Calendar")
//                    })
//                    
                    //MARK: - Post Grid
                    
                    LazyVGrid(columns: items, alignment: .center, spacing: 4) {
                        ForEach(vm.userPosts.posts) { item in
                            NavigationLink(destination: PostDetailsView(post: item,user: userService.user)) {
                                WebImage(url: URL(string: item.photoLinksList?.first ?? "https://images.pexels.com/photos/11012766/pexels-photo-11012766.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width*0.27,height: geometry.size.width*0.27)
                                    .clipped()
                            }
                        }
                    }
                }
                .frame(width:geometry.size.width-64)
            }
            .navigationBarHidden(true)
            .preferredColorScheme(.dark)
            .frame(maxWidth:.infinity)
            .background(
                ZStack {Color("NoirBG")}
                    .ignoresSafeArea()
            )
            //MARK: - Lifecycle
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
                                ForEach(vm.user.followerDetails ?? []) { follower in
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
                                ForEach(vm.user.followingDetails ?? []) { follower in
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
            .onAppear {
                vm.getFollower(token: userService.token, email: otherUser.email)
                vm.getUserPosts(token: userService.token, otherEmail: otherUser.email, limit: "100", offset: "0")
            }
        }
    }
}

struct OtherProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OtherProfileView(otherUser: SearchResultDetails(username: "", email: "", profilePictureLink: ""))
            .environmentObject(UserDataService())
    }
}
