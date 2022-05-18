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
                    HStack {
                        Circle()
                            .frame(width:33)
                            .foregroundColor(Color("NoirGreen"))
                        Text("Calendar")
                            .font(.headline.bold())
                            .foregroundColor(.white)
                        Spacer()
                        ZStack {
                            Capsule()
                                .frame(width: 59, height: 24)
                            HStack (spacing:2) {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                                    .font(.system(size:10).bold())
                            }
                            
                        }
                        
                        
                    }
                }

            }
        .frame(height:33)
        .frame(maxWidth:.infinity)
    }
}

struct CalendarBadge_Previews: PreviewProvider {
    static var previews: some View {
        CalendarBadge(buttonAction: {
            print("H")
        })
        .background(.black)
    }
}
