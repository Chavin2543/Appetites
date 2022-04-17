//
//  DiscoverTinder.swift
//  Appetites
//
//  Created by chavin Panicharoen on 13/4/2565 BE.
//

import Foundation

struct DiscoverTinder : Codable, Identifiable {
    var id : Int
    var restaurantName: String
    var foodName: String
    var imageURL: String
    var foodTag: [String]
    var like: Int
}

var DiscoverTinderMenu: [DiscoverTinder] = [
    DiscoverTinder(id: 1,
        restaurantName: "Starsucks",
        foodName: "Latte without Milk",
        imageURL: "mockdisctintwo",
        foodTag: ["Coffee", "Dessert"],
        like: 3
              ),
    DiscoverTinder(id: 1,
        restaurantName: "Pizza Accompany",
        foodName: "Hawaiier Pizza",
        imageURL: "mockdisctinone",
        foodTag: ["Italian"],
        like: 3
)]
