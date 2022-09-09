//
//  ContactEditView.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 9/9/22.
//

import SwiftUI

struct ContactEditView: View {
    let contact: Contact
    
    @State private var textInput = ""
    
    var body: some View {
        VStack(spacing: 16) {
            thumbnail(from: contact.avatar ?? "", width: 150, height: 150)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(LinearGradient(colors: [Color.white, Color(ColorsSaved.neonGreen)], startPoint: .top, endPoint: .bottom))
                
            information
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    var information: some View {
            VStack(alignment: .trailingPhoneAndEmail, spacing: 16) {
                subInfo(title: "First Name")
                subInfo(title: "Last Name")
                subInfo(title: "mobile")
                subInfo(title: "email")
            }
            .font(.system(size: 18))
            .padding(.horizontal, 20)
    }
    
    private func subInfo(title: String) -> some View {
        HStack(spacing: 20) {
            Text(title)
                .foregroundColor(.secondary)
                .alignmentGuide(.trailingPhoneAndEmail) { d in d[HorizontalAlignment.trailing] }
                .padding(.leading, 8)
            
            VStack {
                TextField("", text: $textInput)
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
