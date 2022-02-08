//
//  UserDataService.swift
//  Appetites
//
//  Created by chavin Panicharoen on 2/2/2565 BE.
//

import Foundation
import Combine
import CoreData

class UserDataService : ObservableObject {
    
    let container:NSPersistentContainer = CoreDataManager.instance.container
    
    @Published var isLoading:Bool = false
    @Published var isAuthenticated = false
    
    @Published var user:LocalUserInfo = LocalUserInfo()
    
    @Published var userCredentials:[UserInformation] = []
    
    var token:String = ""
    
    var userSubscription: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    init() {
        if updateValidation() {
            isAuthenticated = true
            getUser()
        }
    }
    
    func login(email:String,password:String) {
        let body = loginBody(email: email, password: password)
        let url = PostHTTPManager().urlSetup(url: "https://appetite-backend-owen.herokuapp.com/login")
        let urlRequest = PostHTTPManager().postRequestSetup(url: url, body: body)
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap{ try PostHTTPManager().validateHTTPResponse ($0.data, $0.response) }
            .decode(type: Credentials.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case.finished:
                    print("Login Completed")
                case.failure(let error):
                    print("Login Failed: \(error)")
                }
            }, receiveValue: { [weak self] returnedValue in
                self?.token = returnedValue.token
                self?.setUserInfo()
            })
            .store(in: &cancellables)
      
        
        //TRADITIONAL DATATASK
//        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
//            guard let data = data else {
//                print("No data")
//                return
//            }
//
//            guard error == nil else {
//                print("Error: \(String(describing: error))")
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else {
//                print("Invalid Response.")
//                return
//            }
//
//            guard response.statusCode >= 200 && response.statusCode < 300 else {
//                print("Invalid URLResponse : \(response.statusCode)")
//                return
//            }
//
//            print("Successfully Logged in")
//            guard let newUser = try? JSONDecoder().decode(Credentials.self, from:data) else {return}
//            DispatchQueue.main.async {
//                self?.token = newUser.token
//                self?.setUserInfo()
//                self?.isAuthenticated = true
//            }
//        }
//        .resume()
    }

    
    //LOGIN POST REQUEST BODY
    func loginBody(email: String, password: String) -> [String: Any] {
      [
        "email": email,
        "password": password
      ] as [String: Any]
    }
    
    
    func updateValidation() -> Bool {
        let request = NSFetchRequest<UserInformation>(entityName: "UserInformation")
        do {
            if try !container.viewContext.fetch(request).isEmpty {
                userCredentials = try container.viewContext.fetch(request)
                token = userCredentials.first?.token ?? ""
                return true
            } else {
                print("No token in the system")
                return false
            }
        } catch let error {
            print("Error getting data. \(error)")
        }
        return false
    }
    
    func getUser() {
        let request = NSFetchRequest<UserInformation>(entityName: "UserInformation")
        do {
            userCredentials = try container.viewContext.fetch(request)
            let firstEntry = userCredentials.first
            user.email = firstEntry?.email
            user.profilePictureLink = firstEntry?.profilePictureLink
            user.username = firstEntry?.username
            user.expiresIn = firstEntry?.expiresIn
            user.registerDate = firstEntry?.registerDate
        } catch let error {
            print("\(error)")
        }
        
        getFollower()
    }

    
    func logout() {
        let request = NSFetchRequest<UserInformation>(entityName: "UserInformation")
        deleteCredentials(request: request)
        isAuthenticated = false
    }
    
    func deleteCredentials(request:NSFetchRequest<UserInformation>) {
        do {
            if try !container.viewContext.fetch(request).isEmpty {
                userCredentials = try container.viewContext.fetch(request)
                guard let entity = userCredentials.first else {return}
                container.viewContext.delete(entity)
                saveData()
            }
        } catch let error {
            print("Can't delete Credentials \(error)")
        }
    }
    
    
    func setUserInfo() {
        guard let url = URL(string:"https://appetite-backend-owen.herokuapp.com/getuserinfo/token=\(token)") else {return}
                userSubscription = GetHTTPManager.download(url: url)
            .decode(type: UserInfo.self, decoder: JSONDecoder())
                .sink(receiveCompletion: GetHTTPManager.handleCompletion, receiveValue: { [weak self] (returnedValue) in
                    self?.userSubscription?.cancel()
                    self?.storeUser(userInfo: returnedValue)
                    self?.getFollower()
                })
    }
    
    func getFollower() {
        guard let url = URL(string:"https://appetite-backend-owen.herokuapp.com/getfollower/token=\(token)") else {return}
                userSubscription = GetHTTPManager.download(url: url)
            .decode(type: Followers.self, decoder: JSONDecoder())
                .sink(receiveCompletion: GetHTTPManager.handleCompletion, receiveValue: { [weak self] (returnedValue) in
                    self?.getFollowing()
                    self?.userSubscription?.cancel()
                    self?.user.follower = returnedValue.followerCount
                    self?.user.followerDetails = returnedValue.followers
                })
    }
    
    func getFollowing() {
        guard let url = URL(string:"https://appetite-backend-owen.herokuapp.com/getfollowing/token=\(token)") else {return}
                userSubscription = GetHTTPManager.download(url: url)
            .decode(type: Followings.self, decoder: JSONDecoder())
                .sink(receiveCompletion: GetHTTPManager.handleCompletion, receiveValue: { [weak self] (returnedValue) in
                    self?.userSubscription?.cancel()
                    self?.user.following = returnedValue.followingCount
                    self?.user.followingDetails = returnedValue.followings
                    self?.isAuthenticated = true
                })
    }
    
    func storeUser(userInfo:UserInfo) {
        let currentUserInfo = UserInformation(context: container.viewContext)
        currentUserInfo.token = self.token
        currentUserInfo.username = userInfo.username
        currentUserInfo.email = userInfo.email
        currentUserInfo.expiresIn = userInfo.expiresIn
        currentUserInfo.profilePictureLink = userInfo.profilePictureLink
        currentUserInfo.registerDate = userInfo.registerDate
        saveData()
        storeLocalUser(userInfo: userInfo)
    }
    
    func storeLocalUser(userInfo:UserInfo) {
        user.username = userInfo.username
        user.profilePictureLink = userInfo.profilePictureLink
        user.email = userInfo.email
        user.expiresIn = userInfo.expiresIn
        user.registerDate = userInfo.registerDate
        //print(user.registerDate)
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            print("Data saved")
        } catch let error {
            print("Error saving data \(error)")
        }
    }
    
    deinit{
    }
}




