//
//  SearchViewVM.swift
//  Appetites
//
//  Created by chavin Panicharoen on 7/2/2565 BE.
//

import Foundation
import Combine

class SearchViewVM:ObservableObject {
    
    @Published var searchText:String = ""
    
    var searchSubscription:AnyCancellable?
    @Published var searchResult:SearchResult = SearchResult(searchResultCount: 0, searchResult: [SearchResultDetails(username: "", email: "", profilePictureLink: "")])
    
    init(){
        print("init search")
    }
    
    func search(token:String) {
        guard let url = URL(string:"https://appetite-backend-owen.herokuapp.com/searchuser/token=\(token)/searchText=\(searchText)") else {return}
                searchSubscription = GetHTTPManager.download(url: url)
            .decode(type: SearchResult.self, decoder: JSONDecoder())
                .sink(receiveCompletion: GetHTTPManager.handleCompletion, receiveValue: { [weak self] (returnedValue) in
                    self?.searchResult = returnedValue
                    print(returnedValue)
                })
    }
    
    
    deinit{
        print("deinit search")
    }
    
}
