//
//  DiscoverTinderModelList.swift
//  Appetites
//
//  Created by Ghandhi Thamthiwat on 13/4/2565 BE.
//

import SwiftUI

struct DiscoverTinderModelList {
    
}

var discoverTinder: [DiscoverTinderMenu] = [
    DiscoverTinderMenu(
      id: 1,
      foodName: "Bravo Pizza",
      restaurantName: "Italian Gump",
      imageURL: "photo-1",
      //price: "990THB",
      foodTag: ["Italian Cuisine","Dinner"],
      //star: 2,
      like: 10
    ),
    DiscoverTinderMenu(
        id: 2,
        foodName: "Tom Yum Goong",
        restaurantName: "Thai Paragon",
        imageURL: "photo-2",
        //price: "299THB",
        foodTag: ["Thai Cuisine","Soup","Dinner"],
      //star: 1,
      like: 53
    ),
    DiscoverTinderMenu(
        id: 3,
        foodName: "Chef Salad",
        restaurantName: "ShitShef",
        imageURL: "photo-3",
        //price: "50THB",
        foodTag: ["Heathy Cuisine"],
      //star: 5,
        like: 147
    )
]
