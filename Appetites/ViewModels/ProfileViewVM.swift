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
    
    
    init() {
    }

    deinit {
    }
}

