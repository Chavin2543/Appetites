//
//  PostComponentData.swift
//  Appetites
//
//  Created by Ghandhi Thamthiwat on 8/2/2565 BE.
//

import Foundation

struct PostComponentData : Identifiable {
    var ownerpic: String
    var ownername: String
    var datetime: String
    var caption: String
    var foodpicture: String
    var likestatus: Bool
    var likecount: Int
    var commentcount: Int
    var userpic: String
    
    var id:String {
        ownerpic
    }
    
}
