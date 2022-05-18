//
//  DiscoverDataService.swift
//  Appetites
//
//  Created by chavin Panicharoen on 13/4/2565 BE.
//

import Foundation
import SwiftUI
import Combine

class DiscoverDataService : ObservableObject {
    @Published var displayPosts: [CardView] = []
    @Published var recommendedPost: [RecommendedPost] = []
    var cancellables = Set<AnyCancellable
    >()
    init() {
    }
    
    func retrieveRecommendedPost(token: String) {
        guard let url = URL(string: "https://appetite-backend-owen.herokuapp.com/getrecommends/token=\(token)") else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {return}
            
            guard error == nil else {return}
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            guard response.statusCode == 200 else {return}
            
            //MARK: To do Decode data
            do {
                let decodedRecommendedPost = try JSONDecoder().decode(RecommendedData.self,from: data)
                DispatchQueue.main.async {
                    self.recommendedPost.append(contentsOf: decodedRecommendedPost.recommendedPosts)
                    var views:[CardView] = []
                    for index in 0..<decodedRecommendedPost.recommendedPosts.count {
                        views.append(CardView(discovers: decodedRecommendedPost.recommendedPosts[index]))
                    }
                    self.displayPosts = views
                    print("Remove : \(decodedRecommendedPost.recommendedPosts)")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func logBookmark(token: String, postID: String) {
        let body = setBookMark(postID: postID)
        let url = PostHTTPManager().urlSetup(url: "https://appetite-backend-owen.herokuapp.com/bookmarkpost/token=\(token)")
        let urlRequest = PostHTTPManager().postRequestSetup(url: url, body: body)
        return URLSession.shared.dataTaskPublisher(for: urlRequest).subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap{ try PostHTTPManager().validateHTTPResponse($0.data, $0.response)}
            .decode(type: RecommendPost.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case.finished:
                    print("Post Bookmarked")
                case.failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { returnedValue in
                print("Bookmark Recommendation with ID: \(returnedValue.postID)" )
            }
            .store(in: &cancellables)
    }
                                            
    func setBookMark(postID:String) -> [String: Any] {
      [
        "postID": postID,
      ] as [String: Any]
    }
    
    deinit {}
}
