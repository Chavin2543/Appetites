//
//  AddEventView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 18/5/2565 BE.
//

import SwiftUI

struct AddEventView: View {
    
    @EnvironmentObject private var eventService: EventDataService
    @EnvironmentObject private var userService: UserDataService
    var follower:[FollowerDetails]
    @State private var eventTitle:String = ""
    @State private var eventLocation:String = ""
    @State private var eventDescription:String = ""
    @Environment(\.presentationMode) private var presentationMode
    @State private var isInviting:Bool = false
    @State private var invitedPeople:[String] = []
    @State private var currentDate:Date = Date()
    
    var body: some View {
        ZStack {
            if !isInviting {
                VStack (spacing:30) {
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }

                        Text("Create Event")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.vertical,20)
                    Group {
                        TextField("Event Title", text: $eventTitle)
                        Divider()
                        TextField("Event Location", text: $eventLocation)
                        Divider()
                        TextField("Event Description", text: $eventDescription)
                        Divider()
                        Text("Event Date")
                        DatePicker("", selection: $currentDate, displayedComponents: [.date, .hourAndMinute])
                                    .labelsHidden()
                                    .id(currentDate)
                        Divider()
                        Spacer()
                    }
                    LongButton(title: .constant("Invite People"), color: .constant("NoirGreen")) {
                        withAnimation {
                            isInviting.toggle()
                        }
                    }
                }
            } else {
                EventInvitationPopupView(buttonAction: {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                    dateFormatter.calendar = NSCalendar(identifier: .gregorian) as Calendar?
                    let dateString = dateFormatter.string(from: currentDate)
                    eventService.createEvent(eventTitle: eventTitle, eventLocation: eventLocation, eventDescription: eventDescription, eventDate: dateString, eventMembersEmail: invitedPeople, token: userService.token)
                }, followers: follower, invitedEmail: $invitedPeople)
            }
        }
        .preferredColorScheme(.dark)
        .padding(32)
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(Color("NoirBG"))
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView(follower: [])
    }
}
