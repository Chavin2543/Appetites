//
//  DiscoverTinderView.swift
//  Appetites
//
//  Created by chavin Panicharoen on 13/4/2565 BE.
//

import SwiftUI

struct DiscoverTinderView: View {
    @EnvironmentObject private var userService:UserDataService
    @EnvironmentObject private var postService:PostDataService
    @StateObject private var discoverService = DiscoverDataService()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DiscoverTinderView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverTinderView()
    }
}
