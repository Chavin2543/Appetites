//
//  InfoFillView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 3/2/2565 BE.
//

import SwiftUI

struct InfoFillView: View {
    var body: some View {
        GeometryReader  { geometry in
            ZStack {
                VStack (spacing:32) {
                    Button {
                        print("Selecting")
                    } label: {
                        Circle()
                            .foregroundColor(Color("NoirYellow"))
                            .frame(width: geometry.size.width - 64, height:geometry.size.width-64,alignment: .center)
                    }
                    Text("Select Profile Image")
                        .font(.title.bold())
                        .foregroundColor(.white)
                }
                VStack {
                    Spacer()
                    LongButton(title: "Continue", color: "NoirGreen") {
                        print("Continue")
                    }
                    .frame(width:geometry.size.width-64)
                }

            }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(Color("NoirBG"))
        }
    }
}

struct InfoFillView_Previews: PreviewProvider {
    static var previews: some View {
        InfoFillView()
    }
}
