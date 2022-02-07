//
//  CategoryBadge.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct CategoryBadge: View {
    @State var title:String
    @State var icon:String
    @State var buttonAction: () -> Void
    
    var body: some View {
        Button(action: buttonAction) {
            ZStack {
                RoundedRectangle(cornerRadius: 44.0,style: .continuous)
                    .frame(width: 119, height: 175, alignment: .center)
                    .foregroundStyle(Color("NoirGrayM"))
                VStack (spacing:35) {
                    Image("\(icon)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    .frame(width:93,height:70,alignment: .center)
                    Text("\(title)")
                        .font(.footnote.bold())
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct CategoryBadge_Previews: PreviewProvider {
    static var previews: some View {
        CategoryBadge(title: "Local", icon: "Avatar1") {
            print("Badge")
        }
    }
}
