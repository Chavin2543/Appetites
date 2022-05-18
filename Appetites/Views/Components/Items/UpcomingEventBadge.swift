//
//  UpcomingEventBadge.swift
//  Appetites
//
//  Created by chavin Panicharoen on 9/2/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct UpcomingEventBadge: View {
    @State var latestEvent:EventDetail
    var body: some View {
        GeometryReader { geometry in
            HStack {
                HStack (spacing:20) {
                    WebImage(url: URL(string: "https://images.pexels.com/photos/370984/pexels-photo-370984.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80, alignment: .center)
                        .cornerRadius(40)
                    VStack (alignment:.leading,spacing:8) {
                        HStack {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundColor(Color("NoirGreen"))
                            Text("\(latestEvent.eventTitle)")
                                .font(.caption)
                            .fontWeight(.light)
                        }
                        Text("\(latestEvent.eventDate)")
                            .font(.subheadline.bold())
                    }
                    .foregroundColor(.white)
                    Spacer()
                }
                .frame(width:geometry.size.width-48)
            }
            .frame(width:geometry.size.width,height:144)
            .background(Color("NoirBG"))
        }
    }
}

struct UpcomingEventBadge_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingEventBadge(latestEvent: EventDetail(eventID: 0, eventLocation: "", eventTitle: "", eventDescription: "", eventDate: "", userEmail: "", isCreator: false, eventMembers: []))
    }
}
