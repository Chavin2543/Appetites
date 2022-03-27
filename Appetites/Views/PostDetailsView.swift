//
//  PostDetailsView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 27/3/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostDetailsView: View {
    @State private var isViewingFullPic:Bool = false
    @StateObject private var vm:PostDetailsVM = PostDetailsVM()
    @EnvironmentObject private var userService:UserDataService
    @EnvironmentObject private var postService:PostDataService
    @State private var comment:String = ""
    var post:PostDetails
    var user:LocalUserInfo?
    var body: some View {
        GeometryReader { geometry in
            if user == nil {
                ZStack {
                    VStack (spacing: 0 ) {
                        Button {
                            isViewingFullPic.toggle()
                        } label: {
                            WebImage(url: URL(string: vm.postDetails.photoLinksList?.first ?? "https://images.unsplash.com/photo-1607434472257-d9f8e57a643d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1772&q=80"))
                                .resizable()
                                .scaledToFill()
                                .frame(height:geometry.size.height * 0.5)
                                .cornerRadius(44)
                        }
                        VStack (alignment:.leading) {
                            HStack {
                                WebImage(url: URL(string: post.profilePictureLink ?? "https://images.unsplash.com/photo-1607434472257-d9f8e57a643d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1772&q=80"))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32, alignment: .center)
                                    .cornerRadius(16)
                                Text("\(post.username ?? "Can't Retrieve")")
                                    .font(.body.bold())
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            Text("\(vm.postDetails.postCaption ?? "Can't Retrieve")")
                                .font(.caption)
                                .foregroundColor(Color("NoirGrayL"))
                                .fontWeight(.light)
                        }
                        .frame(height:geometry.size.height * 0.15)
                        .padding(.horizontal,16)

                        ScrollView(showsIndicators:false) {
                            VStack {
                                ForEach(vm.postDetails.comments!, id:\.id) { comment in
                                    Comment(comments: comment)
                                        .padding(.vertical,8)
                                        .frame(width:geometry.size.width-32)
                                }
                                HStack {
                                    HStack {
                                        WebImage(url: URL(string: post.profilePictureLink ?? ""))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 24, height: 24, alignment: .center)
                                            .cornerRadius(12)
                                        TextField("Write a comment", text: $comment)
                                            .foregroundColor(.white)
                                            .frame(width:geometry.size.width * 0.7)
                                            .multilineTextAlignment(.leading)
                                        Button {
                                            postService.commentPost(token: userService.token, postID: "\(vm.postDetails.postID)", comment: comment)
                                            vm.postDetails.comments?.append(CommentDetail(email: userService.user.email ?? "", username: userService.user.username, profilePictureLink: userService.user.profilePictureLink, comment: comment, commentDate: "\(Date())"))
                                            comment = ""
                                        } label: {
                                            Image(systemName: "paperplane.fill")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 12, height: 12, alignment: .center)
                                                .foregroundColor(.white)
                                        }
                                        Spacer()
                                    }
                                    Spacer()
                                }
                                .padding(.leading,20)
                                
                            }
                        }
                        Spacer()
                    }
                    .frame(maxWidth:.infinity,maxHeight: .infinity)
                    .background(Color("NoirBG"))
                    .ignoresSafeArea()
                    .sheet(isPresented: $isViewingFullPic) {
                        WebImage(url: URL(string : vm.postDetails.photoLinksList?.first ?? "https://images.pexels.com/photos/10808064/pexels-photo-10808064.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                            .ignoresSafeArea()
                }
                }
            } else {
                VStack (spacing: 0 ) {
                    Button {
                        isViewingFullPic.toggle()
                    } label: {
                        WebImage(url: URL(string: vm.postDetails.photoLinksList?.first ?? "https://images.pexels.com/photos/10808064/pexels-photo-10808064.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"))
                            .resizable()
                            .scaledToFill()
                            .frame(height:geometry.size.height * 0.5)
                            .cornerRadius(44)
                    }
                    VStack (alignment:.leading) {
                        HStack {
                            WebImage(url: URL(string: user?.profilePictureLink ?? "https://images.pexels.com/photos/10808064/pexels-photo-10808064.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32, alignment: .center)
                                .cornerRadius(16)
                            Text("\(user?.username ?? "Can't Retrieve")")
                                .font(.body.bold())
                                .foregroundColor(.white)
                            Spacer()
                        }
                        Text("\(vm.postDetails.postCaption ?? "Can't Retrieve")")
                            .font(.caption)
                            .foregroundColor(Color("NoirGrayL"))
                            .fontWeight(.light)
                    }
                    .frame(height:geometry.size.height * 0.15)
                    .padding(.horizontal,16)
                    
                    ScrollView(showsIndicators:false) {
                        VStack {
                            ForEach(vm.postDetails.comments!, id:\.id) { comment in
                                Comment(comments: comment)
                            }
                            
                            HStack {
                                TextField("Write a comment", text: $comment)
                                    .foregroundColor(.white)
                                    .frame(width:200)
                                    .multilineTextAlignment(.leading)
                                Button {
                                    postService.commentPost(token: userService.token, postID: "\(vm.postDetails.postID)", comment: comment)
                                } label: {
                                    Image(systemName: "paperplane.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 12, height: 12, alignment: .center)
                                        .foregroundColor(.white)
                                }
                                Spacer()
                            }
                            .frame(width:geometry.size.width - 16)
                            
                            
                        }
                    }
                    
                    Spacer()
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity)
                .background(Color("NoirBG"))
                .ignoresSafeArea()
                .sheet(isPresented: $isViewingFullPic) {
                    WebImage(url: URL(string : vm.postDetails.photoLinksList?.first ?? "https://images.pexels.com/photos/10808064/pexels-photo-10808064.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                        .ignoresSafeArea()
                }
            }
           
        }
        .onAppear {
            vm.postDetails = PostDetails(postID: 0, postCaption: "", tagsList: [], postLocation: "", photoLinksList: [], postDate: "", likeCount: 0, commentCount: 0, isLiked: false, username: "", profilePictureLink: "", isBookmarked: false,comments: [])
            postService.getSinglePost(token: userService.token, postID: "\(post.postID)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                vm.postDetails = postService.targetPost
            }
        }
    }
}

struct PostDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailsView(post: PostDetails(postID: 0))
    }
}
