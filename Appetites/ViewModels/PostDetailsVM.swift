//
//  PostDetailsVM.swift
//  Appetites
//
//  Created by chavin Panicharoen on 28/3/2565 BE.
//

import Foundation

class PostDetailsVM:ObservableObject {
    @Published var commentText:String = ""
    @Published var postDetails:PostDetails = PostDetails(postID: 0, postCaption: "", tagsList: [], postLocation: "", photoLinksList: [], postDate: "", likeCount: 0, commentCount: 0, isLiked: false, username: "", profilePictureLink: "", isBookmarked: false,comments: [])
    
    init() {
        
    }
    
    func getPostDetail(token:String,postID:String) {
        guard let url = URL(string: "https://appetite-backend-owen.herokuapp.com/getpostinfo/token=\(token)/postID=\(postID)") else {return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {return}
            guard let data = data else {
                return
            }
            guard let response = response as? HTTPURLResponse else {
                return
            }

            guard response.statusCode == 200 else {return}
            do {
                let decodedDetails = try JSONDecoder().decode(PostDetails.self, from: data)
                DispatchQueue.main.async {
                    self.postDetails = decodedDetails
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }
        .resume()
    }
    
    func commentPost(token:String,postID:String,comment:String) {
        let body = setCommentPostBody(postID: postID, comment: comment)
        let url = PostHTTPManager().urlSetup(url: "https://appetite-backend-owen.herokuapp.com/commentpost/token=\(token)")
        let urlRequest = PostHTTPManager().postRequestSetup(url: url, body: body)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {return}
            guard let data = data else {
                return
            }
            guard let response = response as? HTTPURLResponse else {
                return
            }

            guard response.statusCode == 200 else {return}
            print("DEBUG: Comment Successfully with metadata \(data)")
        }
        .resume()
    }
    
    func setCommentPostBody(postID:String,comment:String) -> [String:Any] {
        [
            "postID" : postID,
            "comment" : comment
        ] as [String:Any]
    }
    
}
