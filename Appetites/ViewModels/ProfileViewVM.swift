//
//  ProfileViewVM.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import Foundation


class ProfileViewVM: ObservableObject {
    @Published var inSettings:Bool = false
    @Published var inCalendar:Bool = false
    @Published var inPost:Bool = false
    @Published var isEditingProfile:Bool = false
    @Published var personalPost:GetPost = GetPost(email: "", token: "", expiresIn: "", postCount: 0, limit: 0, offset: 0, posts: [])
    
    init() {
    }

    func getPersonalPost(token:String) {
        guard let url = URL(string:"https://appetite-backend-owen.herokuapp.com/getposts/token=\(token)/limit=20/offset=0") else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {return}
            guard let response = response as? HTTPURLResponse else {
                return
            }
            guard response.statusCode == 200 else {return}
            guard let data = data else {
                return
            }
            do {
                let decodedPersonalPost = try JSONDecoder().decode(GetPost.self, from: data)
                DispatchQueue.main.async {
                    self.personalPost = decodedPersonalPost
                }
            } catch {
                print("DEBUG : \(error.localizedDescription)")
            }
        }
        .resume()
    }
    
    deinit {}
}

