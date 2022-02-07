//
//  CoreDataManager.swift
//  Appetites
//
//  Created by chavin Panicharoen on 4/2/2565 BE.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    
    var container:NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Appetites")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading PERSISTENCE \(error)")
            } else {
                print("CoreData Initiated")
            }
        }
    }
    
    deinit {
        print("Coredata deinitiated")
    }
}
