//
//  Alignment.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 9/9/22.
//

import Foundation
import SwiftUI

extension HorizontalAlignment {
    struct TrailingPhoneAndEmail: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[HorizontalAlignment.leading]
        }
    }

    static let trailingPhoneAndEmail = HorizontalAlignment(TrailingPhoneAndEmail.self)
}
