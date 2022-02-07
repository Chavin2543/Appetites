//
//  UserSearchResult.swift
//  Appetites
//
//  Created by chavin Panicharoen on 7/2/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserSearchResult: View {
    
    var userInfo:SearchResultDetails
    
    var body: some View {
        GeometryReader { geometry in
            if userInfo.username != "" {
                HStack (spacing:16) {
                    WebImage(url: URL(string: userInfo.profilePictureLink ?? "https://images.pexels.com/photos/2007647/pexels-photo-2007647.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"))
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                        .cornerRadius(80)
                    VStack (alignment:.leading,spacing:8){
                        Text("\(userInfo.username)")
                            .font(.callout.bold())
                            .foregroundColor(.white)
                        Text("\(userInfo.email)")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                }
            } else {
                Text("Search Users")
                    .font(.largeTitle.bold())
                    .frame(maxWidth:.infinity)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

struct UserSearchResult_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchResult(userInfo:SearchResultDetails(username: "Loong", email: "loong@email.com", profilePictureLink: "https://images.pexels.com/photos/2007647/pexels-photo-2007647.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")
                         )
    }
}
