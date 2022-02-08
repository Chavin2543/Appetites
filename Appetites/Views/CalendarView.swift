//
//  CalendarView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 31/1/2565 BE.
//

import SwiftUI

struct CalendarView: View {
    @State var date:Date = Date()
    @Environment(\.presentationMode) private var presentationMode
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
                        SearchButton(){
                            print("Search")
                        }
                    }
                    .frame(width: geometry.size.width-64, height: 97, alignment: .center)
                    CustomDatePicker(currentDate:$date)
                        .frame(width:geometry.size.width-32)
                    Spacer()
                    LongButton(title: "Add Event", color: "NoirGreen") {
                        print("Add Event")
                    }
                    .frame(width:geometry.size.width-54)
                }
            }
            .frame(maxWidth:.infinity)
            .background(Color("NoirBG"))
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
