//
//  SearchResult.swift
//  Appetites
//
//  Created by chavin Panicharoen on 7/2/2565 BE.
//
//"searchResultCount": 3,
//    "searchResult": [
//        {
//            "username": "loongallday",
//            "email": "rungallday@gmail.com",
//            "profilePictureLink": null
//        },
//        {
//            "username": "loong",
//            "email": "loong@email.com",
//            "profilePictureLink": "https://firebasestorage.googleapis.com:443/v0/b/appetite-81c95.appspot.com/o/21C0E1B0-016E-4C1D-AC15-E764C54EFBB8?alt=media&token=28591bfc-1019-4872-9b8b-de5d13801204"
//        },
//        {
//            "username": "loong2",
//            "email": "loong2@email.com",
//            "profilePictureLink": null
//        }
//    ]
//}

import Foundation

struct SearchResult:Codable {
    var searchResultCount:Int
    var searchResult:[SearchResultDetails]
}
