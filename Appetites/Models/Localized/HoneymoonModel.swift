//
//  HoneymoonModel.swift
//  Appetites
//
//  Created by Ghandhi Thamthiwat on 8/2/2565 BE.
//

import SwiftUI

struct DiscoverMenu: Decodable, Identifiable {
    var id: Int
    var foodname: String
    var restaurantname: String
    var image: String
    //var price: String
    var foodtag: String
    //var star: Int
    var like: Int
    
    //postid is pk
    
}

struct DiscoverMenuOnline: Decodable, Identifiable {
    var id: Int
    var foodname: String
    var restaurantname: String
    var imageURL: String
    //var price: String
    var foodtag: String
    //var star: Int
    var like: Int
    
    //postid is pk
}

struct AppetiteResponse: Decodable {
    let request: [DiscoverMenuOnline]
}
