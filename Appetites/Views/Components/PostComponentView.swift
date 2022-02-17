//
//  PostComponentView.swift
//  Appetites
//
//  Created by Ghandhi Thamthiwat on 8/2/2565 BE.
//

import SwiftUI

struct PostComponent: View {
    
    @State private var messageText:String = ""
    @State private var isLike:Bool = false
    
    @Binding var isFullscreen:Bool
    
    var posts: PostComponentData
    
    
    //MARK: MAIN COMPONENT
    var body: some View {
        GeometryReader { geometry in
 //           if !photoIsSelected {
                ZStack {
                    VStack (spacing:20){
                        //MARK: PROFILE PICTURE
                        
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
                                            .foregroundColor(.white)
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
                        
                            //MARK: CAPTION
                            HStack {
                                Text(posts.caption) //INPUT CAPTION
                                    .font(.system(size: 12).bold())
                                    .foregroundColor(.white)
                            }
                            .frame(width: geometry.size.width-32, alignment: .leading)
                                
                            //MARK: POSTED IMAGE
                        
//                        Button {
//                            isFullscreen = true
//                        } label: {
//                            Image(appetite.foodpicture) //INPUT PHOTO
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: geometry.size.width-32, height:160, alignment: .center)
//                                .cornerRadius(24)
//                        }
                        Image(posts.foodpicture) //INPUT PHOTO
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width-32, height:160, alignment: .center)
                            .cornerRadius(24)
                            .onTapGesture {
                                isFullscreen = true
                            }

                                
                                
                                //MARK: LIKE AND COMMENT VISUALISE
                        HStack (spacing:4) {
                                HeartButton(isLiked:$isLike)
                                    .font(.system(size: 16))
                                    .onAppear {
                                        isLike = posts.likestatus
                                    }
                                Text(String(posts.likecount) + " Likes") //INPUT N LIKE
                                    .font(.system(size: 12))
                                Image(systemName: "text.bubble.fill")
                                    .font(.system(size: 16))
                                    .padding(.leading, 12)
                                Text(String(posts.commentcount) + " Comments") //INPUT COMMENT
                                    .font(.system(size: 12))
                                Spacer()
                            }
                            .foregroundColor(Color("NoirGrayL"))
                            .padding(.leading,4)
                            .frame(width: geometry.size.width-32, alignment: .center)
                        
                            //MARK: COMMENT BAR
                        
                            HStack {
                                Image(posts.userpic) //INPUT PROFILE PICTURE
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(20)

                                TextField("Comment...", text: $messageText)
                                    .padding(.leading,12)
                                    .preferredColorScheme(.dark)
                                    .frame(height:40)
                                    .cornerRadius(12)
                                    .onSubmit {
                                        sendMessage(message: messageText)
                                    }
                                    
                                Button {
                                    sendMessage(message: messageText)
                                } label: {
                                    Image(systemName: "paperplane.fill")
                                }
                                .font(.system(size: 16))
                                        
                            }
                            .frame(width: geometry.size.width-32, alignment: .center)
                        }
                }
                .frame(width:geometry.size.width)
                //.frame(height: 448,alignment: .center)
                .padding(.vertical,12)
                .background(Color("NoirBG"))
            .cornerRadius(24)
            //}
           // else {
//                VStack{
//                    Spacer()
//                    Image(appetite.foodpicture)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: .infinity, alignment: .center)
//                        .onTapGesture {
//                            photoIsSelected.toggle()
//                        }
//                    Spacer()
//                }
//                .background(Color(UIColor(named: "NoirDark")!))
            //}
        }
        
    }
    //MARK: COMMENT SUBMISSION
    func sendMessage(message: String) {
        self.messageText=""
        //SOMEHOW SEND THE COMMENT TO BACKEND
    }
}

struct PostComponent_Previews: PreviewProvider {
    static var previews: some View {
        PostComponent(isFullscreen: .constant(false), posts: postdata[0])
    }
}
