//
//  DiscoverDataService.swift
//  Appetites
//
//  Created by chavin Panicharoen on 13/4/2565 BE.
//

import Foundation

class DiscoverDataService : ObservableObject {
    
    @Published var recommendedPost = []
    
    init() {
        retrieveRecommendedPost()
    }
    
    func retrieveRecommendedPost() {
        guard let url = URL(string: "https://appetite-backend-owen.herokuapp.com/getrecommends/token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImxhbGl0cmF0YW5hQGdtYWlsLmNvbSIsImV4cCI6MTY4NTMyNjgzMX0.TSQ-SLV_Kos844sdyVoVJwfJtSR3T6uQDS81nim9Rkk") else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {return}
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            guard response.statusCode == 200 else {return}
            
            //MARK: To do Decode data
            print(data)
        }
        
        
        
        
    }
    
    func logBookmark() {
        
    }
    
    deinit {}
}
