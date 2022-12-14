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
    
    @State private var isAddPresented = false

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
            }
            .listStyle(.inset)
            .navigationTitle("Contacts")
            .navigationBarTitleDisplayMode(.inline)
//            .task {
//                await fetchContacts()
//            }
            .toolbar(content: toolbarContent)
            .fullScreenCover(isPresented: $isAddPresented) {
                ContactAddView()
            }
            #if os(iOS)
            .refreshable {
                await fetchContacts()
            }
            #endif
            Text("Select a contact")
        }
    }
}

extension ContentView {
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                isAddPresented.toggle()
            }, label: {
                Image(systemName: "plus")
                    .imageScale(.large)
            })
        }

        ToolbarItemGroup(placement: .bottomBar) {
            RefreshButton {
                Task {
                    await fetchContacts()
                }
            }

            Spacer()
            ToolbarStatus(
                isLoading: isLoading,
                lastUpdated: lastUpdated,
                contactsCount: contacts.count
            )
            Spacer()
        }
    }

}

extension ContentView {
    private func fetchContacts() async {
        isLoading = true
        do {
            try await contactsProvider.fetchContacts()
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
