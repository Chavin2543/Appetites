//
//  HoneymoonModelList.swift
//  Appetites
//
//  Created by Ghandhi Thamthiwat on 8/2/2565 BE.
//

import Foundation
struct HoneymoonModelList {
    var discovers:[DiscoverMenu]
}

//MARK: DATA FROM OWEN, TO BE DEVELOPED
var discoverdataOnline: [DiscoverMenuOnline] = [
    DiscoverMenuOnline(
      id: 0,
      foodname: "Bravo Pizza",
      restaurantname: "Italian Gump",
      imageURL: "photo-1",
      //price: "990THB",
      foodtag: "Italian Cuisine",
      //star: 2,
      like: 10
    )
]


var discoverdata: [DiscoverMenu] = [
    DiscoverMenu(
      id: 1,
      foodname: "Bravo Pizza",
      restaurantname: "Italian Gump",
      image: "photo-1",
      //price: "990THB",
      foodtag: "Italian Cuisine",
      //star: 2,
      like: 10
    ),
    DiscoverMenu(
        id: 2,
      foodname: "Tom Yum Goong",
      restaurantname: "Thai Paragon",
      image: "photo-2",
      //price: "299THB",
      foodtag: "Thai Cuisine",
      //star: 1,
      like: 53
    ),
    DiscoverMenu(
        id: 3,
      foodname: "Chef Salad",
      restaurantname: "ShitShef",
      image: "photo-3",
      //price: "50THB",
      foodtag: "Heathy Cuisine",
      //star: 5,
      like: 147
    ),
    DiscoverMenu(
        id: 4,
      foodname: "Fish and Shit",
      restaurantname: "Fuck Off Restaurant",
      image: "photo-4",
      //price: "99THB",
      foodtag: "British Cuisine",
      //star: 2,
      like: 61
    ),
    DiscoverMenu(
        id: 4,
      foodname: "Fried Rice",
      restaurantname: "Neighbourhood Place",
      image: "photo-5",
      //price: "1999THB",
      foodtag: "Asian Cuisine",
      //star: 4,
      like: 554
    )
]
