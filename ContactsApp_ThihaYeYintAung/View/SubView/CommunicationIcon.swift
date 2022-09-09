//
//  CommunicationView.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 9/9/22.
//

import SwiftUI

struct CommunicationIcon: View {
    let title: String
    let symbol: String
    let fontSize: CGFloat
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Image(systemName: symbol)
                .imageScale(.large)
                .foregroundColor(.white)
                .font(.system(size: fontSize))
                .padding(8)
                .background(Color.green)
                .clipShape(Circle())
            
            Text(title)
        }
    }
}
