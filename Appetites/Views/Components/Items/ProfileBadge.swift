//
//  ProfileBadge.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileBadge: View {
    @State var buttonAction: () -> Void
    @State var extended:Bool = false
    @Binding var profilePic:String?
    @Binding var follower:Int?
    @Binding var following:Int?
    var body: some View {
        Button(action: buttonAction) {
            LazyHStack (alignment:.center,spacing:32) {
                    LazyVStack {
                        Text("Follower")
                            .font(.footnote.bold())
                            .foregroundColor(.white)
                        Text("\(follower ?? 0)")
                            .font(.title.bold())
                            .foregroundColor(Color("NoirGreen"))
                    }
                
//                AsyncImage(url: URL(string: profilePic ?? "")) { image in
//                    image
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 120, height: 120, alignment: .center)
//                        .cornerRadius(120)
//                } placeholder: {
//                    ProgressView()
//                }

                
                WebImage(url: URL(string: profilePic ?? "https://images.pexels.com/photos/10162332/pexels-photo-10162332.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"))
                        .resizable()
                        .scaledToFill()
                        .frame(width:130,height:130)
                        .cornerRadius(130)
                    LazyVStack {
                        Text("Following")
                            .font(.footnote.bold())
                            .foregroundColor(.white)
                        Text("\(following ?? 0)")
                            .font(.title.bold())
                            .foregroundColor(Color("NoirGreen"))
                    }
                }
                .frame(height:148)
                .frame(maxWidth:.infinity)
        }
    }
}

struct ProfileBadge_Previews: PreviewProvider {
    static var previews: some View {
        ProfileBadge(buttonAction: {
            print("He")
        }, profilePic: .constant("https://images.pexels.com/photos/10162332/pexels-photo-10162332.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),follower: .constant(0),following: .constant(0))
            .background(.black)
    }
}
