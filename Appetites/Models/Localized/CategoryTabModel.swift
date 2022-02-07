//
//  DiscoverTab.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct CategoryTabModel:Identifiable {
    var id = UUID()
    var text: String
    var tab:DiscoverCategory
}

var categoryTabItems = [
    CategoryTabModel(text: "Steak", tab:.steak),
    CategoryTabModel(text: "Drinks", tab:.drinks),
    CategoryTabModel(text: "Snacks", tab:.snacks),
    CategoryTabModel(text: "Ramen", tab:.ramen),
    CategoryTabModel(text: "Noodle", tab:.noodle),
    CategoryTabModel(text: "European", tab:.european),
    CategoryTabModel(text: "Mediterranean", tab:.mediterranean)
]

enum DiscoverCategory:String {
    case steak
    case drinks
    case snacks
    case ramen
    case noodle
    case european
    case mediterranean
}
