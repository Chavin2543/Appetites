//
//  PersonalPostView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 9/2/2565 BE.
//

import SwiftUI

struct PersonalPostView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var userService:UserDataService
    @EnvironmentObject private var postService:PostDataService
    var body: some View {
        GeometryReader { geometry in
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
                    ForEach(postService.post.posts) { item in
                        PersonalPost(post: item)
                            .frame(height:264)
                            .cornerRadius(24)
                    }
                    Spacer()
                }
                .frame(width:geometry.size.width-64)
                .frame(maxWidth:.infinity)
            }
            .background(Color("NoirBG"))
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
