//
//  NetworkManager.swift
//  Appetites
//
//  Created by chavin Panicharoen on 2/2/2565 BE.
//

import Foundation
import Combine

class PostHTTPManager {
    
    func urlSetup(url:String) -> URL {
        guard let url = URL(string: url) else {fatalError("Invalid URL")}
        return url
    }
    
    func postRequestSetup(url: URL,
                          body: [String: Any]) -> URLRequest {

      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "POST"
      urlRequest.setValue("application/json",
                          forHTTPHeaderField: "Content-Type")
      urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)

      return urlRequest
    }
    
    //VALIDATE RESPONSE
     func validateHTTPResponse(_ data: Data, _ response: URLResponse) throws -> Data {
       guard let httpResponse = response as? HTTPURLResponse else {
         throw NetworkError.responseinvalid
       }
       guard (200..<300).contains(httpResponse.statusCode) else {
         throw networkRequestError(from: httpResponse.statusCode)
       }
       return data
     }
    
    //SEND OUT ERRORS
    func networkRequestError(from statusCode: Int) -> Error {
        switch statusCode {
        case 401:
          return NetworkError.unauthorized
        default:
          return NetworkError.unknown
        }
      }
    
    func download(url:URL) -> AnyPublisher<Data,Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .receive(on: DispatchQueue.main)
            .tryMap{ try PostHTTPManager().validateHTTPResponse ($0.data, $0.response) }
            .eraseToAnyPublisher()
    }
    
    //ERROR TYPE
    enum NetworkError: Error, Equatable {

        case unauthorized
        case responseinvalid
        case unknown
      }
    
    deinit {
        print("HTTPManager has been deinitiated")
    }
    
}

