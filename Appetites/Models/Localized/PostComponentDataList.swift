//
//  PostComponentDataList.swift
//  Appetites
//
//  Created by Ghandhi Thamthiwat on 8/2/2565 BE.
//

import Foundation

struct PostComponentDataList {
    var posts:[PostComponentData]
}

var postdata: [PostComponentData] = [
    PostComponentData(
        ownerpic: "photo-arm",
        ownername: "armi4d",
        datetime: "4 April 2022",
        caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip.",
        foodpicture: "photo-steak",
        likestatus: false,
        likecount: 43,
        commentcount: 5,
        userpic: "photo-loong"
    ),
    PostComponentData(
        ownerpic: "photo-steak",
        ownername: "loongallday",
        datetime: "15 June 2022",
        caption: "Hi there.",
        foodpicture: "photo-1",
        likestatus: false,
        likecount: 144,
        commentcount: 2,
        userpic: "photo-loong"
    ),
    PostComponentData(
        ownerpic: "photo-owen",
        ownername: "lalitr",
        datetime: "17 June 2018",
        caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip.",
        foodpicture: "photo-3",
        likestatus: false,
        likecount: 9,
        commentcount: 6,
        userpic: "photo-loong"
    )
]
