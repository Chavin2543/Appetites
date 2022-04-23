//
//  DiscoverTinderOnline.swift
//  Appetites
//
//  Created by Ghandhi Thamthiwat on 23/4/2565 BE.
//


import Foundation

struct RecommendedData:Codable {
    let email, token, expiresIn: String?
    let recommendedCount: Int?
    let recommendedPosts: [RecommendedPost]
}

struct RecommendedPost: Codable,Identifiable {
    let postID: Int
    let username: String?
    let tagsList: [String]?
    let postLocation: String?
    let photoLinksList: [String]?
    let likeCount: Int?
    var id:Int {
        postID
    }
}

