//
//  UserStatusBadge.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserStatusBadge: View {
    @State var user:LocalUserInfo
    var body: some View {
        ZStack {
            HStack (spacing:16) {
                WebImage(url: URL(string: user.profilePictureLink ?? "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"))
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: 60,
                        height: 60,
                        alignment: .center
                    )
                    .background(
                        Circle()
                            .foregroundStyle(Color("NoirYellow"))
                    )
                    .cornerRadius(60.0)
                VStack (alignment:.leading, spacing: 8) {
                    Text(user.username ?? "Unknown")
                        .font(.callout.bold())
                        .foregroundColor(.white)
                    Text(user.email ?? "Unknown")
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
            }
            .padding(.horizontal,16)
        }
        .frame(height:97)
        .frame(maxWidth:.infinity)
        .background(Color("NoirGrayD"))
    }
}

struct UserStatusBadge_Previews: PreviewProvider {
    static var previews: some View {
        UserStatusBadge(user: LocalUserInfo(email: "loong", expiresIn: "", username: "Loong", profilePictureLink: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", following: 0, follower: 0, followingDetails: [], followerDetails: [], registerDate: ""))
    }
}
