//
//  LocalUserInfo.swift
//  Appetites
//
//  Created by chavin Panicharoen on 6/2/2565 BE.
//

import Foundation

struct LocalUserInfo:Codable {
    var email:String? = nil
    var expiresIn:String? = nil
    var username:String? = nil
    var profilePictureLink:String? = nil
    var following:Int?
    var follower:Int?
    var followingDetails:[FollowingDetails]?
    var followerDetails:[FollowerDetails]?
    var registerDate:String? = nil
}
