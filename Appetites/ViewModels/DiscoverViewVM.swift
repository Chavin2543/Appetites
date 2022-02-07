//
//  DiscoverViewVM.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import Foundation



class DiscoverViewVM: ObservableObject {
    @Published var isSearcing:Bool = false
    
    
    init() {
        print("Hello")
    }
    
    func search() {
        isSearcing = true
    }
    
    deinit{
    }
}

