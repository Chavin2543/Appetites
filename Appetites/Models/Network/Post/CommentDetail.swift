//
//  Comment.swift
//  Appetites
//
//  Created by chavin Panicharoen on 28/3/2565 BE.
//

import Foundation

struct CommentDetail:Codable {
    var userEmail:String
    var username:String?
    var profilePictureLink:String?
    var comment:String
    var commentDate:String
    
    var id:String {
        userEmail + comment + commentDate
    }
}
