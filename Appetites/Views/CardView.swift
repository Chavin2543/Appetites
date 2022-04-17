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
    var discovers: DiscoverTinder
    
    
    var body: some View {
        Image(discovers.imageURL) //INPUT IMAGE
            .resizable()
            .scaledToFill()
            .frame(width:304, height:540)
            .cornerRadius(24)

        //MARK: NEW OVERLAY
            .overlay(
                VStack{
                    HStack(alignment: .center){
                        Image(systemName: "mappin.and.ellipse").foregroundColor(Color.white)
                        Text(discovers.restaurantName.uppercased()).foregroundColor(Color.white) //INPUT ZONE
                        Spacer()
                    }.padding(.top,20)
                    Spacer()
                    HStack(alignment: .center){
                        Text(discovers.foodName.uppercased()) //INPUT RESTAURANT
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.bottom, 32)
                            .frame(width: 132)
                        Spacer()
                    }
                    HStack(alignment: .center){
                        VStack(alignment: .leading){
                            switch discovers.foodTag.count {
                            case 0:
                                Text("Your Meal")
                            case 1:
                                Text(discovers.foodTag[0])
                            case 2:
                                Text(discovers.foodTag[0])
                                Text(discovers.foodTag[1])
                            default:
                                Text(discovers.foodTag[0])
                                Text(discovers.foodTag[1])
                                Text(discovers.foodTag[2])
                            }
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                            
                        Spacer()
                        Image(systemName: "heart.circle")
                            .foregroundColor(.white)
                        Text(String(discovers.like))
                            .foregroundColor(.white)
                    }.padding(.bottom, 44)
                    
                }
                    .frame(width:UIScreen.main.bounds.width-120)
            )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(discovers: DiscoverTinderMenu[1])
            //.previewLayout(.fixed(width: 375, height: 600))
        
    }
}
