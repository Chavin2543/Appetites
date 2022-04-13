//
//  DiscoverTinderModel.swift
//  Appetites
//
//  Created by Ghandhi Thamthiwat on 13/4/2565 BE.
//

import SwiftUI

struct DiscoverTinderMenu: Decodable, Identifiable {
    
    var id: Int
    var foodName: String
    var restaurantName: String
    var imageURL: String
    var foodTag: [String]
    var like: Int
    
}
