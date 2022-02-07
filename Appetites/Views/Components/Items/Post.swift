//
//  Post.swift
//  Appetites
//
//  Created by chavin Panicharoen on 4/2/2565 BE.
//

import SwiftUI

struct Post: View {
    
    @State private var messageText:String = ""
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                VStack {
                    HStack (spacing:16) {
                        Image("Avatar1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 48, height: 48, alignment: .center)
                        VStack (alignment:.leading,spacing:8) {
                            Text("Loongallday")
                                .font(.system(size: 16).bold())
                                .foregroundColor(.gray)
                            Text("20 April 20.48")
                                .font(.system(size: 12).bold())
                                .foregroundColor(Color("NoirGrayL"))
                        }
                        Spacer()
                    }
                    .padding(.top,32)
                    .frame(width: geometry.size.width - 32, height: 80, alignment: .center)
                    Text("sdfjdslfjdslkfjdsklfjdskljfdsfjkdsjfkdsjfdlskjfklsdjfsdklfjsdklfjdfdsfdskfjdslkfjlsdkjfdklsjfklsdjfkljsdfdsfljsdfkjsddsfsdlkflksjdfksdjf")
                        .lineLimit(2)
                        .frame(width: geometry.size.width-32, height: 44, alignment: .leading)
                    Image("Burger")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width-32, height: 160, alignment: .center)
                        .background()
                        .cornerRadius(24)
                    Rectangle()
                        .frame(width: geometry.size.width-32, height: 1, alignment: .center)
                        .padding()
                        .foregroundColor(Color("NoirGrayL"))
                    
                    HStack (spacing:24) {
                        HStack (spacing:8) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                                .frame(width: 16, height: 16, alignment: .center)
                            Text("Likes")
                                .foregroundColor(.white)
                        }
                        
                        HStack (spacing:8) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                                .frame(width: 16, height: 16, alignment: .center)
                            Text("Likes")
                                .foregroundColor(.white)
                        }
                    }
                    Rectangle()
                        .frame(width: geometry.size.width, height: 1, alignment: .center)

                        .foregroundColor(Color("NoirGrayL"))
                    HStack {
                        Image("Avatar1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40, alignment: .center)
                        TextField("Comment", text: $messageText)
                    }
                    .frame(width: geometry.size.width-64, alignment: .center)
                    Spacer()
                }
            }
            .frame(height:460)
            .frame(maxWidth:.infinity)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .foregroundColor(Color("NoirGrayD"))
            )
            
        }
        
        
//           RoundedRectangle(cornerRadius: 24)
//               .fill(Color(UIColor(named: "NoirBG")!))
//               .overlay(
//                   VStack{
//                       //MARK: PROFILE PICTURE
//                       HStack(alignment: .center){
//                           Image("Avatar1") //INPUT PROFILE PICTURE
//                               .resizable()
//                               .aspectRatio(contentMode: .fill)
//                               .frame(width: 48, height: 48)
//                               .cornerRadius(48)
//                           VStack {
//                               HStack {
//                                   Text("Loong") //INPUT USERNAME
//                                       .bold()
//                                       .font(.system(size: 16))
//                                       .foregroundColor(.white)
//                               }
//                               HStack {
//                                   Text("19 JAN 2021") //INPUT DATETIME
//                                       .font(.system(size: 12))
//                                       .foregroundColor(.gray)
//                               }
//                           }
//                           Spacer()
//                       }
//                       //MARK: CAPTION
//                       HStack {
//                           Text("CAPTION LMAO") //INPUT CAPTION
//                               .font(.system(size: 12))
//                               .bold()
//                               .foregroundColor(.white)
//                               .frame(width: 280, alignment: .center)
//                       }
//
//
//                       //MARK: POSTED IMAGE
//                       HStack {
//                           Image("Burger") //INPUT PHOTO
//                               .resizable()
//                               .frame(width: 280, height: 160)
//                               .scaledToFill()
//                               .cornerRadius(24)
//                       }
//                       Divider().background(.white).padding(.horizontal).padding(.vertical, 4)
//
//                       //MARK: LIKE AND COMMENT VISUALISE
//                       HStack {
//
//                           //HeartButton(isLiked: $isLiked)
//                           //    .font(.system(size: 16))
//                           Text("10" + " Likes") //INPUT N LIKE
//                               .foregroundColor((Color(UIColor(named: "NoirGrayD")!)))
//                               .font(.system(size: 12))
//                           Image(systemName: "text.bubble.fill")
//                               .foregroundColor((Color(UIColor(named: "NoirGrayD")!)))
//                               .font(.system(size: 16))
////                               .padding(.leading, basicleftpadding)
//                           Text("10" + " Comments") //INPUT N COMMENT
//                               .foregroundColor((Color(UIColor(named: "NoirGrayD")!)))
//                               .font(.system(size: 12))
//                           Spacer()
//                       }
////                       .padding(.leading, basicleftpadding)
//                       Divider().background(.white).padding(.vertical, 4)
//                       //MARK: COMMENT BAR
//                       HStack {
//                           Image("Avatar1") //INPUT PROFILE PICTURE
//                               .resizable()
//                               .aspectRatio(contentMode: .fill)
//                               .frame(width: 40, height: 40)
//                               .clipShape(Circle())
//                               .overlay(Circle().stroke(.black,lineWidth: 2))
//
//                          TextField("   Comment...", text: $messageText)
//                               .foregroundColor(.gray)
//                               .padding(.vertical,8)
//                               .background(Color.white.opacity(0.3))
//                               .cornerRadius(16)
//                               .onSubmit {
//                                   sendMessage(message: messageText)
//                               }
//                           Button {
//                               sendMessage(message: messageText)
//                           } label: {
//                               Image(systemName: "paperplane.fill")
//                           }
//                           .font(.system(size: 16))
//
//                       }.padding(.horizontal, 16)
//                   }
//
//               )
//               .frame(width: 316, height: 432,alignment: .center)
//       }
//       //MARK: COMMENT SUBMISSION
//       func sendMessage(message: String) {
//           self.messageText=""
//           //SOMEHOW SEND THE COMMENT TO BACKEND
//       }
    }
}

struct Post_Previews: PreviewProvider {
    static var previews: some View {
        Post()
    }
}
