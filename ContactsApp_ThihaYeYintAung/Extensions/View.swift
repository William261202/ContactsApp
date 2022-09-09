//
//  View.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 9/9/22.
//

import SwiftUI

extension View {
    @ViewBuilder
    func thumbnail(from string: String, width: CGFloat, height: CGFloat) -> some View {
        AsyncImage(url: URL(string: string)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .progressViewStyle(.circular)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: width, height: height)
        .background(Color.white)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white,lineWidth:4).shadow(radius: 8))
    }
}
