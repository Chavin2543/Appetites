//
//  CardView.swift
//  Appetites
//
//  Created by Ghandhi Thamthiwat on 8/2/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardView: View, Identifiable {
    //Properties
    let id = UUID()
    var discovers: RecommendedPost
    
    
    var body: some View {
        WebImage(url: URL(string: (discovers.photoLinksList?.first)!))
            .resizable()
            .scaledToFill()
            .frame(width:304, height:540)
            .cornerRadius(24)

        //MARK: NEW OVERLAY
            .overlay(
                VStack{
                    HStack(alignment: .center){
                        Image(systemName: "person.circle").foregroundColor(Color.white)
                        Text(discovers.username?.uppercased() ?? "Mo Salah").foregroundColor(Color.white) //INPUT ZONE
                        Spacer()
                    }.padding(.top,20)
                    Spacer()
                    HStack(alignment: .center){
                        Text("\(discovers.postID)")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.bottom, 32)
                            .frame(width: 132)
                        Spacer()
                    }
                    HStack(alignment: .center){
                        VStack(alignment: .leading){
                            switch discovers.tagsList?.count {
                            case 0:
                                Text("")
                            case 1:
                                Text(discovers.tagsList![0])
                            case 2:
                                Text(discovers.tagsList![0])
                                Text(discovers.tagsList![1])
                            default:
                                Text(discovers.tagsList![0])
                                Text(discovers.tagsList![1])
                                Text(discovers.tagsList![2])
                            }
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                            
                        Spacer()
                        Image(systemName: "heart.circle")
                            .foregroundColor(.white)
                        Text(String(discovers.likeCount ?? 0))
                            .foregroundColor(.white)
                    }.padding(.bottom, 44)
                    
                }
                    .frame(width:UIScreen.main.bounds.width-120)
            )
    }
}
