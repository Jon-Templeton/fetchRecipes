//
//  fetchRecipesApp.swift
//  fetchRecipes
//
//  Created by Jon Templeton on 10/31/24.
//

import SwiftUI

@main
struct fetchRecipesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
