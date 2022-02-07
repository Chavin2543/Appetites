//
//  SettingViewVM.swift
//  Appetites
//
//  Created by chavin Panicharoen on 4/2/2565 BE.
//

import Foundation

class SettingViewVM: ObservableObject {
    
    @Published var inSettings:Bool = false
    @Published var inCalendar:Bool = false

    
    init() {
    }
    
    deinit{
    }
    
}

