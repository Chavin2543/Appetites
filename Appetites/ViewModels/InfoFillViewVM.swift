//
//  InfoFillViewVM.swift
//  Appetites
//
//  Created by chavin Panicharoen on 10/2/2565 BE.
//

import Foundation
import SwiftUI
import Combine

class InfoFillViewVM : ObservableObject {
    @Published var showImagePicker = false
    @Published var newUsername:String = ""
    init(){
        
    }
    
    deinit{
    }
}
