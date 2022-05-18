//
//  EventDataService.swift
//  Appetites
//
//  Created by chavin Panicharoen on 22/3/2565 BE.
//

import Foundation
import Combine

struct CreatedEventResponse: Codable {
    var email:String
}

struct GetEventResponse:Codable {
    var events: [EventDetail]
}

struct EventDetail:Codable {
    var eventID: Int
    var eventLocation:String
    var eventTitle:String
    var eventDescription:String
    var eventDate:String
    var userEmail:String
    var isCreator:Bool
    var eventMembers : [EventMember]
    var extractedDate:Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        if let date = dateFormatter.date(from: eventDate) {
            return date
        } else {
            return Date()
        }
    }
}

struct EventMember:Codable {
    var email:String
    var username:String
    var profilePictureLink:String?
}

class EventDataService:ObservableObject {
    
    var event = GetEventResponse(events: [])
    var cancellables = Set<AnyCancellable>()
    var userSubscription: AnyCancellable?
    
    init() {
    }
    
    func getEvent(token:String,month:String,year:String) {
        print(token)
        guard let url = URL(string: "https://appetite-backend-owen.herokuapp.com/getevents/token=\(token)/month=\(month)/year=\(year)") else {return}
        print(url)
        userSubscription = GetHTTPManager.download(url: url)
            .decode(type: GetEventResponse.self
                    , decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("SUCCESS")
                case.failure(let error):
                    print(error)
                }
            }, receiveValue: { returnedValues in
                self.event = returnedValues
            })
    }
    
    func createEvent(eventTitle:String,eventLocation:String,eventDescription:String, eventDate:String,eventMembersEmail:[String],token:String) {
        let body = createEventBody(eventTitle: eventTitle, eventLocation: eventLocation, eventDescription: eventDescription, eventDate: eventDate, eventMembersEmail: eventMembersEmail)
        print(body)
        let url = PostHTTPManager().urlSetup(url: "https://appetite-backend-owen.herokuapp.com/createevent/token=\(token)")
        let urlRequest = PostHTTPManager().postRequestSetup(url: url, body: body)
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .tryMap({ try PostHTTPManager().validateHTTPResponse($0.data, $0.response) })
            .decode(type: CreatedEventResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case.failure(let error):
                    print(error)
                }
            }, receiveValue: { response in
                print(response)
            })
            .store(in: &cancellables)

    }
    
    func createEventBody(eventTitle:String, eventLocation:String, eventDescription:String, eventDate:String, eventMembersEmail:[String]) -> [String: Any] {
        [
            "eventTitle" : eventTitle,
            "eventLocation": eventLocation,
            "eventDescription": eventDescription,
            "eventDate": eventDate,
            "eventMembersEmail": eventMembersEmail
        ] as [String: Any]
    }
}
