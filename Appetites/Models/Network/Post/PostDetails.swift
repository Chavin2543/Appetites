//
//  PostDetails.swift
//  Appetites
//
//  Created by chavin Panicharoen on 11/2/2565 BE.
//

import Foundation

struct PostDetails:Identifiable,Codable {
    var postID:Int
    var postCaption:String?
    var tagsList:[String]?
    var postLocation:String? = nil
    var photoLinksList:[String]?
    var postDate:String?
    var likeCount:Int?
    var commentCount:Int?
    var isLiked:Bool?
    var username:String?
    var profilePictureLink:String?
    var isBookmarked:Bool?
    var comments:[CommentDetail]?
    
    var id:Int {
        postID
    }
}
