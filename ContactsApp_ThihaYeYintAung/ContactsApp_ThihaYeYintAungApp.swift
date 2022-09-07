//
//  ContactsApp_ThihaYeYintAungApp.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 7/9/22.
//

import SwiftUI

@main
struct ContactsApp_ThihaYeYintAungApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
