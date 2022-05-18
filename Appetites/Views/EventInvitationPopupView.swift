//
//  EventInvitationPopupView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 18/5/2565 BE.
//

import SwiftUI

struct EventInvitationPopupView: View {
    @State var buttonAction: () -> Void
    var followers:[FollowerDetails]
    @Binding var invitedEmail:[String]
    @Environment(\.presentationMode) private var presentationMode
    @State private var isLoading:Bool = false
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    BackButton(){
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
                .padding(4)
                ForEach(followers) { follower in
                    HStack {
                        Text(follower.followerUsername)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text(follower.followerEmail)
                            .font(.system(size:10))
                            .foregroundColor(.white)
                        Spacer()
                        Button("Invite") {
                            invitedEmail.append(follower.followerEmail)
                        }
                        .padding(5)
                        .background(invitedEmail.contains(where: { $0 == follower.followerEmail }) ? Color("NoirYellow") : Color("NoirGreen"))
                        .cornerRadius(10)
                        .opacity(invitedEmail.contains(where: { $0 == follower.followerEmail }) ? 0 : 1)
                        .foregroundColor(.black)
                        .font(.system(size: 14))
                        
                    }
                    .padding(.horizontal,4)
                }
                Spacer()
                LongButton(title: .constant("Create Event"), color: .constant("NoirGreen")) {
                    isLoading.toggle()
                    buttonAction()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isLoading.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            if isLoading {
                ProgressView("Loading")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("NoirGreen"))
                    .cornerRadius(10)
            }
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(Color("NoirBG"))
    }
}

struct EventInvitationPopupView_Previews: PreviewProvider {
    static var previews: some View {
        EventInvitationPopupView(buttonAction: {
            print("HELLO")
        }, followers: [], invitedEmail: .constant(["Hello"]))
    }
}
