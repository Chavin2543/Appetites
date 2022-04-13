//
//  PostViewVM.swift
//  Appetites
//
//  Created by chavin Panicharoen on 10/2/2565 BE.
//

import Foundation
import SwiftUI
import Combine

class PostViewVM : ObservableObject {
    @Published var caption:String = ""
    @Published var showImagePicker:Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    init(){
        print("Init Post")
    }
    
    func uploadPostPhoto(image:UIImage?,token:String,caption:String,foodTags:[String]) {
        let filename = UUID().uuidString
        let ref = FirebaseManager.shared.storage.reference(withPath: filename)
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else {return}
        ref.putData(imageData,metadata: nil) { metadata , error in
            if let error = error {
                print("Upload Failed \(error)")
                return
            }
            ref.downloadURL { url, error in
                if let error = error {
                    print("Upload Failed, Exit with : \(error)")
                    return
                }
                print("Upload success url : \(url?.absoluteString ?? "")")
                guard let targetUrl = url?.absoluteString else {return}
                self.createPost(token: token, url: targetUrl, caption: caption, foodTags: foodTags)
            }
        }
        
    }
    
    func createPost(token:String,url:String,caption:String,foodTags:[String]) {
        let body = setPostBody(url: url, caption: caption, foodTags: foodTags)
        let url = PostHTTPManager().urlSetup(url: "https://appetite-backend-owen.herokuapp.com/createpost/token=\(token)")
        let urlRequest = PostHTTPManager().postRequestSetup(url: url, body: body)
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap{try PostHTTPManager().validateHTTPResponse($0.data, $0.response)}
            .decode(type: CreatePost.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case.finished:
                    print("Setup Completed")
                case.failure(let error):
                    print("Setup Failed: \(error)")
                }
            }, receiveValue: { [weak self] returnedValue in
                print("\(returnedValue)")
                
            })
            .store(in: &cancellables)
    }
    
    func setPostBody(url:String,caption:String,foodTags:[String]) -> [String: Any] {
      [
        "tagsList" : foodTags,
        "photoLinksList": [url],
        "postCaption" : caption
      ] as [String: Any]
    }
    
    deinit{
        print("deinit Post")
    }
}
