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
            ContactEditView(contact: contact)
        }
    }
    
    var profile: some View {
        VStack(spacing: 8) {
            Thumbnail(urlString: contact.avatar ?? "", width: 150, height: 150, strokeWidth: 8)
            
            Text(contact.fullName)
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
            subInfo(title: "mobile", value: contact.phone ?? "")
            
            subInfo(title: "email", value: contact.email ?? "")
        }
        .font(.system(size: 18))
        .padding(.horizontal, 20)
    }
    
    private func subInfo(title: String, value: String) -> some View {
        HStack(spacing: 20) {
            Text(title)
                .foregroundColor(.secondary)
                .alignmentGuide(.trailingPhoneAndEmail) { d in d[HorizontalAlignment.trailing] }
                .padding(.leading, 8)
            
            VStack {
                Text(value)
                    .frame(height: 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
            }
            .frame(maxWidth: 250, alignment: .leading)
        }
        .padding(.vertical, 8)
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetailView(contact: .preview)
    }
}
