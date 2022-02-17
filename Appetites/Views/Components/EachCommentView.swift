//
//  EachCommentView.swift
//  Appetites
//
//  Created by Ghandhi Thamthiwat on 10/2/2565 BE.
//

import SwiftUI

struct EachCommentView: View {
    
    var posts: PostComponentData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            ForEach(posts.eachcomment.indices, id: \.self) {comment in
                HStack{
                    Image(posts.eachcomment[comment][0]) //INPUT PROFILE PICTURE
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 36, height: 36)
                    .cornerRadius(36)
                    Text(posts.eachcomment[comment][1]+" : ") //INPUT USERNAME
                        .font(.system(size: 12).bold())
                        .foregroundColor(.red)
                    Text(posts.eachcomment[comment][2]) //IMPUT COMMENT
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                }
            }
        }
    }
    
}

struct EachCommentView_Previews: PreviewProvider {
    static var previews: some View {
        EachCommentView(posts: postdata[0])
            .background(Color("NoirBG"))
    }
}
