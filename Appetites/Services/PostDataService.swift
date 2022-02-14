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
    @Published var post:GetPost = GetPost(email: "", token: "", expiresIn: "", postCount: 0, limit: 0, offset: 0, posts: [])
    
    init(){
        
    }
    
    
    func getPosts(token:String) {
        guard let url = URL(string:"https://appetite-backend-owen.herokuapp.com/getposts/token=\(token)/limit=20/offset=0") else {return}
                postSubscription = GetHTTPManager.download(url: url)
            .decode(type: GetPost.self, decoder: JSONDecoder())
                .sink(receiveCompletion: GetHTTPManager.handleCompletion, receiveValue: { [weak self] (returnedValue) in
                    print(returnedValue)
                    self?.post = returnedValue
                })
    }
    
    deinit{}
}
