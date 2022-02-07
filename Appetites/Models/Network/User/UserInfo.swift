//
//  UserInfo.swift
//  Appetites
//
//  Created by chavin Panicharoen on 5/2/2565 BE.
//

import Foundation

struct UserInfo :Codable {
    var email:String
    var expiresIn:String
    var username:String
    var profilePictureLink:String?
    var registerDate:String
}
