//
//  Post.swift
//  Appetites
//
//  Created by chavin Panicharoen on 4/2/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct Post: View {
    
    @State private var messageText:String = ""
    var likeButtonAction: () -> Void
    var commentButtonAction: () -> Void
    @State var post:PostDetails
    var profilePicURL:String?
    var body: some View {
            ZStack {
                VStack(spacing:15) {
                    HStack (spacing:16) {
                        WebImage(url: URL(string: post.profilePictureLink ?? "https://images.pexels.com/photos/10808064/pexels-photo-10808064.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 48, height: 48)
                            .cornerRadius(24)
                        VStack (alignment:.leading,spacing: 8) {
                            Text("\(post.username ?? "Cant retrieve")")
                                .font(.system(size:16).bold())
                                .foregroundColor(Color("NoirGrayL"))
                            Text("\(post.postDate ?? "Can't Retrieve")")
                                .font(.system(size:14))
                                .fontWeight(.regular)
                                .foregroundColor(Color("NoirGrayL"))
                        }
                        Spacer()
                    }
                    .padding(.leading,16)
                    VStack (alignment:.leading) {
                        HStack {
                            Text("\(post.postCaption ?? "")")
                                .font(.system(size:20))
                                .fontWeight(.regular)
                            .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    .padding(.horizontal,20)
                    VStack {
                        WebImage(url: URL(string: post.photoLinksList?.first ?? ""))
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(25)
                            .padding(.horizontal,25)
                    }
//                    RoundedRectangle(cornerRadius: 20)
//                        .frame(height:200)
//                        .foregroundColor(.black)
//                        .padding(.horizontal,16)
                    HStack(spacing:24) {
                        HStack {
                            Button {
                                if !post.isLiked! {
                                    likeButtonAction()
                                    post.likeCount! -= 1
                                    post.isLiked?.toggle()
                                } else {
                                    commentButtonAction()
                                    post.likeCount! += 1
                                    post.isLiked?.toggle()
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(!(post.isLiked)! ? .red : Color("NoirGrayL"))
    
                                }
                            }
                        }
                        
                        HStack {
                            Button {
                                commentButtonAction()
                            } label: {
                                HStack {
                                    Image(systemName: "message.fill")
                                        .foregroundColor(Color("NoirGrayL"))
                                }
                            }
                        }
                        Text("\(post.likeCount ?? 0) ")
                            .font(.system(size:16).bold())
                            .foregroundColor(Color("NoirGrayL"))
                        +
                        Text("Likes")
                            .font(.system(size:16))
                            .foregroundColor(Color("NoirGrayL"))
                        
                        Spacer()
                    }
                    .padding(.horizontal,25)
                    .padding(.vertical,10)
                    
                    
                    HStack {
                        WebImage(url: URL(string: profilePicURL ?? ""))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .cornerRadius(20)
//                        Image("Avatar1")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 40, height: 40)
                        TextField("Write Comments", text: $messageText)
                            .preferredColorScheme(.dark)
                            .font(.system(size: 16))
                        Button {
                            messageText = ""
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .resizable()
                                .foregroundColor(Color("NoirGrayL"))
                                .frame(width: 12, height: 12)
                        }

                    }
                    .padding(.horizontal,25)
                }
            }
            .frame(maxWidth:.infinity)
            .padding(.vertical,20)
            .background(Color("NoirBG"))
            .cornerRadius(25)
            .shadow(color: .black.opacity(0.6), radius: 3, x: 3, y: 3)
            .shadow(color: .gray.opacity(0.3), radius: 3, x: -3, y: -3)
    }
}

struct Post_Previews: PreviewProvider {
    static var previews: some View {
        Post(likeButtonAction: {
            print("Test")
        }, commentButtonAction: {
            print("Test")
        }, post: PostDetails(postID: 0))

    }
}
