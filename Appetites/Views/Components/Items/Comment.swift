//
//  Comment.swift
//  Appetites
//
//  Created by chavin Panicharoen on 28/3/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct Comment: View {
    
    var comments:CommentDetail?
    
    var body: some View {
        VStack {
            HStack (alignment:.top) {
                VStack {
                    WebImage(url: URL(string: comments?.profilePictureLink ?? ""))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 24, height: 24, alignment: .leading)
                        .cornerRadius(12)
//                    Text("3s")
//                        .foregroundColor(.gray)
//                        .font(.caption)
                }
                Text("\(comments?.username ?? "") - ")
                    .font(.caption.bold())
                +
                Text("\(comments?.comment ?? "")")
                    .font(.caption)
                
                
                
                Spacer()
            }
        }
        .frame(maxWidth:.infinity)
    }
}

struct Comment_Previews: PreviewProvider {
    static var previews: some View {
        Comment()
            .background(.black)
            .foregroundColor(.white)
    }
}
