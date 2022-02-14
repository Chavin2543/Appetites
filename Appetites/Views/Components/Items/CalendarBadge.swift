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
                            Text("Calendar")
                                .font(.title2)
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.7), radius: 3, x: 1, y: 1)
                                .padding(.leading,32)
                            if let uiImage = UIImage(named: "Calendar")?.downsampled(by: 0.1) {
                                Image(uiImage:uiImage )
                                    .resizable()
                                    .frame(width: 180, height: 180, alignment: .center)
                                    .padding(.bottom,60)
                            }
                        }
                }

            }
        .frame(maxWidth:.infinity)
        .background(Color("NoirGreen").frame(height:124).cornerRadius(24.0))
    }
}

struct CalendarBadge_Previews: PreviewProvider {
    static var previews: some View {
        CalendarBadge(buttonAction: {
            print("H")
        })
    }
}
