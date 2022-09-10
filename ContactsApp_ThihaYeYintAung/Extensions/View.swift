//
//  View.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 9/9/22.
//

import SwiftUI

extension View {
    @ViewBuilder
    public func thumbnail(from string: String, width: CGFloat, height: CGFloat, strokeWidth: CGFloat) -> some View {
        AsyncImage(url: URL(string: string.isEmpty ? "uxwjqmlgtuk" : string)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .progressViewStyle(.circular)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            default:
                Circle()
            }
        }
        .frame(width: width, height: height)
        .background(Color.black)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white, lineWidth:strokeWidth).shadow(radius: 8))
    }
    
    public func subInfo(title: String, source: String?, value: Binding<String>, validate: @escaping (String?, String) -> Void) -> some View {
        HStack(spacing: 20) {
            Text(title)
                .foregroundColor(.secondary)
                .alignmentGuide(.trailingPhoneAndEmail) { d in d[HorizontalAlignment.trailing] }
                .padding(.leading, 8)
            
            VStack {
                TextField("", text: value)
                    .onChange(of: value.wrappedValue) { new in
                        validate(source, new)
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
