//
//  ClickPostComponentView.swift
//  Appetites
//
//  Created by Ghandhi Thamthiwat on 8/2/2565 BE.
//

import SwiftUI

struct ClickPostComponentView: View {
    

var posts: PostComponentData
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    HStack {
                        Image(posts.foodpicture)
                            .resizable()
                            .scaledToFit()
                    }
                    .cornerRadius(24)
                    .ignoresSafeArea()
                    HStack(alignment: .center){
                        Image(posts.ownerpic) //INPUT PROFILE PICTURE
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 48, height: 48)
                            .cornerRadius(48)
                        VStack(alignment: .leading) {
                            HStack {
                                Text(posts.ownername) //INPUT USERNAME
                                    .font(.system(size: 16).bold())
                                    .foregroundColor(.black)
                            }
                            HStack {
                                Text(posts.datetime) //INPUT DATETIME
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                    }
                    .frame(width: geometry.size.width-32, alignment: .leading)
                    
                    
                    
                    
                    Spacer()
                }
            }
        }
    }
}

struct ClickPostComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ClickPostComponentView(posts: postdata[0])
    }
}
