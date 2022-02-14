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
        Button {
            buttonAction()
        } label: {
            ZStack{
                HStack {
                    Text("Posts")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.leading,32)
                        .shadow(color: .black.opacity(0.7), radius: 3, x: 1, y: 1)
                    Spacer()
                }
            }
            .frame(height:124)
            .frame(maxWidth:.infinity)
            .background(
                ZStack {
                    if let uiImage = UIImage(named: "Emojis")?.downsampled(by: 0.3) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            }
                }
            )
            .clipped()
        }

    }
}

struct PostBadge_Previews: PreviewProvider {
    static var previews: some View {
        PostBadge() {
            print("")
        }
    }
}
