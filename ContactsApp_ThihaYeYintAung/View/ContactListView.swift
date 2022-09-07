//
//  ContentView.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 7/9/22.
//

import SwiftUI
import CoreData

struct ContactListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Contact.firstname, ascending: true),
                          NSSortDescriptor(keyPath: \Contact.created_date, ascending: true)],
        animation: .default)
    private var contacts: FetchedResults<Contact>

    var body: some View {
        NavigationView {
            List {
                ForEach(contacts) { contact in
                    NavigationLink {
                        Text("Item at \(contact.created_date!, formatter: itemFormatter)")
                    } label: {
                        VStack(alignment: .leading) {
                            Text("Name: \(contact.firstname! + contact.lastname!)")
                            Text("Created Date: ") + Text(contact.created_date!, formatter: itemFormatter)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newContact = Contact(context: viewContext)
            newContact.firstname = "Thiha"
            newContact.lastname = "Ye Yint Aung"
            newContact.phone = "86180253"
            newContact.email = "thihayeyintaung110919@gmail.com"
            newContact.id = UUID()
            newContact.created_date = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { contacts[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
