//
//  DiscoverBadge.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct DiscoverBadge: View {
    @State var buttonAction: () -> Void
    var body: some View {
        Button(action: buttonAction) {
            ZStack {
                RoundedRectangle(cornerRadius: 24.0,style: .continuous)
                    .frame(
                        height: 263)
                    .foregroundStyle(Color("NoirBG"))
                Image("FrenzyMode")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 263, alignment: .center)
                    .offset(x:-10)
                Image("Avatar1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 130, alignment: .center)
            }
            .cornerRadius(24.0)
        }
        .shadow(color: .black.opacity(0.6), radius: 3, x: 3, y: 3)
        .shadow(color: .gray.opacity(0.3), radius: 3, x: -3, y: -3)
    }
}

struct DiscoverBadge_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverBadge() {
            print("Discover")
        }
    }
}
