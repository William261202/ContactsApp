//
//  SubInfo.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 11/9/22.
//

import SwiftUI

struct SubInfo: View {
    let title: String
    let source: String?
    let value: Binding<String>
    let validate: ((String?, String) -> Void)?

    var body: some View {
        HStack(spacing: 20) {
            Text(title)
                .foregroundColor(.secondary)
                .alignmentGuide(.trailingPhoneAndEmail) { d in d[HorizontalAlignment.trailing] }
                .padding(.leading, 8)
            
            VStack {
                TextField("", text: value)
                    .onChange(of: value.wrappedValue) { new in
                        if let validate = validate {
                            validate(source, new)
                        }
                        return
                        //validateFields(compare: source, to: new)
                    }
                    .frame(height: 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
            }
            .frame(maxWidth: 250, alignment: .leading)
        }
        .padding(.vertical, 8)
    }
}
