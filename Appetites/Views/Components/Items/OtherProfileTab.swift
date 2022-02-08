//
//  OtherProfileTab.swift
//  Appetites
//
//  Created by chavin Panicharoen on 8/2/2565 BE.
//

import SwiftUI

struct OtherProfileTab: View {
    @State var selectedTab:OtherProfileTabs = .posts
    @State var date:Date = Date()
    var body: some View {
        VStack (alignment:.center) {
                HStack (spacing:44) {
                    ForEach(OtherProfileTabItem) { item in
                        Button {
                            selectedTab = item.tab
                        } label: {
                            Text("\(item.text)")
                                .font(.body)
                                .foregroundColor(item.tab == selectedTab ? Color("NoirGreen") : Color("NoirGrayL"))
                        }
                        .frame(height: 74)

                    }
                }
            Group {
                switch selectedTab {
                case .posts:
                    ScrollView {
                        VStack(spacing:20) {
                                ForEach(0..<10) { item in
                                    ProfilePost()
                                        .frame(height:352)
                                }
                        }
                    }
                case .calendar:
                    VStack (spacing:20) {
                    CustomDatePicker(currentDate: $date)
                    }
                }
            }
        }
    }
    }

struct OtherProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        OtherProfileTab()
            .background(.black)
    }
}
