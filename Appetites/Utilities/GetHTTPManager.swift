//
//  GetHTTPManager.swift
//  Appetites
//
//  Created by chavin Panicharoen on 4/2/2565 BE.
//

import Foundation
import Combine

class GetHTTPManager {
    
    enum NetworkingError:LocalizedError {
        case badURLResponse
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse:
                return "BAD REQUEST"
            case .unknown:
                return "INTERNAL ERROR"
            }
        }
    }
    
    static func download(url:URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handleURLResponse(output:$0)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output:URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                  throw NetworkingError.badURLResponse
              }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case.finished:
            break
        case.failure(let error):
            print(error.localizedDescription)
        }
    }
    
    deinit{}
}
