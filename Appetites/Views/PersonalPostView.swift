//
//  PersonalPostView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 9/2/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct PersonalPostView: View {
    var items: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var userService:UserDataService
    @EnvironmentObject private var postService:PostDataService
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView {
                    VStack (spacing:20){
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.body)
                                    .foregroundColor(.white)
                            }

                            Text("Your Posts")
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .frame(height:97)
    //                    ForEach(postService.post.posts) { item in
    //                        Post(likeButtonAction: {
    //                            print("Liked")
    //                        }, commentButtonAction: {
    //                            print("Liked")
    //                        },post: item)
    //                    }
                        LazyVGrid(columns: items, alignment: .center, spacing: 4) {
                            ForEach(postService.post.posts) { item in
                                NavigationLink(destination: PostDetailsView(post: item,user: userService.user).environmentObject(postService)) {
                                    WebImage(url: URL(string: item.photoLinksList?.first ?? "https://images.pexels.com/photos/11012766/pexels-photo-11012766.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geometry.size.width*0.27,height: geometry.size.width*0.27)
                                        .clipped()
                                }
                            }
                        }
                        Spacer()
                    }
                    .frame(width:geometry.size.width-64)
                    .frame(maxWidth:.infinity)
                }
                .background(Color("NoirBG"))
                .navigationBarHidden(true)
            }
        }
        .onAppear {
            postService.getPosts(token: userService.token)
        }
    }
}

struct PersonalPostView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalPostView()
    }
}
