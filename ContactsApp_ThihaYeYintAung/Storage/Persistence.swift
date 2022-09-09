//
//  Persistence.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 7/9/22.
//

import CoreData

//struct PersistenceController {
//    static let shared = PersistenceController()
//
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<5 {
//            let newContact = Contact(context: viewContext)
//            newContact.firstname = "Thiha"
//            newContact.lastname = "Ye Yint Aung"
//            newContact.phone = "86180253"
//            newContact.email = "thihayeyintaung110919@gmail.com"
//            newContact.id = UUID()
//            newContact.created_date = Date()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()
//
//    let container: NSPersistentContainer
//
//    init(inMemory: Bool = false) {
//        container = NSPersistentContainer(name: "ContactApp")
//        if inMemory {
//            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
//        }
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        container.viewContext.automaticallyMergesChangesFromParent = true
//    }
//
//    func newTaskContext() -> NSManagedObjectContext {
//        // Create a private queue context.
//        /// - Tag: newBackgroundContext
//        let taskContext = container.newBackgroundContext()
//        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//        // Set unused undoManager to nil for macOS (it is nil by default on iOS)
//        // to reduce resource requirements.
//        taskContext.undoManager = nil
//        return taskContext
//    }
//}
