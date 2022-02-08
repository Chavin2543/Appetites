//
//  CardView.swift
//  Appetites
//
//  Created by Ghandhi Thamthiwat on 8/2/2565 BE.
//

import SwiftUI

struct CardView: View, Identifiable {
    //Properties
    let id = UUID()
    var discovers: DiscoverMenu
    
    
    var body: some View {
        Image(discovers.image) //INPUT IMAGE
            .resizable()
            .frame(width:304, height:540)
            .cornerRadius(24)
            .scaledToFit()
       /* MARK: OLD OVERLAY
        .overlay(
                VStack(alignment: .center, spacing: 12) {
                    Text(appetite.foodname.uppercased())
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(radius: 1)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 4)
                        .overlay(
                            Rectangle()
                                .fill(Color.white)
                                .frame(height: 1),
                            alignment: .bottom
                        )
                    Text(appetite.restaurantname.uppercased())
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .font(.footnote)
                        .frame(minWidth: 85)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            Capsule().fill(Color.white)
                        )
                }
                .frame(minWidth:280)
                .padding(.bottom,50),
                alignment: .bottom
            ) */
        //MARK: NEW OVERLAY
            .overlay(
                VStack{
                    HStack(alignment: .center){
                        Image(systemName: "mappin.and.ellipse").foregroundColor(Color.white)
                        Text(discovers.restaurantname.uppercased()).foregroundColor(Color.white) //INPUT ZONE
                        Spacer()
                    }.padding(.top,20)
                    Spacer()
                    HStack(alignment: .center){
                        Text(discovers.foodname.uppercased()) //INPUT RESTAURANT
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.bottom, 32)
                            .frame(width: 132)
                        Spacer()
                    }
                    HStack(alignment: .center){
                       // Text(appetite.price) //INPUT price
                       //     .font(.headline)
                        //    .foregroundColor(.white)
                        Text(discovers.foodtag) //INPUT fooodtag
                            .font(.headline)
                             .foregroundColor(.white)
                            
                        Spacer()
                       // StarView(star: .constant(appetite.star)) //INPUT STAR
                       //     .foregroundColor(.white)
                        Image(systemName: "heart.circle")
                            .foregroundColor(.white)
                        Text(String(discovers.like)) //INPUT LIKES
                            .foregroundColor(.white)
                    }.padding(.bottom, 44)
                    
                }
                    .frame(width:UIScreen.main.bounds.width-120)
            )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(discovers: discoverdata[2])
            .previewLayout(.fixed(width: 375, height: 600))
        
    }
}
