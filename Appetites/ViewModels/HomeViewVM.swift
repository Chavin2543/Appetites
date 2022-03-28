//
//  HomeViewVM.swift
//  Appetites
//
//  Created by chavin Panicharoen on 28/3/2565 BE.
//

import Foundation

class HomeViewVM:ObservableObject {
    
    @Published var feedPosts:GetPost = GetPost(email: "", token: "", expiresIn: "", postCount: 0, limit: 0, offset: 0, posts: [])
    
    init() {
        getPosts(token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImxhbGl0cmF0YW5hQGdtYWlsLmNvbSIsImV4cCI6MTY4MDE1NjQxNX0.jMKJIzjt06_97Jer8Sy2cT7ixyXJTvzqU3pIepMJeTQ", limit: "20", offset: "0")
    }
    
    func getPosts(token:String,limit:String,offset:String) {
        guard let url = URL(string: "https://appetite-backend-owen.herokuapp.com/getpostsfeed/token=\(token)/limit=\(limit)/offset=\(offset)") else {return}
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
                let decodedFeedPost = try JSONDecoder().decode(GetPost.self,from: data)
                
                DispatchQueue.main.async {
                    self.feedPosts = decodedFeedPost
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func likePosts(token:String,postID:String) {
        let body = likeInteractionBodySetup(postID: postID)
        let url = PostHTTPManager().urlSetup(url: "https://appetite-backend-owen.herokuapp.com/likepost/token=\(token)")
        let urlRequest = PostHTTPManager().postRequestSetup(url:url , body: body)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print("1")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("2")
                return
            }
            guard response.statusCode == 200 else {
                print("\(response.statusCode)")
                return
            }
            guard let data = data else {
                print("4")
                return
            }
            print("DEBUG: Like Post Successfully with data \(data)")
        }
        .resume()
    }
    
    func unlikePosts(token:String,postID:String) {
        let body = likeInteractionBodySetup(postID: postID)
        let url = PostHTTPManager().urlSetup(url: "https://appetite-backend-owen.herokuapp.com/unlikepost/token=\(token)")
        let urlRequest = PostHTTPManager().postRequestSetup(url:url , body: body)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {return}
            guard let response = response as? HTTPURLResponse else {
                return
            }
            guard response.statusCode == 200 else {return}
            guard let data = data else {
                return
            }
            print("DEBUG: Unlike Post Successfully with data \(data)")
        }
        .resume()
    }
    
    func likeInteractionBodySetup(postID:String) -> [String: Any] {
      [
        "postID": postID,
      ] as [String: Any]
    }
    
    deinit {}
}
