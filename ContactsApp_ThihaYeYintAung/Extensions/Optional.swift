//
//  Optional.swift
//  ContactsApp_ThihaYeYintAung
//
//  Created by Thiha Ye Yint Aung on 8/9/22.
//

import Foundation

extension Optional where Wrapped: Collection {

    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }
}

/*
let optionalString: String? = ""
print(optionalString.isEmptyOrNil) // prints: true

let optionalArray: Array<Int>? = [10, 22, 3]
print(optionalArray.isEmptyOrNil) // prints: false
*/
