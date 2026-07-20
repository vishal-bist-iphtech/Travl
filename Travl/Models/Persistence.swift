//
//  Persistence.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static let preview = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Travl")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
