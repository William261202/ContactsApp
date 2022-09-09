//
//  Contact+CoreDataProperties.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 8/9/22.
//

import Foundation
import CoreData
import SwiftUI

extension Contact {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<Contact> {
        NSFetchRequest<Contact>(entityName: "Contact")
    }
    
    @NSManaged public var first_name: String?
    @NSManaged public var last_name: String?
    @NSManaged public var phone: String?
    @NSManaged public var email: String?
    @NSManaged public var id: Int
    @NSManaged public var created_date: Date
    @NSManaged public var modified_date: Date?
    @NSManaged public var avatar: String?
    
    public var fullName: String {
        if let fName = first_name, let lName = last_name {
            return fName + " " + lName
        }
        return ""
    }
}

extension Contact: Identifiable { }

extension Contact {
    /// An earthquake for use with canvas previews.
    static var preview: Contact {
        let quakes = Contact.makePreviews(count: 1)
        return quakes[0]
    }

    @discardableResult
    static func makePreviews(count: Int) -> [Contact] {
        var contacts = [Contact]()
        let viewContext = ContactsProvider.preview.container.viewContext
        for index in 0..<count {
            let newContact = Contact(context: viewContext)
            newContact.first_name = "Thiha"
            newContact.last_name = "Ye Yint Aung"
            newContact.phone = "86180253"
            newContact.email = "thihayeyintaung110919@gmail.com"
            newContact.avatar = "https://reqres.in/img/faces/1-image.jpg"
            newContact.id = index
            newContact.created_date = Date()
            contacts.append(newContact)
        }
        return contacts
    }
}

/*
extension Contact {
    var thumbnail: UIImage? {
        get async throws {
            guard let avatar = avatar, let url = URL(string: avatar) else {
                return nil
            }
            let (data, response) = try await URLSession.shared.data(from: url)
            
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw ContactError.thumbnailError
            }
            guard let image = UIImage(data: data) else {
                throw ContactError.thumbnailError
            }
            
            return image
        }
    }
}
*/
