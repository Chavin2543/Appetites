//
//  UserStatusBadge.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct UserStatusBadge: View {
    var body: some View {
        ZStack {
            HStack (spacing:16) {
                Image("Avatar1")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: 60,
                        height: 60,
                        alignment: .center
                    )
                    .background(
                        Circle()
                            .foregroundStyle(Color("NoirYellow"))
                    )
                    .cornerRadius(60.0)
                VStack (alignment:.leading, spacing: 8) {
                    Text("Loongallday")
                        .font(.callout.bold())
                        .foregroundColor(.white)
                    Text("rungallday@hotmail.com")
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
            }
            .padding(.horizontal,16)
        }
        .frame(height:97)
        .frame(maxWidth:.infinity)
        .background(Color("NoirGrayD"))
    }
}

struct UserStatusBadge_Previews: PreviewProvider {
    static var previews: some View {
        UserStatusBadge()
    }
}
