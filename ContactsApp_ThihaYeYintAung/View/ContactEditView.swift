//
//  ContactEditView.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 9/9/22.
//

import SwiftUI

struct ContactEditView: View {
    @Environment(\.presentationMode) var presentation
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    
    let avatar: String?
    
    init(contact: Contact) {
        avatar = contact.avatar
        _firstName = .init(wrappedValue: contact.first_name ?? "")
        _lastName = .init(wrappedValue: contact.last_name ?? "")
        _phone = .init(wrappedValue: contact.phone ?? "")
        _email = .init(wrappedValue: contact.email ?? "")
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                thumbnail(from: avatar ?? "", width: 150, height: 150)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(colors: [Color.white, Color(ColorsSaved.neonGreen)], startPoint: .top, endPoint: .bottom))
                    
                information
                    .frame(maxHeight: .infinity, alignment: .top)
            }
            .navigationBarTitle("Edit Contact", displayMode: .inline)
            .navigationBarItems(leading: Button(action: cancelEntry) {
                Text("Cancel")
                    .foregroundColor(.black)
            }, trailing: Button(action: {}) {
                Text("Save")
                    .foregroundColor(.black)
            })
        }
    }
          
    func cancelEntry() {
        presentation.wrappedValue.dismiss()
    }
          
    var information: some View {
            VStack(alignment: .trailingPhoneAndEmail, spacing: 16) {
                subInfo(title: "First Name", value: $firstName)
                subInfo(title: "Last Name", value: $lastName)
                subInfo(title: "mobile", value: $phone)
                subInfo(title: "email", value: $email)
            }
            .font(.system(size: 18))
            .padding(.horizontal, 20)
    }
    
    private func subInfo(title: String, value: Binding<String>) -> some View {
        HStack(spacing: 20) {
            Text(title)
                .foregroundColor(.secondary)
                .alignmentGuide(.trailingPhoneAndEmail) { d in d[HorizontalAlignment.trailing] }
                .padding(.leading, 8)
            
            VStack {
                TextField("", text: value)
                    .frame(height: 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
            }
            .frame(maxWidth: 250, alignment: .leading)
        }
        .padding(.vertical, 8)
    }
}

struct ContactEditView_Previews: PreviewProvider {
    static var previews: some View {
        ContactEditView(contact: .preview)
    }
}
