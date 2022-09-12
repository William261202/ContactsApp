//
//  ContactDetailView.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 9/9/22.
//

import SwiftUI

struct ContactDetailView: View {
    let contact: Contact
    @State private var isEditPresented = false
    
    @State private var detailInput: DetailInput
    
    init(contact: Contact) {
        self.contact = contact
        _detailInput = .init(
            wrappedValue: DetailInput(firstName: contact.first_name ?? "",
                                      lastName: contact.last_name ?? "",
                                      phone: contact.phone ?? "",
                                      email: contact.email ?? ""))
    }
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 30) {
                profile
                communicationIcons
            }
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(LinearGradient(colors: [Color.white, Color(ColorsSaved.neonGreen)], startPoint: .top, endPoint: .bottom))
            
            information
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .toolbar {
            Button(action: {
                isEditPresented.toggle()
            }, label: {
                Text("Edit")
            })
        }
        .fullScreenCover(isPresented: $isEditPresented) {
            ContactEditView(contact: contact,
                            detailInput: $detailInput)
        }
    }
    
    var profile: some View {
        VStack(spacing: 8) {
            Thumbnail(urlString: contact.avatar ?? "", width: 150, height: 150, strokeWidth: 8)
            
            Text("\(detailInput.firstName) \(detailInput.lastName)")
                .font(.title2.bold())
        }
    }
    
    var communicationIcons: some View {
        HStack(spacing: 25) {
            CommunicationIcon(title: "message", symbol: "message.fill", fontSize: 20)
            CommunicationIcon(title: "call", symbol: "phone.fill", fontSize: 20)
            CommunicationIcon(title: "email", symbol: "envelope.fill", fontSize: 20)
            CommunicationIcon(title: "favorite", symbol: "star.fill", fontSize: 20)
        }
    }
    
    var information: some View {
        VStack(alignment: .trailingPhoneAndEmail, spacing: 16) {
            SubInfo(title: "mobile", source: nil, value: $detailInput.phone, validate: nil)
            
            SubInfo(title: "email", source: nil, value: $detailInput.email, validate: nil)
        }
        .disabled(true)
        .font(.system(size: 18))
        .padding(.horizontal, 20)
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetailView(contact: .preview)
    }
}
