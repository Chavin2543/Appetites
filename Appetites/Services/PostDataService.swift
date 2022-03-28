//
//  PostDataService.swift
//  Appetites
//
//  Created by chavin Panicharoen on 10/2/2565 BE.
//

import Foundation
import SwiftUI
import Combine

class PostDataService : ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    var postSubscription: AnyCancellable?
    var feedSubscription:AnyCancellable?
    var otherUserPostSubscription:AnyCancellable?
    var singlePostSubscription:AnyCancellable?
    @Published var post:GetPost = GetPost(email: "", token: "", expiresIn: "", postCount: 0, limit: 0, offset: 0, posts: [])
    @Published var feed:GetPost = GetPost(email: "", token: "", expiresIn: "", postCount: 0, limit: 0, offset: 0, posts: [])
    @Published var targetPost:PostDetails = PostDetails(postID: 0, postCaption: "", tagsList: [], postLocation: "", photoLinksList: [], postDate: "", likeCount: 0, commentCount: 0, isLiked: false, username: "", profilePictureLink: "", isBookmarked: false, comments: [])
    @Published var otherUserPost:GetPost = GetPost(email: "", token: "", expiresIn: "", postCount: 0, limit: 0, offset: 0, posts: [])
    
    init(){
        
    }
    
    func getSinglePost(token:String, postID:String) {
        print("Getting post with id : \(postID)")
        guard let url = URL(string: "https://appetite-backend-owen.herokuapp.com/getpostinfo/token=\(token)/postID=\(postID)") else {return }
        singlePostSubscription = GetHTTPManager.download(url: url)
            .decode(type: PostDetails.self, decoder: JSONDecoder())
            .sink(receiveCompletion: GetHTTPManager.handleCompletion, receiveValue: { [weak self] returnedValue in
                self?.targetPost = returnedValue
                print(returnedValue)
            })
    }
    
    func getPosts(token:String) {
        guard let url = URL(string:"https://appetite-backend-owen.herokuapp.com/getposts/token=\(token)/limit=20/offset=0") else {return}
                postSubscription = GetHTTPManager.download(url: url)
            .decode(type: GetPost.self, decoder: JSONDecoder())
                .sink(receiveCompletion: GetHTTPManager.handleCompletion, receiveValue: { [weak self] (returnedValue) in
                    self?.post = returnedValue
                })
    }
    
    func getFeedPosts(token:String,limit:String,offset:String) {
        guard let url = URL(string: "https://appetite-backend-owen.herokuapp.com/getpostsfeed/token=\(token)/limit=\(limit)/offset=\(offset)") else {return}
        feedSubscription = GetHTTPManager.download(url: url)
            .decode(type:GetPost.self , decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case.finished:
                    print("Feed Retrieved")
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] returnedValue in
                self?.feed = returnedValue
            })
    }
    
    func getOtherUserPosts(token:String,otherEmail:String,limit:String,offset:String) {
        guard let url = URL(string: "https://appetite-backend-owen.herokuapp.com/getotheruserposts/token=\(token)/otherEmail=\(otherEmail)/limit=\(limit)/offset=\(offset)") else {return}
        otherUserPostSubscription = GetHTTPManager.download(url: url)
            .decode(type: GetPost.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case.finished:
                    print("Retrieved \(otherEmail)'s post")
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] returnedValue in
                self?.otherUserPost = returnedValue
                print(returnedValue)
            })
        
        
    }
    
    func likePosts(token:String, postID:String) {
        let body = setLikePostBody(postID: postID)
        let url = PostHTTPManager().urlSetup(url: "https://appetite-backend-owen.herokuapp.com/likepost/token=\(token)")
        let urlRequest = PostHTTPManager().postRequestSetup(url:url , body: body)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap{ try PostHTTPManager().validateHTTPResponse($0.data, $0.response)}
            .decode(type: LikePost.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case.finished:
                    print("Post Liked")
                case.failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { returnedValue in
                print("Liked Post with ID: \(returnedValue.postID)" )
            }
            .store(in: &cancellables)
    }
    
    func unlikePost(token:String, postID:String) {
        let body = setLikePostBody(postID: postID)
        let url = PostHTTPManager().urlSetup(url: "https://appetite-backend-owen.herokuapp.com/unlikepost/token=\(token)")
        let urlRequest = PostHTTPManager().postRequestSetup(url:url , body: body)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap{ try PostHTTPManager().validateHTTPResponse($0.data, $0.response)}
            .decode(type: LikePost.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case.finished:
                    print("Post Unliked")
                case.failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { returnedValue in
                print("Unliked Post with ID: \(returnedValue.postID)" )
            }
            .store(in: &cancellables)
    }
    
    func commentPost(token:String,postID:String,comment:String) {
        let body = setCommentPostBody(postID: postID, comment: comment)
        let url = PostHTTPManager().urlSetup(url: "https://appetite-backend-owen.herokuapp.com/commentpost/token=\(token)")
        let urlRequest = PostHTTPManager().postRequestSetup(url: url, body: body)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap{ try PostHTTPManager().validateHTTPResponse($0.data, $0.response)}
            .sink { completion in
                switch completion {
                case.finished:
                    print("Comment success")
                case.failure(let error):
                    print("Comment Failed \(error.localizedDescription)")
                }
            } receiveValue: { returnedValue in
                print("\(returnedValue)")
            }
            .store(in: &cancellables)
    }
    
    func bookmarkPost(token:String,postID:String) {
        let body = setBookmarkPostBody(postID: postID)
        let url = PostHTTPManager().urlSetup(url: "https://appetite-backend-owen.herokuapp.com/bookmarkpost/token=\(token)")
        let urlRequest = PostHTTPManager().postRequestSetup(url: url, body: body)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap{ try PostHTTPManager().validateHTTPResponse($0.data, $0.response)}
            .sink { completion in
                switch completion {
                case.finished:
                    print("Bookmark Success")
                case.failure(let error):
                    print("Bookmark Failed \(error.localizedDescription)")
                }
            } receiveValue: { returnedValue in
                print("\(returnedValue)")
            }
            .store(in: &cancellables)
    }
    
    func unbookmarkPost(token:String,postID:String) {
        let body = setBookmarkPostBody(postID: postID)
        let url = PostHTTPManager().urlSetup(url: "https://appetite-backend-owen.herokuapp.com/unbookmarkpost/token=\(token)")
        let urlRequest = PostHTTPManager().postRequestSetup(url: url, body: body)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap{ try PostHTTPManager().validateHTTPResponse($0.data, $0.response)}
            .sink { completion in
                switch completion {
                case.finished:
                    print("Unbookmark Success")
                case.failure(let error):
                    print("Unbookmark Failed \(error.localizedDescription)")
                }
            } receiveValue: { returnedValue in
                print("\(returnedValue)")
            }
            .store(in: &cancellables)
    }
    
    func setLikePostBody(postID:String) -> [String: Any] {
      [
        "postID": postID,
      ] as [String: Any]
    }
    
    func setBookmarkPostBody(postID:String) -> [String: Any] {
      [
        "postID": postID,
      ] as [String: Any]
    }
    
    func setCommentPostBody(postID:String,comment:String) -> [String:Any] {
        [
            "postID" : postID,
            "comment" : comment
        ] as [String:Any]
    }
    
    deinit{}
}
