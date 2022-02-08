//
//  UpcomingEventBadge.swift
//  Appetites
//
//  Created by chavin Panicharoen on 9/2/2565 BE.
//

import SwiftUI

struct UpcomingEventBadge: View {
    var body: some View {
        GeometryReader { geometry in
            HStack {
                HStack (spacing:20) {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                    VStack (alignment:.leading,spacing:8) {
                        HStack {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundColor(Color("NoirGreen"))
                            Text("Upcoming Event")
                                .font(.caption)
                            .fontWeight(.light)
                        }
                        Text("19 Nov 2021")
                            .font(.subheadline.bold())
                        Button {
                            print("Action")
                        } label: {
                            Text("Open")
                                .font(.caption.bold())
                                .foregroundColor(.white)
                                .frame(width: 80, height: 28, alignment: .center)
                                .background(Color("NoirGreen"))
                                .cornerRadius(20)
                        }

                    }
                    .foregroundColor(.white)
                    Spacer()
                }
                .frame(width:geometry.size.width-48)
            }
            .frame(width:geometry.size.width,height:144)
            .background(Color("NoirGrayD"))
        }
    }
}

struct UpcomingEventBadge_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingEventBadge()
    }
}
