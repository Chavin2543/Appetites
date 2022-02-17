//
//  ClickPostComponentView.swift
//  Appetites
//
//  Created by Ghandhi Thamthiwat on 8/2/2565 BE.
//

import SwiftUI

struct ClickPostComponentView: View {
    

    var posts: PostComponentData
    @State private var messageText:String = ""
    
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    VStack {
                        HStack {
                            Image(posts.foodpicture)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(44)
                        }
                        HStack{
                            Image(posts.ownerpic) //INPUT PROFILE PICTURE
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 48, height: 48)
                                .cornerRadius(48)
                            VStack(alignment: .leading) {
                                Text(posts.ownername) //INPUT USERNAME
                                    .font(.system(size: 16).bold())
                                    .foregroundColor(.white)
                                Text(posts.datetime) //INPUT DATETIME
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .frame(width: geometry.size.width-32, alignment: .center)
                        Text(posts.caption)
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                        .frame(width: geometry.size.width-32, alignment: .center)
                        Rectangle() //DUMMY RECTANGLE FOR BETTER VIEW
                            .fill(.clear)
                            .frame(width: geometry.size.width-88, height: 16)
                    }
                    .background(Color("NoirGrayD"))
                    .cornerRadius(44)
                    ScrollView {
                        VStack{
                            EachCommentView(posts: postdata[0])
                        }
                        .frame(width: geometry.size.width-48, alignment: .center)
                    }
                    HStack {
                        HStack {
                            Image(posts.userpic) //INPUT PROFILE PICTURE
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 48, height: 48)
                            .cornerRadius(48)
                        }
                        .frame(width: 60, height: 60, alignment: .trailing)
                        HStack {
                            TextField("Comment...", text: $messageText)
                                .padding()
                                .preferredColorScheme(.dark)
                                .frame(height:40)
                                .cornerRadius(12)
                                .onSubmit {
                                    sendMessage(message: messageText)
                            }
                        }
                        HStack {
                            Button {
                                sendMessage(message: messageText)
                            } label: {
                                Image(systemName: "paperplane.fill")
                            }
                        .font(.system(size: 16))
                        }
                        .frame(width: 80)
                    }
                    .background(Color("NoirGrayD"))
                    
                    Rectangle() //DUMMY RECTANGLE FOR BETTER VIEW
                        .fill(.clear)
                        .frame(width: geometry.size.width, height: 8)
                }
            }
            .ignoresSafeArea()
        }
        .background(Color("NoirBG"))
    }
    func sendMessage(message: String) {
        self.messageText=""
        //SOMEHOW SEND THE COMMENT TO BACKEND
    }
}

struct ClickPostComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ClickPostComponentView(posts: postdata[0])
    }
}
