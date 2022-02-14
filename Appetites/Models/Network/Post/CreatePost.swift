//
//  CreatePost.swift
//  Appetites
//
//  Created by chavin Panicharoen on 10/2/2565 BE.
//

import Foundation

struct CreatePost:Codable {
    var email, token, expiresIn: String
    var postID: Int
    var postCaption: String
    var tagsList: [String]
    var postLocation: String? = nil
    var photoLinksList: [String]
    var postDate: String
}
