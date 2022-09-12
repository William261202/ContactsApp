//
//  Thumbnail.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 11/9/22.
//

import SwiftUI

struct Thumbnail: View {
    let urlString: String
    let width: CGFloat
    let height: CGFloat
    let strokeWidth: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: urlString.isEmpty ? "uxwjqmlgtuk" : urlString)) { phase in
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
}
