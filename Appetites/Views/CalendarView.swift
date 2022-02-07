//
//  CalendarView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 31/1/2565 BE.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    HStack {
                        HStack {
                            BackButton(){
                                print("Back")
                            }
                        }
                        Spacer()
                        SearchButton(){
                            print("Search")
                        }
                    }
                    .frame(width: geometry.size.width-64, height: 97, alignment: .center)
                    Text("January")
                        .font(.body.bold())
                        .foregroundStyle(Color("NoirGrayL"))
                    Spacer()
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
