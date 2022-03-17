//
//  PostBadge.swift
//  Appetites
//
//  Created by chavin Panicharoen on 9/2/2565 BE.
//

import SwiftUI

struct PostBadge: View {
    @State var buttonAction: () -> Void
    var body: some View {
        ZStack {
            Button {
                buttonAction()
            } label: {
                HStack {
                    Circle()
                        .frame(width:33)
                        .foregroundColor(Color("NoirYellow"))
                    Text("Post")
                        .font(.headline.bold())
                        .foregroundColor(.white)
                    Spacer()
                    ZStack {
                        Capsule()
                            .frame(width: 59, height: 24)
                        HStack (spacing:2) {
                            Text("99+")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.system(size:11))
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                                .font(.system(size:10))
                        }
                        
                    }
                    
                    
                }
        }
        }
        .frame(height:33)
        .frame(maxWidth:.infinity)

    }
}

struct PostBadge_Previews: PreviewProvider {
    static var previews: some View {
        PostBadge() {
            print("")
        }
        .background(.black)
    }
}
