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
    @EnvironmentObject private var userService:UserDataService
    @StateObject private var vm = OtherProfileViewVM()
    @State var otherUser:SearchResultDetails
    
    
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
                        Button {
                            print("Test Edit")
                        } label: {
                            Image(systemName: "pencil")
                                .font(.title.bold())
                                .foregroundStyle(Color("NoirYellow"))
                        }
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .frame (height: 97, alignment: .leading)
                    
                    ProfileBadge(buttonAction: {
                        print("Enter")
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
                    UpcomingEventBadge()
                        .frame(height: 144, alignment: .center)
                        .cornerRadius(24)
                    
                    CalendarBadge(buttonAction: {
                            print("Calendar")
                    })
                    
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
    }
}
