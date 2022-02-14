//
//  InfoFillView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 3/2/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct InfoFillView: View {
    @State private var username:String = ""
    @State var image:UIImage?
    @StateObject private var vm = InfoFillViewVM()
    @State var user:LocalUserInfo
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var userService:UserDataService
    
    var body: some View {
        GeometryReader  { geometry in
            ZStack {
                VStack {
                    HStack {
                        BackButton(){
                            presentationMode.wrappedValue.dismiss()
                        }
                        Spacer()
                    }
                    .frame(width:geometry.size.width-64,height:97,alignment: .center)
                    Spacer()
                    
                }

                VStack (spacing:32) {
                    if image != nil {
                        Button {
                            vm.showImagePicker.toggle()
                        } label: {
                            Image(uiImage: image!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 170, height: 170, alignment: .center)
                                .cornerRadius(170)
                        }
                        .sheet(isPresented: $vm.showImagePicker) {
                            ImagePicker(image: self.$image)
                        }
                    } else {
                        Button {
                            vm.showImagePicker.toggle()
                        } label: {
                            WebImage(url: URL(string: user.profilePictureLink ?? "https://image.freepik.com/free-photo/portrait-handsome-young-man-with-crossed-arms_176420-15569.jpg?w=1800"))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 170, height: 170, alignment: .center)
                                .cornerRadius(170)
                        }
                        .sheet(isPresented: $vm.showImagePicker) {
                            ImagePicker(image: self.$image)
                        }
                    }
                    
                    TextField("Username", text: $vm.newUsername)
                        .multilineTextAlignment(TextAlignment.center)
                        .frame(width:geometry.size.width*0.5)
                        .preferredColorScheme(.dark)
                        .background(
                            Capsule()
                                .frame(height:40)
                                .opacity(0.3)
                        )
                }
                VStack {
                    Spacer()
                    LongButton(title: .constant("Save"), color: .constant("NoirGreen")) {
                        if image != nil {
                            userService.uploadProfilePic(image: image!)
                        }
                        if vm.newUsername != user.username {
                            userService.setUsername(username: vm.newUsername)
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                    .frame(width:geometry.size.width-64)
                }

            }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(Color("NoirBG"))
        }
        .onAppear {
            vm.newUsername = user.username ?? ""
        }
        .onDisappear {
            SDImageCache.shared.clear(with: .all) {
                print("Memory in InfoView Cleared")
            }
        }
    }
}

struct InfoFillView_Previews: PreviewProvider {
    static var previews: some View {
        InfoFillView(user: LocalUserInfo())
    }
}
