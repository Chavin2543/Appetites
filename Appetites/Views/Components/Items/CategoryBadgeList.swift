//
//  DiscoverBadgeList.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct CategoryBadgeList: View {
    var body: some View {
        ScrollView (.horizontal,showsIndicators: false) {
            HStack (spacing:16){
                CategoryBadge(title: "Local", icon: "Avatar1"){
                    print("Test")
                }
                CategoryBadge(title: "Local", icon: "Avatar1"){
                    print("Test")
                }
                CategoryBadge(title: "Local", icon: "Avatar1"){
                    print("Test")
                }
                CategoryBadge(title: "Local", icon: "Avatar1"){
                    print("Test")
                }
                CategoryBadge(title: "Local", icon: "Avatar1"){
                    print("Test")
                }
                CategoryBadge(title: "Local", icon: "Avatar1"){
                    print("Test")
                }
                CategoryBadge(title: "Local", icon: "Avatar1"){
                    print("Test")
                }
                CategoryBadge(title: "Local", icon: "Avatar1"){
                    print("Test")
                }
                CategoryBadge(title: "Local", icon: "Avatar1"){
                    print("Test")
                }
                CategoryBadge(title: "Local", icon: "Avatar1"){
                    print("Test")
                }
            }
            .frame(height: 208)
        }
    }
}

struct CategoryBadgeList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryBadgeList()
    }
}
