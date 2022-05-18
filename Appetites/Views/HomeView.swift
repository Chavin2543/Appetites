//
//  HomeVIew.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: - Properties
    @EnvironmentObject private var userService:UserDataService
    @AppStorage("isFirstTime") var isFirstTime:Bool = true
    @State private var isAnimating:Bool = false
    @StateObject private var vm = HomeViewVM()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                
                //MARK: - Header
                ScrollView(showsIndicators:false) {
                    VStack {
                        HStack {
                            Text("Your Feed")
                                .font(.largeTitle.bold())
                            Spacer()
                            Button {
                                vm.getPosts(token: userService.token, limit: "40", offset: "0")
                            } label: {
                                Image(systemName: "arrow.down")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 12, height: 12, alignment: .center)
                                    .foregroundColor(.white)
                            }

                        }
                        .foregroundColor(.white)
                        .frame (
                            width: geometry.size.width-64,
                            height: 97,
                            alignment: .leading)
                        
                        //MARK: - Feed
                        
                        VStack (spacing:25) {
                            ForEach(vm.feedPosts.posts) { post in
                                NavigationLink(destination: PostDetailsView(post: post)) {
                                    Post(likeButtonAction: {
                                        vm.likePosts(token: userService.token, postID: "\(post.postID)")
                                    }, commentButtonAction: {
                                        vm.unlikePosts(token: userService.token, postID: "\(post.postID)")
                                    },post: post,profilePicURL:userService.user.profilePictureLink )
                                        .padding(.horizontal,16)
                                }
                            }
                        }
                        
                        //MARK: - Footer
                        
                        VStack (spacing:10) {
                            Text("That's all from your friends")
                                .font(.system(size: 20).bold())
                            Text("Discover more in the DiscoverTab")
                                .font(.system(size:12))
                                .fontWeight(.light)
                        }
                        .padding(.vertical,40)
                        .foregroundColor(.white)
                        
                        Color.clear.frame(height:100)
                        
                        Spacer()
                    }
                }
                .frame(maxWidth:.infinity)
            .background(Color("NoirBG"))
            .navigationBarHidden(true)
            .onAppear {
                vm.getPosts(token: userService.token, limit:"1000", offset: "0")
            }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(PostDataService())
    }
}
