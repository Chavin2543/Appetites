//
//  OtherProfileViewVM.swift
//  Appetites
//
//  Created by chavin Panicharoen on 9/2/2565 BE.
//

import Foundation
import Combine

class OtherProfileViewVM : ObservableObject {
    
    @Published var token:String = ""
    @Published var isFollowing:Bool = false
    @Published var userSubscription:AnyCancellable?
    @Published var user:LocalUserInfo = LocalUserInfo()
    @Published var dataFromSearch:SearchResultDetails = SearchResultDetails(username: "", email: "", profilePictureLink: "")
    @Published var isLoading:Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    init(token:String,user:SearchResultDetails) {
        self.token = token
        self.dataFromSearch = user
        getFollower()
    }
    
    func getFollower() {
        self.isLoading = true
        guard let url = URL(string: "https://appetite-backend-owen.herokuapp.com/getotheruserfollower/token=\(token)/otherEmail=\(dataFromSearch.email)") else {return}
        userSubscription = GetHTTPManager.download(url: url)
            .decode(type: Followers.self, decoder: JSONDecoder())
            .sink(receiveCompletion: GetHTTPManager.handleCompletion, receiveValue: { [weak self] (returnedValue) in
                self?.user.follower = returnedValue.followerCount
                print(returnedValue.followerCount)
                self?.getFollowing()
            })
    }
    
    func getFollowing() {
        guard let url = URL(string: "https://appetite-backend-owen.herokuapp.com/getotheruserfollowing/token=\(token)/otherEmail=\(dataFromSearch.email)") else {return}
        userSubscription = GetHTTPManager.download(url: url)
            .decode(type: Followings.self, decoder: JSONDecoder())
            .sink(receiveCompletion: GetHTTPManager.handleCompletion, receiveValue: { [weak self] (returnedValue) in
                self?.user.following = returnedValue.followingCount
                print(returnedValue.followingCount)
                self?.isFollow()
            })
    }
    
    func isFollow() {
        guard let url = URL(string: "https://appetite-backend-owen.herokuapp.com/isfollowed/token=\(token)/checkEmail=\(dataFromSearch.email)") else {return}
        userSubscription = GetHTTPManager.download(url: url)
            .decode(type: IsFollowed.self, decoder: JSONDecoder())
            .sink(receiveCompletion: GetHTTPManager.handleCompletion, receiveValue: { [weak self] (returnedValue) in
                self?.isFollowing = returnedValue.isFollowed
                self?.isLoading = false
                print(returnedValue.isFollowed)
            })
    }
    
    func follow() {
        let body = followBody(email: dataFromSearch.email)
        let url = PostHTTPManager().urlSetup(url: "https://appetite-backend-owen.herokuapp.com/followuser/token=\(token)")
        let urlRequest = PostHTTPManager().postRequestSetup(url: url, body: body)
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap{try PostHTTPManager().validateHTTPResponse($0.data, $0.response)}
            .decode(type: Follow.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case.finished:
                    print("Follow Completed")
                case.failure(let error):
                    print("Follow Failed: \(error)")
                }
            }, receiveValue: { [weak self] returnedValue in
                print("\(returnedValue)")
                self?.isFollowing = true
                self?.user.follower! += 1
            })
            .store(in: &cancellables)
    }
    
    func unfollow() {
        let body = unfollowBody(email: dataFromSearch.email)
        let url = PostHTTPManager().urlSetup(url: "https://appetite-backend-owen.herokuapp.com/unfollowuser/token=\(token)")
        let urlRequest = PostHTTPManager().postRequestSetup(url: url, body: body)
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap{try PostHTTPManager().validateHTTPResponse($0.data, $0.response)}
            .decode(type: Unfollow.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case.finished:
                    print("Unfollow Completed")
                case.failure(let error):
                    print("Unfollow Failed: \(error)")
                }
            }, receiveValue: { [weak self] returnedValue in
                print("\(returnedValue)")
                self?.isFollowing = false
                self?.user.follower! -= 1
            })
            .store(in: &cancellables)
    }
    
    func followBody(email: String) -> [String: Any] {
      [
        "followedEmail": email,
      ] as [String: Any]
    }
    
    func unfollowBody(email: String) -> [String: Any] {
      [
        "unfollowedEmail": email,
      ] as [String: Any]
    }

    
    deinit{}
}
