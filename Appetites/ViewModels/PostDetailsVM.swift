//
//  PostDetailsVM.swift
//  Appetites
//
//  Created by chavin Panicharoen on 28/3/2565 BE.
//

import Foundation

class PostDetailsVM:ObservableObject {
    
    @Published var postDetails:PostDetails = PostDetails(postID: 0, postCaption: "", tagsList: [], postLocation: "", photoLinksList: [], postDate: "", likeCount: 0, commentCount: 0, isLiked: false, username: "", profilePictureLink: "", isBookmarked: false,comments: [])
    
    init() {
        
    }
    
    
    
}
