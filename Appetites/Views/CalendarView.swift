//
//  CalendarView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 31/1/2565 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct CalendarView: View {
    @State var date:Date = Date()
    @State private var isAddingEvent:Bool = false
    @State private var showDetails:Bool = false
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var userService:UserDataService
    @StateObject private var eventService = EventDataService()
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    HStack {
                        HStack {
                            BackButton(){
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        Spacer()
                        Button {
                            showDetails.toggle()
                        } label: {
                            Text("View Event Details")
                                .foregroundColor(Color("NoirGreen"))
                        }

                    }
                    .frame(width: geometry.size.width-64, height: 50, alignment: .center)
                    CustomDatePicker(currentDate:$date)
                        .frame(width:geometry.size.width-32)
                        .environmentObject(eventService)
                    Spacer()
                }
            }
            .overlay(content: {
                VStack {
                    Spacer()
                    LongButton(title: .constant("Add Event"), color: .constant("NoirGreen")) {
                        isAddingEvent.toggle()
                    }
                    .frame(width:geometry.size.width-54)
                }
            })
            .fullScreenCover(isPresented: $isAddingEvent, content: {
                AddEventView(follower: userService.user.followerDetails ?? [])
                    .environmentObject(eventService)
            })
            .frame(maxWidth:.infinity)
            .background(Color("NoirBG"))
            .sheet(isPresented: $showDetails) {
                ZStack {
                    HStack {
                        VStack (spacing:16) {
                            HStack {
                                Text("Your Events")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            ForEach(eventService.event.events) { event in
                                HStack {
                                    VStack {
                                        HStack {
                                            Text("\(event.eventDate)")
                                                .font(.body.bold())
                                                .foregroundColor(Color("NoirGreen"))
                                            Spacer()
                                        }
                                        HStack {
                                            Text("Title : \(event.eventTitle)")
                                                .font(.caption)
                                                .foregroundColor(.white)
                                            Spacer()
                                        }
                                        HStack {
                                            Text("Description : \(event.eventDescription)")
                                                .font(.caption)
                                                .foregroundColor(.white)
                                            Spacer()
                                        }
                                        HStack {
                                            Text("Location : \(event.eventLocation)")
                                                .font(.caption)
                                                .foregroundColor(.white)
                                            Spacer()
                                        }
                                    }
                                    Spacer()
                                    ForEach(event.eventMembers) { member in
                                        HStack {
                                            WebImage(url: URL(string: member.profilePictureLink ?? "https://images.pexels.com/photos/8059137/pexels-photo-8059137.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"))
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 30, height: 30, alignment: .center)
                                                .cornerRadius(30)
                                        }
                                    }
                                    .offset(y:5)
                                }
                                .padding(.top,10)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(.horizontal,16)
                    .padding(.top,30)
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity)
                .background(Color("NoirBG"))
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(UserDataService())
    }
}
