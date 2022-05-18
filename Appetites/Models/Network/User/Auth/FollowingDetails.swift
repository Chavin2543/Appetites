//
//  FollowingDetails.swift
//  Appetites
//
//  Created by chavin Panicharoen on 6/2/2565 BE.
//


//"followingCount": 2,
//    "followings": [
//        {
//            "followedEmail": "armi4d@gmail.com",
//            "followDate": "2022-01-22 17:58:15",
//            "followedUsername": "armi4d"
//        },
//        {
//            "followedEmail": "rungallday@gmail.com",
//            "followDate": "2022-01-22 17:57:44",
//            "followedUsername": "loongallday"
//        }
//    ]
import Foundation

struct FollowingDetails:Codable,Identifiable {
    var followedEmail:String
    var followDate:String
    var followedUsername:String
    var id:String {
        followedEmail
    }
}
