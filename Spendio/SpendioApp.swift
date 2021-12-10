//
//  SpendioApp.swift
//  Spendio
//
//  Created by Hasan Khalaf on 2021-11-19.
//

import SwiftUI

@main
struct SpendioApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .withErrorHandling()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
