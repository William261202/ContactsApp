//
//  ContactsApp_ThihaYeYintAungApp.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 7/9/22.
//

import SwiftUI

@main
struct ContactsApp_ThihaYeYintAungApp: App {
    let viewContext = ContactsProvider.shared.container.viewContext

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
