//
//  ContactDetailView.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 9/9/22.
//

import SwiftUI

struct ContactDetailView: View {
    let contact: Contact
    
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
    }
    
    var profile: some View {
        VStack(spacing: 8) {
            thumbnail(from: contact.avatar ?? "", width: 150, height: 150)
                //.frame(width: 150, height: 150)
            
            Text(contact.fullName)
                .font(.title2.bold())
        }
    }
    
    var communicationIcons: some View {
        HStack(spacing: 25) {
            CommunicationIcon(title: "message", symbol: "message.fill", fontSize: 20)
//            Spacer()
            CommunicationIcon(title: "call", symbol: "phone.fill", fontSize: 20)
//            Spacer()
            CommunicationIcon(title: "email", symbol: "envelope.fill", fontSize: 20)
//            Spacer()
            CommunicationIcon(title: "favorite", symbol: "star.fill", fontSize: 20)
        }
//        .padding(.horizontal, 30)
    }
    
    var information: some View {
        ZStack {
            VStack(alignment: .trailingPhoneAndEmail, spacing: 16) {
                HStack(spacing: 20) {
                    Text("mobile")
                        .foregroundColor(.secondary)
                        .alignmentGuide(.trailingPhoneAndEmail) { d in d[HorizontalAlignment.trailing] }
                        .padding(.leading, 8)

                    Text(contact.phone ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.vertical, 8)
                
                HStack(spacing: 20) {
                    Text("email")
                        .foregroundColor(.secondary)
                        .alignmentGuide(.trailingPhoneAndEmail) { d in d[HorizontalAlignment.trailing] }
                        .padding(.leading, 8)
                    
                    Text(contact.email ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.vertical, 8)
            }
            .font(.system(size: 18))
            
            Divider()
        }
        .padding(.horizontal, 20)
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetailView(contact: .preview)
    }
}
