//
//  FirebaseManager.swift
//  Appetites
//
//  Created by chavin Panicharoen on 10/2/2565 BE.
//

import Foundation
import Firebase

class FirebaseManager: NSObject {
    
    let storage:Storage
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.storage = Storage.storage()
        
        super.init()
    }
}
