//
//  CalendarBadge.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct CalendarBadge: View {
    @State var buttonAction: () -> Void
    
    var body: some View {
        ZStack {
                Button {
                    buttonAction()
                } label: {
                        VStack {
                            Text("Calendar")
                                .padding(.top,24)
                                .font(.body.bold())
                                .foregroundColor(.white)
                            Image("Calendar")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                        }
                }

            }
        .frame(width:148,height:180)
        .background(Color("NoirGreen"))
        .cornerRadius(44.0)
    }
}

struct CalendarBadge_Previews: PreviewProvider {
    static var previews: some View {
        CalendarBadge(buttonAction: {
            print("H")
        })
    }
}
