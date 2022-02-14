//
//  PersonalPost.swift
//  Appetites
//
//  Created by chavin Panicharoen on 9/2/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct PersonalPost: View {
    @State var post:PostDetails
    var body: some View {
        GeometryReader { geometry in
            VStack {
                WebImage(url: URL(string: post.photoLinksList?[0] ?? "https://image.freepik.com/free-photo/vestrahorn-mountains-stokksnes-iceland_335224-667.jpg?w=2000"))
                    .resizable()
                    .scaledToFill()
                    .frame(width:geometry.size.width-32,height:156)
                    .cornerRadius(25)
                    .clipped()
                HStack {
                    VStack (alignment:.leading,spacing: 8) {
                        HStack {
                            Text(post.postCaption ?? "https://image.freepik.com/free-photo/vestrahorn-mountains-stokksnes-iceland_335224-667.jpg?w=2000")
                                .font(.subheadline.bold())
                                .foregroundColor(.white)
                            .lineLimit(1)
                            Spacer()
                            Button {
                                print("Likes")
                            } label: {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.white)
                            }
                            Text("\(post.likeCount ?? 0) Likes")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                        }
                        Text("\(post.commentCount ?? 0) Comments")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .frame(width:geometry.size.width-32)
                
            }
            .frame(height:265)
            .frame(maxWidth:.infinity)
            .background(Color("NoirGrayD"))
            
        }
    }
}

struct PersonalPost_Previews: PreviewProvider {
    static var previews: some View {
        PersonalPost(post: PostDetails(postID: 0))
            .background(.black)
    }
}
