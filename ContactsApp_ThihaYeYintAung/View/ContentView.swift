//
//  ContentView.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 7/9/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var contactsProvider: ContactsProvider = .shared
    
    @AppStorage("lastUpdated")
    private var lastUpdated = Date.distantFuture.timeIntervalSince1970

    @FetchRequest(sortDescriptors: [SortDescriptor(\.first_name, order: .forward),
                                    SortDescriptor(\.created_date, order: .forward)])
    private var contacts: FetchedResults<Contact>
    
    @State private var isLoading = false
    @State private var error: ContactError?
    @State private var hasError = false

    var body: some View {
        NavigationView {
            List {
                ForEach(contacts) { contact in
                    NavigationLink {
                        ContactDetailView(contact: contact)
                    } label: {
                        ContactRowView(contact: contact)
                    }
                }
//                .onDelete(perform: deleteItems)
            }
            .listStyle(.inset)
            .navigationTitle("Contacts")
            .navigationBarTitleDisplayMode(.inline)
            #if os(iOS)
            .refreshable {
                await fetchQuakes()
            }
            #endif
            Text("Select an item")
        }
    }
    
//    private func addItem() {
//        withAnimation {
//            let newContact = Contact(context: contactsProvider.container.viewContext)
//            newContact.first_name = "Thiha"
//            newContact.last_name = "Ye Yint Aung"
//            newContact.phone = "86180253"
//            newContact.email = "thihayeyintaung110919@gmail.com"
//            newContact.id = UUID()
//            newContact.created_date = Date()
//
//            do {
//                try contactsProvider.container.viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

extension ContentView {
    private func fetchQuakes() async {
        isLoading = true
        do {
            try await contactsProvider.fetchQuakes()
            lastUpdated = Date().timeIntervalSince1970
        } catch {
            self.error = error as? ContactError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        isLoading = false
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, ContactsProvider.shared.container.viewContext)
    }
}
