//
//  TravlApp.swift
//  Travl
//
//  Created by iPHTech 34 on 15/07/26.
//

import SwiftUI
import CoreData

@main
struct TravlApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
