//
//  CalendarView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 31/1/2565 BE.
//

import SwiftUI

struct CalendarView: View {
    @State var date:Date = Date()
    @State private var isAddingEvent:Bool = false
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
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(UserDataService())
    }
}
