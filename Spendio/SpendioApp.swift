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
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            if !authenticationViewModel.isUnlocked && authenticationViewModel.settingsViewModel.useAuthentication {
                Text("Authentication Canceled").font(.title2)
                    .onAppear {
                        authenticationViewModel.authenticate()
                    }
            } else if !authenticationViewModel.isUnlocked{
                MainView()
                    .withErrorHandling()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            if authenticationViewModel.isUnlocked {
                MainView()
                    .withErrorHandling()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
