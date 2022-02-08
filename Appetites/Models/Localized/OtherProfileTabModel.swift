//
//  OtherProfileTabModel.swift
//  Appetites
//
//  Created by chavin Panicharoen on 8/2/2565 BE.
//

import SwiftUI

struct OtherProfileTabModel:Identifiable {
    var id = UUID()
    var text: String
    var tab:OtherProfileTabs
}

var OtherProfileTabItem = [
    OtherProfileTabModel(text: "Posts", tab: .posts),
    OtherProfileTabModel(text: "Calendar", tab: .calendar)
]

enum OtherProfileTabs:String {
    case posts
    case calendar
}
