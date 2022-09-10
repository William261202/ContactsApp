//
//  ContactRowView.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 9/9/22.
//

import SwiftUI

struct ContactRowView: View {
    let contact: Contact
    let fullName: String
   
    init(contact: Contact) {
        self.contact = contact
        self.fullName = contact.fullName
    }
    
    var body: some View {
        HStack(spacing: 16) {
            thumbnail(from: contact.avatar ?? "", width: 60, height: 60, strokeWidth: 4)
                .padding(4)
            
            Text(fullName)
                .font(.title3.bold())
        }
    }
    
   
}

struct ContactRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContactRowView(contact: .preview)
    }
}
