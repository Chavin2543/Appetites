//
//  OtherProfileView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 7/2/2565 BE.
//

import SwiftUI

struct OtherProfileView: View {
    @State var username:String
    var body: some View {
        Text("\(username)")
    }
}

struct OtherProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OtherProfileView(username: "Username")
    }
}
