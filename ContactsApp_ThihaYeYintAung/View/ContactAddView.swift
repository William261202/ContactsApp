//
//  ContactAddView.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 10/9/22.
//

import SwiftUI

struct ContactAddView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var viewContext
    
    @AppStorage(ContactsProvider.PKKey)
    private var PKValue = 0
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    
    @State var saveDisabled = true
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Circle()
                    .frame(width: 150, height: 150)
                    .background(Circle().stroke(Color.white,lineWidth:8).shadow(radius: 8))
                    .padding(.vertical, 16)
                    .padding(.bottom, 8)
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(colors: [Color.white, Color(ColorsSaved.neonGreen)], startPoint: .top, endPoint: .bottom))
                    
                information
                    .frame(maxHeight: .infinity, alignment: .top)
            }
            .navigationBarTitle("Add Contact", displayMode: .inline)
            .navigationBarItems(
                leading: cancelButton,
                trailing: saveButton
            .disabled(saveDisabled || firstName.isEmpty || lastName.isEmpty))
            .alert("Added!", isPresented: $showingConfirmation) {
                Button("OK") { presentation.wrappedValue.dismiss() }
            } message: {
                Text(confirmationMessage)
            }
        }
    }
          
    private func cancelEntry() {
        
    }
    
    private var cancelButton: some View {
        Button {
            presentation.wrappedValue.dismiss()
        } label: {
            Text("Cancel")
        }
    }
    
    private var saveButton: some View {
        Button {
            Task { await save() }
        } label: {
            Text("Save")
        }
    }
    
    private func addContact() throws {
        let newContact = Contact(context: viewContext)
        newContact.first_name = firstName
        newContact.last_name = lastName
        newContact.phone = phone
        newContact.email = email
        newContact.id = PKValue + 1
        newContact.created_date = Date()

        try viewContext.save()
        
        PKValue += 1
    }
    
    func save() async {
        let userDetail = UserDetail(id: PKValue + 1, email: email, firstName: firstName, lastName: lastName, avatar: "")
        guard let encoded = try? JSONEncoder().encode(userDetail) else {
            print("Failed to encode a contact")
            return
        }

        let url = URL(string: "https://reqres.in/api/users")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedUser = try JSONDecoder().decode(UserDetail.self, from: data)
            
            try addContact()
            
            confirmationMessage = "Contact ID: \(decodedUser.id) \(decodedUser.firstName ?? "") \(decodedUser.lastName ?? "") is successfully updated!"
            showingConfirmation = true
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
          
    var information: some View {
            VStack(alignment: .trailingPhoneAndEmail, spacing: 16) {
                SubInfo(title: "First Name", source: nil, value: $firstName, validate: validateFields)
                SubInfo(title: "Last Name", source: nil, value: $lastName, validate: validateFields)
                SubInfo(title: "mobile", source: nil, value: $phone, validate: validateFields)
                    .disabled(true)
                SubInfo(title: "email", source: nil, value: $email, validate: validateFields)
            }
            .font(.system(size: 18))
            .padding(.horizontal, 20)
    }
    
    func validateFields(compare old: String?, to new: String?) {
        if new.isEmptyOrNil || new == old {
            saveDisabled = true
            return
        }
        saveDisabled = false
    }
}

struct ContactAddView_Previews: PreviewProvider {
    static var previews: some View {
        ContactAddView()
    }
}
