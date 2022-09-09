//
//  ContactEditView.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 9/9/22.
//

import SwiftUI

struct ContactEditView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    
    @State var saveDisabled = true
        
    let contact: Contact
    
    init(contact: Contact) {
        self.contact = contact
        _firstName = .init(wrappedValue: contact.first_name ?? "")
        _lastName = .init(wrappedValue: contact.last_name ?? "")
        _phone = .init(wrappedValue: contact.phone ?? "")
        _email = .init(wrappedValue: contact.email ?? "")
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                thumbnail(from: contact.avatar ?? "", width: 150, height: 150)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(colors: [Color.white, Color(ColorsSaved.neonGreen)], startPoint: .top, endPoint: .bottom))
                    
                information
                    .frame(maxHeight: .infinity, alignment: .top)
            }
            .navigationBarTitle("Edit Contact", displayMode: .inline)
            .navigationBarItems(leading: Button(action: cancelEntry) {
                Text("Cancel")
            }, trailing: Button(action: save) {
                Text("Save")
            }
            .disabled(saveDisabled))
        }
    }
          
    private func cancelEntry() {
        presentation.wrappedValue.dismiss()
    }
    
    private func save() {
        withAnimation {
            // Update entity properties as needed
            contact.first_name = firstName
            contact.last_name = lastName
            contact.phone = phone
            contact.email = email
            contact.modified_date = Date()

            do {
                try viewContext.save()
                
                presentation.wrappedValue.dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
          
    var information: some View {
            VStack(alignment: .trailingPhoneAndEmail, spacing: 16) {
                subInfo(title: "First Name", source: contact.first_name, value: $firstName)
                subInfo(title: "Last Name", source: contact.last_name, value: $lastName)
                subInfo(title: "mobile", source: contact.phone, value: $phone)
                subInfo(title: "email", source: contact.email, value: $email)
            }
            .font(.system(size: 18))
            .padding(.horizontal, 20)
    }
    
    private func subInfo(title: String, source: String?, value: Binding<String>) -> some View {
        HStack(spacing: 20) {
            Text(title)
                .foregroundColor(.secondary)
                .alignmentGuide(.trailingPhoneAndEmail) { d in d[HorizontalAlignment.trailing] }
                .padding(.leading, 8)
            
            VStack {
                TextField("", text: value)
                    .onChange(of: value.wrappedValue) { new in
                        validateFields(compare: source, to: new)
                    }
                    .frame(height: 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
            }
            .frame(maxWidth: 250, alignment: .leading)
        }
        .padding(.vertical, 8)
    }
    
    func validateFields(compare old: String?, to new: String?) {
        if new.isEmptyOrNil || new == old {
            saveDisabled = true
            return
        }
        saveDisabled = false
    }
}

struct ContactEditView_Previews: PreviewProvider {
    static var previews: some View {
        ContactEditView(contact: .preview)
    }
}
