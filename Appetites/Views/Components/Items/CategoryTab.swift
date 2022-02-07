//
//  CategoryTab.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct CategoryTab: View {
    @State var selectedTab:DiscoverCategory = .steak
    var body: some View {
        VStack (alignment:.leading) {
            ScrollView(.horizontal,showsIndicators: false){
                HStack (spacing:44) {
                    ForEach(categoryTabItems) { item in
                        Button {
                            selectedTab = item.tab
                        } label: {
                            Text("\(item.text)")
                                .font(.body)
                                .foregroundColor(Color("NoirGrayL"))
                        }
                        .frame(height: 74)

                    }
                }
                .padding(.leading,16)
            }
            Group {
                switch selectedTab {
                case .steak:
                    CategoryBadgeList()
                case .drinks:
                    CategoryBadgeList()
                case .snacks:
                    CategoryBadgeList()
                case .ramen:
                    CategoryBadgeList()
                case .noodle:
                    CategoryBadgeList()
                case .european:
                    CategoryBadgeList()
                case .mediterranean:
                    CategoryBadgeList()
                }
            }
        }
        .safeAreaInset(edge: .leading) {
            Color.clear
                .frame(width: 32, height: 0)
        }
    }
}

struct CategoryTab_Previews: PreviewProvider {
    static var previews: some View {
        CategoryTab()
    }
}
