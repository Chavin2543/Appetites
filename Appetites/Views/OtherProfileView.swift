//l
//  OtherProfileView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 7/2/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct OtherProfileView: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var vm:OtherProfileViewVM
    @EnvironmentObject private var userService:UserDataService
    
    init(token:String,user:SearchResultDetails) {
        _vm = StateObject(wrappedValue: OtherProfileViewVM(token: token, user: user))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView{
                VStack (spacing:16) {
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title)
                        }

                        Text(vm.user.username ?? "Anonymous")
                            .font(.title.bold())
                        Button {
                            print("Test Edit")
                        } label: {
                            Image(systemName: "pencil")
                                .font(.title.bold())
                                .foregroundStyle(Color("NoirYellow"))
                        }
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .frame (height: 97, alignment: .leading)
                    
                    ProfileBadge(buttonAction: {
                        print("Enter")
                    }, loading: $vm.isLoading, profilePic: $vm.dataFromSearch.profilePictureLink, follower: $vm.user.follower, following: $vm.user.following)
                    
                    if userService.user.username != vm.dataFromSearch.username {
                        LongButton(title:vm.isFollowing ? .constant("Unfollow") : .constant("Follow"), color:vm.isFollowing ? .constant("NoirGrayL") : .constant("NoirGreen")) {
                            if vm.isFollowing {
                                vm.unfollow()
                            } else {
                                vm.follow()
                            }
                        }
                    }
                    
                    UpcomingEventBadge()
                        .frame(height: 144, alignment: .center)
                        .cornerRadius(24)
                    
                    CalendarBadge(buttonAction: {
                            print("Calendar")
                    })
                }
                .frame(width:geometry.size.width-64)
            }
            .navigationBarHidden(true)
            .preferredColorScheme(.dark)
            .frame(maxWidth:.infinity)
            .background(
                ZStack {Color("NoirBG")}
                    .ignoresSafeArea()
            )
        }
    }
}

struct OtherProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OtherProfileView(token: "", user:SearchResultDetails(username: "OwenRatana", email: "Loong@email.com", profilePictureLink: "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"))
    }
}
