//
//  Follower.swift
//  Appetites
//
//  Created by chavin Panicharoen on 6/2/2565 BE.
//

//"followerCount": 2,
//    "followers": [
//        {
//            "followerEmail": "loong@email.com",
//            "followDate": "2022-01-27 18:09:21",
//            "followerUsername": "loong"
//        },
//        {
//            "followerEmail": "rungallday@gmail.com",
//            "followDate": "2022-01-22 17:58:41",
//            "followerUsername": "loongallday"
//        }
//    ]

import Foundation

struct Followers:Codable {
    var followerCount:Int
    var followers:[FollowerDetails]
}
