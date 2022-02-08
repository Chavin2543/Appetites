//l
//  OtherProfileView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 7/2/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct OtherProfileView: View {
    @State var user:SearchResultDetails
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    VStack (spacing:20) {
                        WebImage(url: URL(string:user.profilePictureLink ?? "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"))
                            .resizable()
                            .scaledToFill()
                            .frame(width:200,height:200)
                            .cornerRadius(44)
                            .clipped()
                        
                        VStack {
                            Text("\(user.username)")
                                .font(.title.bold())
                                .foregroundColor(.white)
                        }
                        Button {
                            print("Followed")
                        } label: {
                            Text("Follow")
                                .font(.body.bold())
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 44)
                                        .frame(width: 132, height: 36, alignment: .center)
                                        .foregroundColor(Color("NoirGreen"))
                                )
                        }
                        OtherProfileTab()
                            .frame(width:geometry.size.width-40)
                    }
                }
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(Color("NoirBG"))
        }
    }
}

struct OtherProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OtherProfileView(user:SearchResultDetails(username: "OwenRatana", email: "Loong@email.com", profilePictureLink: "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"))
    }
}
