//
//  GetPost.swift
//  Appetites
//
//  Created by chavin Panicharoen on 11/2/2565 BE.
//

import Foundation

struct GetPost:Codable {
    var email:String
    var token:String
    var expiresIn:String
    var postCount:Int
    var limit:Int
    var offset:Int
    var posts:[PostDetails]
}
