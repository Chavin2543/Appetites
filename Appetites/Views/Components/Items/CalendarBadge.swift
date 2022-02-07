//
//  CalendarBadge.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct CalendarBadge: View {
    @State var buttonAction: () -> Void
    @Binding var registerDate:String?
    
    var body: some View {
        Button(action: buttonAction) {
            ZStack {
                Button {
                    print("Calendar")
                } label: {
                    HStack {
                        HStack {
                            RoundedRectangle(cornerRadius: 12.0)
                                .frame(width: 60, height: 60, alignment: .center)
                                .padding(.leading,24)
                            .foregroundStyle(Color("NoirGreen"))
                            VStack (alignment:.leading, spacing:8) {
                                Text("Calendar")
                                    .font(.footnote.bold())
                                    .foregroundStyle(Color("NoirGreen"))
                                Text("Since \(registerDate ?? "")")
                                    .font(.footnote)
                                    .foregroundStyle(Color("NoirGrayD"))
                            }
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .padding()
                            .foregroundStyle(.white)
                    }
                }

            }
            .frame(height:105)
            .frame(maxWidth:.infinity)
            .background(Color("NoirGreen").opacity(0.5))
            .cornerRadius(25.0)
        }
    }
}

struct CalendarBadge_Previews: PreviewProvider {
    static var previews: some View {
        CalendarBadge(buttonAction: {
            print("H")
        }, registerDate: .constant(""))
    }
}
