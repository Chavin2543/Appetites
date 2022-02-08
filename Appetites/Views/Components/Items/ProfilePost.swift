//
//  ProfilePost.swift
//  Appetites
//
//  Created by chavin Panicharoen on 8/2/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfilePost: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                WebImage(url: URL(string: "https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: 232, alignment: .center)
                    .cornerRadius(44)
                .clipped()
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vulputate eget eu vitae euismod amet. Ultrices enim vivamus sem rhoncus, facilisis amet risus,")
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width-16, height: 120, alignment: .center)
                    .lineLimit(4)
            }
            
        }
    }
}

struct ProfilePost_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePost()
    }
}
